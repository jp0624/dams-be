var connection = require('./connection');

var sqlClean = require('./_sql_clean');

module.exports.getAllVehicles = function (callback) {
    connection.query(`
        SELECT *
            FROM vehicle
    `, callback);
}

module.exports.findVehicle = function (params, callback) {
    sqlClean.escapeObjectStrings(params);
    connection.query(`
            SELECT *
                FROM vehicle
            WHERE vehicle_id = '` + params.id + `'
        `, callback);
}

module.exports.updateVehicle = function (data, callback) {
    sqlClean.escapeObjectStrings(data);
    console.log('SQL VEHICLE UPDATE REQUEST: ', data)
    connection.query(`
            UPDATE vehicle
                SET code = '` + data.code + `',
                    name = '` + data.name + `',
                    description = '` + data.description + `'
            WHERE vehicle_id = '` + data.vehicle_id + `'
        `, callback);
}

module.exports.createVehicle = function (data, callback) {
    sqlClean.escapeObjectStrings(data);
    console.log('SQL VEHICLE CREATE REQUEST: ', data)
    connection.query(`
            INSERT INTO vehicle
                SET name = '` + data.name + `',
                    code = '` + data.code + `',
                    description = '` + data.description + `'
        `, data, callback);
}

module.exports.delete = function (params, callback) {
    sqlClean.escapeObjectStrings(params);
    console.log('SQL VEHICLE DELETE REQUEST: ', params);
    connection.query(`DELETE FROM vehicle WHERE vehicle_id = ` + params.id, callback);
}