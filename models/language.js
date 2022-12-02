var connection = require('./connection');

var sqlClean = require('./_sql_clean');


module.exports.getAllLanguages = function(callback) {
    connection.query(`
        SELECT * 
            FROM language
    `, callback);
}
module.exports.findLanguage = function(params, callback) {
sqlClean.escapeObjectStrings(params);
	connection.query(`
        SELECT *
            FROM language
        WHERE language_id = '` + params.id + `'
    `, callback);
}
module.exports.updateLanguage = function(data, callback) {
sqlClean.escapeObjectStrings(data);
    console.log('SQL LANGUAGE UPDATE REQUEST: ', data)
    connection.query(`
        UPDATE language
            SET name = '` + data.name + `',
                code = '` + data.code + `'
        WHERE language_id = '` + data.language_id + `'
    `, callback);
}
module.exports.createLanguage = function(data, callback) {
sqlClean.escapeObjectStrings(data);
    console.log('SQL LANGUAGE CREATE REQUEST: ', data)
    connection.query(`
        INSERT INTO language
            SET name = '` + data.name + `',
                code = '` + data.code + `'
    `, data, callback);
}