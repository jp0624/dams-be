var connection = require('./connection');
var sqlClean = require('./_sql_clean');

module.exports.getAllAlerts = function(callback) {
    connection.query(`
        SELECT *
            FROM alert
    `, callback);
}

module.exports.findAlert = function(params, callback) {
    sqlClean.escapeObjectStrings(params);
        connection.query(`
            SELECT *
                FROM alert
            WHERE alert_id = '` + params.id + `'  LIMIT 1
        `, callback);
}

module.exports.updateAlert = function(data, callback) {
    let isActive = (data.is_active) ? 1 : 0;
    sqlClean.escapeObjectStrings(data);
        console.log('SQL Alert UPDATE REQUEST: ', data)
        connection.query(`
            UPDATE alert
                SET name = '` + data.name + `',
                    description = '` + data.description + `',
                    class = '` + data.class + `',
                    is_active = '` + isActive + `'
            WHERE alert_id = '` + data.alert_id + `'
        `, callback);
}

module.exports.createAlert = function(data, callback) {
    let isActive = (data.is_active) ? 1 : 0;
    sqlClean.escapeObjectStrings(data);
        console.log('SQL Alert CREATE REQUEST: ', data)
        connection.query(`
            INSERT INTO alert
                SET name = '` + data.name + `',
                    description = '` + data.description + `',
                    class = '` + data.class + `',
                    is_active = '` + isActive + `'
        `, data, callback);
}

module.exports.deleteAlert = function(params, callback) {
    sqlClean.escapeObjectStrings(params);
        connection.query(`
            DELETE FROM alert 
                WHERE alert_id = '` + params.id + `'
        `, callback);
}
