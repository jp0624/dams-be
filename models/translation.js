var connection = require('./connection');

var sqlClean = require('./_sql_clean');

module.exports.getAllTranslations = function(callback) {
    connection.query(`
        SELECT *
        FROM translation
    `, callback);
}
module.exports.findTranslation = function(params, callback) {
sqlClean.escapeObjectStrings(params);
	connection.query(`
        SELECT * FROM course WHERE course_id = '` + params.id + `'
    `, callback);
}