var connection = require('./connection');
var sqlClean = require('./_sql_clean');

module.exports.getAllVersions = function(callback) {
    connection.query(`
        SELECT id, name, code
            FROM version
        ORDER BY name DESC
    `, callback);
}

module.exports.findVersion = function (params, callback) {
    sqlClean.escapeObjectStrings(params);
    connection.query(`
            SELECT *
                FROM version
            WHERE id = '` + params.id + `'
        `, callback);
}

module.exports.createVersion = function(data, callback) {
    sqlClean.escapeObjectStrings(data);
        console.log('SQL VERSION CREATE REQUEST: ', data)
        connection.query(`
            INSERT INTO version
                SET name = '${data.name}',
                    code = '${data.code}'
        `, data, callback);
}

module.exports.updateVersion = function(data, callback) {
sqlClean.escapeObjectStrings(data);
    console.log('SQL VERSION UPDATE REQUEST: ', data)
    connection.query(`
        UPDATE version
            SET name = '${data.name}',
                code = '${data.code}'
        WHERE id = '${data.id}'
    `, callback);
}

module.exports.deleteVersion = function(params, callback) {
    sqlClean.escapeObjectStrings(params);
        connection.query(`
            DELETE FROM version 
                WHERE id = '${params.id}'
        `, callback);
}
