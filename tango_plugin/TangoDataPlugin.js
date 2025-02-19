import { addMeasurement, addFolder } from './state.js';

export default function(options) {
    return function(openmct) {
        const socket = new WebSocket('ws://127.0.0.1:5004/socket', 'graphql-ws');
        var listener = {};
        var subscribedTelemetries = new Set();

        socket.onopen = () => {
            socket.send(JSON.stringify({
                type: "start",
                payload: {
                    query: `
                        query {
                            devices {
                                name
                                attributes {
                                    name,
                                    datatype,
                                    dataformat,
                                    label,
                                    unit,
                                    description,
                                    value,
                                    quality,
                                    timestamp,
                                    enumLabels
                                }
                            }
                        }
                    `
                }
            }));
        };

        socket.onmessage = function(event) {
            var parsedData = JSON.parse(event.data);

            // Handle initial device and attributes response message
            if (parsedData.payload && parsedData.payload.data && parsedData.payload.data.devices) {
                // Add devices and attributes to shared state
                parsedData.payload.data.devices.forEach(device => {
                    if(!device.name.startsWith('dserver/')) {
                        const dotDeviceName = device.name.replaceAll("/", ".");
                        const deviceFolderKey = `folder:${dotDeviceName}`;

                        console.log("Adding measurement: " + device.name)
                        addFolder(deviceFolderKey, device.name, "devices")

                        device.attributes.forEach(attr => {
                            const attrName = `${device.name}/${attr.name}`;
                            const attrKey = `${dotDeviceName}.${attr.name}`;
                            const dataType = attr.datatype.toLowerCase();
                            const dataFormat = attr.dataformat.toLowerCase();
                        
                            // Default telemetry values
                            let values = [
                                {
                                    key: 'value',
                                    name: 'Value',
                                    hints: { range: 1 },
                                },
                                {
                                    key: 'utc',
                                    source: 'timestamp',
                                    name: 'Timestamp',
                                    format: 'utc',
                                    hints: { domain: 1 },
                                },
                            ];

                            // Adjust format based on tango datatype
                            switch (dataType) {
                                case 'devdouble':
                                case 'devfloat':
                                    values[0].format = 'float';
                                    break;
                                case 'devshort':
                                case 'devlong':
                                case 'devlong64':
                                case 'devuchar':
                                case 'devushort':
                                case 'devulong':
                                case 'devulong64':
                                    values[0].format = 'integer';
                                    break;
                                case 'devboolean':
                                    values[0].format = 'boolean';
                                    break;
                                case 'devenum':
                                    if(attr.enumLabels.length > 0) {
                                        values[0].format = 'enum';
                                        values[0]["enumerations"] = []
                                        for(let i = 0; i < attr.enumLabels.length; ++i) {
                                            values[0]["enumerations"].push({
                                                "string": attr.enumLabels[i],
                                                "value": i
                                            })
                                        }
                                    } else {
                                        values[0].format = 'string';
                                    }
                                    break;
                                case 'devstring':
                                default:
                                    values[0].format = 'string';
                                    break;
                            }

                            // always display spectrums as strings
                            if (dataFormat === 'spectrum') {
                                values[0].format = "string"
                            }

                            addMeasurement({
                                name: attr.name,
                                deviceName: attrName,
                                key: attrKey.toLowerCase(),
                                location: deviceFolderKey,
                                type: "example.telemetry",
                                values: values,
                            });
                        });
                    }
                });
            }

            // attribute subscription responses
            if (parsedData.payload && parsedData.payload.data && parsedData.payload.data.attributes) {
                var point = {};
                point["value"] = parsedData.payload.data.attributes.value;

                if (Array.isArray(point["value"])) {
                    point["value"] = point["value"].toString();
                }

                point["timestamp"] = parsedData.payload.data.attributes.timestamp * 1000;

                var dotDeviceName = parsedData.payload.data.attributes.device.replaceAll("/", ".")
                point["id"] = dotDeviceName + "." + parsedData.payload.data.attributes.attribute;

                if (listener[point["id"]]) {
                    listener[point["id"]](point);
                }
            }
        };

        var provider = {
            supportsRequest: function(domainObject) {
                return domainObject.type === 'example.telemetry';
            },
            request: function (domainObject, options) {
                const attName = domainObject.identifier.key;
                const postgrestUrl = "http://0.0.0.0:3000";

                console.log('Requesting historical data for:', attName);

                // example options:
                // Object { size: 628, strategy: "minmax", filters: undefined, domain: "utc",
                //  start: 1739951708781, end: 1739953538781 ... }
                // console.log(options)

                return fetch(`${postgrestUrl}/att_conf?att_name=eq.${encodeURIComponent(attName)}`, {
                    method: "GET",
                    headers: { "Accept": "application/json" }
                })
                .then(response => {
                    if (!response.ok) throw new Error(`Failed to fetch att_conf: ${response.statusText}`);
                    return response.json();
                })
                .then(attConfData => {
                    if (attConfData.length === 0) throw new Error(`Attribute ${attName} not found in att_conf`);
            
                    // Extract table name from att_conf response
                    const tableName = attConfData[0].table_name;
            
                    // Step 2: Query the correct table for historical values
                    const query = new URLSearchParams({
                        "att_conf_id": attConfData[0].att_conf_id, // Ensures we're filtering by attribute ID
                        "timestamp=gte": startTime,
                        "timestamp=lte": endTime,
                        "order": "timestamp.asc"
                    });
            
                    return fetch(`${postgrestUrl}/${tableName}?${query.toString()}`, {
                        method: "GET",
                        headers: { "Accept": "application/json" }
                    });
                })
                .then(response => {
                    return { values: [] };
                })
            },
            supportsSubscribe: function(domainObject) {
                return domainObject.type === 'example.telemetry';
            },
            subscribe: function(domainObject, callback) {
                console.log("Domain object:")
                console.log(domainObject);
                let domainObjectKeyLowerCase = domainObject.identifier.key.toLowerCase()
                console.log("Subscribing for: " + domainObject.deviceName + " with key " + domainObjectKeyLowerCase);
                subscribedTelemetries.add(domainObject.deviceName)

                listener[domainObjectKeyLowerCase] = callback;

				let fullNames = '"' + [...subscribedTelemetries].join('","') + '"';

				// subscribe to all the telemetries present in the subscribedTelemetries set
				let mesg = '{"type":"start","payload": {"query": "subscription Attributes($fullNames: [String]!) {  attributes(fullNames: $fullNames) {    device attribute value writeValue timestamp }}","variables":{"fullNames": [' + fullNames + ']}}}'
				socket.send(mesg);

                return function unsubscribe() {
					console.log("Unsubscribing for: " + domainObjectKeyLowerCase);
					delete listener[domainObjectKeyLowerCase];

					subscribedTelemetries.delete(domainObject.deviceName)

					socket.send('{"type":"stop","payload": {"query": "subscription Attributes($fullNames: [String]!) {  attributes(fullNames: $fullNames) {    device attribute value writeValue timestamp }}","variables":{"fullNames":["' + domainObject.deviceName + '"]}}}');
				};
            }
        };
        openmct.telemetry.addProvider(provider);
    }
}