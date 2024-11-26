import { addMeasurement, addFolder } from './state.js';

export default function(options) {
    return function(openmct) {
        const socket = new WebSocket('ws://127.0.0.1:5004/socket');
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
                        addFolder(deviceFolderKey, device.name, "lmc")

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
                console.log('Requesting historical data for:', domainObject.identifier.key);

                // empty historical data at the moment so no error is thrown complaining
                // about no provider existing
                const historicalData = {
                    values: [],
                };

                return Promise.resolve(historicalData);
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