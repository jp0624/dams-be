var connection = require('./connection');

var sqlClean = require('./_sql_clean');

module.exports.findFieldValue = function (params, callback) {
    sqlClean.escapeObjectStrings(params);
    connection.query(`
        SELECT  COUNT(` + params.column_name + `) 
        FROM ` + params.table_name + ` 
        WHERE ` + params.column_name + ` = '` + params.value + `'
    `, callback);   
}