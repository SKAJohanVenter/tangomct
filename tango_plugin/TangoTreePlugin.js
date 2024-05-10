/**
 * Basic Realtime telemetry plugin using websockets.
 */

const display_elements = {
  "name": "LMC",
  "key": "lmc",
  "measurements": [
    {
      "name": "Test double scalar",
      "deviceName": "sys/tg_test/1/double_scalar",
      "key": "sys.tg_test.1.double_scalar",
      "values": [
        {
          "key": "value",
          "name": "Value",
          "format": "float",
          "hints": {
            "range": 1
          }
        },
        {
          "key": "utc",
          "source": "timestamp",
          "name": "Timestamp",
          "format": "utc",
          "hints": {
            "domain": 1
          }
        }
      ]
    }
]
};



function getLMCDictionary() {
  let a = new Promise(function(myResolve, myReject) {
      myResolve(display_elements);
      myReject();  // when error
    });
  return a;
}

var LMCObjectProvider = {
  get: function (identifier) {
    return getLMCDictionary().then(function (dictionary) {
      if (identifier.key === 'lmc') {
        return {
          identifier: identifier,
          name: dictionary.name,
          type: 'folder',
          location: 'ROOT'
        };
      }
      else {
          var measurement = dictionary.measurements.filter(function (m) {
              return m.key === identifier.key;
          })[0];
          return {
              identifier: identifier,
              name: measurement.name,
              type: 'example.telemetry',
              telemetry: {
                  values: measurement.values
              },
              location: 'example.taxonomy:lmc'
          };
      }
    });
  }
};

var compositionProvider = {
  appliesTo: function (domainObject) {
      return domainObject.identifier.namespace === 'example.taxonomy' &&
             domainObject.type === 'folder';
  },
  load: function (domainObject) {
      return getLMCDictionary()
          .then(function (dictionary) {
              return dictionary.measurements.map(function (m) {
                  return {
                      namespace: 'example.taxonomy',
                      key: m.key
                  };
              });
          });
  }
};


export default function (options) {
  return function (openmct) {
      openmct.objects.addRoot({
          namespace: 'example.taxonomy',
          key: 'lmc'
      });
      openmct.objects.addProvider('example.taxonomy', LMCObjectProvider);
      openmct.composition.addProvider(compositionProvider);
      openmct.types.addType('example.telemetry', {
          name: 'Example Telemetry Point',
          description: 'Example telemetry point from our happy tutorial.',
          cssClass: 'icon-telemetry'
      });
  }
}
