export default function(options) {
    return function(openmct) {
        const socket = new WebSocket('ws://127.0.0.1:5004/socket', 'graphql-ws');
        var listener = {};

        socket.onopen = () => {
            socket.send('{ "type": "start", "payload": { "query": "subscription Attributes($fullNames: [String]!) {  attributes(fullNames: $fullNames) {    device    attribute    value    writeValue    timestamp  }}", "variables": { "fullNames": ["sys/tg_test/1/double_scalar"] } } }');
        };

        socket.onmessage = function(event) {
            var parsed_data = JSON.parse(event.data);

            var point = {}
            point["value"] = parsed_data.payload.data.attributes.value;
            point["timestamp"] = parsed_data.payload.data.attributes.timestamp * 1000;
            point["id"] = 'sys.tg_test.1.double_scalar';
            listener['sys.tg_test.1.double_scalar'](point)
        };

        var provider = {
            supportsSubscribe: function(domainObject) {
                return domainObject.type === 'example.telemetry';
            },
            subscribe: function(domainObject, callback) {
                listener[domainObject.identifier.key] = callback;
                // socket.send('subscribe ' + domainObject.identifier.key);
                return function unsubscribe() {
                    delete listener[domainObject.identifier.key];
                    // socket.send('unsubscribe ' + domainObject.identifier.key);
                };

            }
        };
        openmct.telemetry.addProvider(provider);
    }
}