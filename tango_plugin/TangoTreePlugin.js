/**
 * Basic Realtime telemetry plugin using websockets.
 */

import { display_elements } from './state.js';

function getLMCDictionary() {
  let a = new Promise(function (myResolve, myReject) {
    myResolve(display_elements)
    myReject() // when error
  })
  return a
}

var LMCObjectProvider = {
  get: function (identifier) {
    return getLMCDictionary().then(function (dictionary) {
      console.log(`Processing identifier: ${identifier.key}`);

      if (identifier.key === 'lmc') {
        return {
          identifier: identifier,
          name: dictionary.name,
          type: 'folder',
          location: 'ROOT',
        };
      } else if (identifier.key.startsWith('folder:')) {
        // const folderName = identifier.key.split(':')[1];

        const measurement = dictionary.measurements.find(m => m.key === identifier.key);

        if (measurement) {
          return {
            identifier: identifier,
            name: measurement.name,
            type: 'folder',
            location: 'example.taxonomy:lmc',
          };
        }
        throw new Error(`Measurement not found for key: ${identifier.key}`);
      } else {
        // Attributes (telemetry points)
        console.log(dictionary.measurements)
        console.log("Looking up identifier:", identifier);
        const measurement = dictionary.measurements.find(m => m.key === identifier.key);
        if (measurement) {
          console.log("Found measurement: ", measurement)
          return {
              identifier: identifier,
              deviceName: measurement.deviceName,
              name: measurement.name,
              type: 'example.telemetry',
              telemetry: {
                  values: measurement.values,
              },
              location: measurement.location,
          };
        }
        throw new Error(`Measurement not found for key: ${identifier.key}`);
    }
    })
  },
}

var compositionProvider = {
  appliesTo: function (domainObject) {
      return (
          domainObject.identifier.namespace === 'example.taxonomy' &&
          domainObject.type === 'folder'
      );
  },
  load: function (domainObject) {
      return getLMCDictionary().then(function (dictionary) {
        let children = [];
        if (domainObject.identifier.key === 'lmc') {
            // Return all device folders
            return dictionary.measurements
                .filter(m => m.type === 'folder') // Ensure we only include folders
                .map(m => ({
                    namespace: 'example.taxonomy',
                    key: m.key,
                }));
        } else if (domainObject.identifier.key.startsWith('folder:')) {
            // Return telemetry points under the specific folder
            return dictionary.measurements
                .filter(m => m.location === domainObject.identifier.key)
                .map(m => ({
                    namespace: 'example.taxonomy',
                    key: m.key,
                }));
        }
        console.log(`Children for ${domainObject.identifier.key}:`, children);
        return children;
      });
  },
};


export default function (options) {
  return function (openmct) {
    openmct.objects.addRoot({
      namespace: 'example.taxonomy',
      key: 'lmc',
    })
    openmct.objects.addProvider('example.taxonomy', LMCObjectProvider)
    openmct.composition.addProvider(compositionProvider)
    openmct.types.addType('example.telemetry', {
      name: 'Telemetry Point',
      description: 'Telemetry point.',
      cssClass: 'icon-telemetry',
      columns: [
        {
          key: "value",
          expandable: true
        }
      ]
    })
    openmct.types.addType('folder', {
      name: 'Folder',
      description: 'A container for organizing objects.',
      cssClass: 'icon-folder',
    });
  }
}
