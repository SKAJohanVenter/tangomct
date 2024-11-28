export const display_elements = {
    name: 'Tango Devices',
    key: 'devices',
    measurements: [],
};

export function addMeasurement(measurement) {
    // Avoid duplicates
    if (!display_elements.measurements.some(m => m.key === measurement.key)) {
        display_elements.measurements.push(measurement);
    }
}

export function removeMeasurement(measurementKey) {
    const index = display_elements.measurements.findIndex(m => m.key === measurementKey);
    if (index !== -1) {
        display_elements.measurements.splice(index, 1);
    }
}

export function addFolder(key, name, location) {
    addMeasurement({
        name: name,
        key: key,
        location: location,
        type: "folder",
    });
}
