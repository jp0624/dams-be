var connection = require('./connection');
var sqlClean = require('./_sql_clean');

module.exports.getAllStatuses = function(callback) {
    connection.query(`
        SELECT *
            FROM status
    `, callback);
}

module.exports.findStatus = function(params, callback) {
    sqlClean.escapeObjectStrings(params);
    connection.query(`
        SELECT *
            FROM status
        WHERE status_id = '` + params.id + `'
    `, callback);
}

module.exports.updateStatus = function(data, callback) {
    sqlClean.escapeObjectStrings(data);
    const sql = `UPDATE status
                        SET name = '` + data.name + `', 
                            description = '` + data.description + `', 
                            hexcode = '` + data.hexcode + `' 
                    WHERE status_id = '` + data.status_id + `'
                `;
    connection.query(sql, callback);
}

module.exports.createStatus = function(data, callback) {
    sqlClean.escapeObjectStrings(data);
    console.log('SQL STATUS CREATE REQUEST: ', data)

    connection.query(`
        INSERT INTO status
            SET name = '` + data.name + `',
                description = '` + data.description + `',
                hexcode = '` + data.hexcode + `'
    `, data, callback);
}

module.exports.delete = function(params, callback) {
    sqlClean.escapeObjectStrings(params);
    console.log('SQL STATUS DELETE REQUEST: ', params);
    connection.query(`DELETE FROM status WHERE status_id = ` + params.id, callback);
}