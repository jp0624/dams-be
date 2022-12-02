var connection = require('./connection');
var sqlClean = require('./_sql_clean');

module.exports.getAllTerms = function (callback) {
    connection.query(`
        SELECT *
            FROM dictionary
    `, callback);
}
module.exports.findTerm = function (params, callback) {
    sqlClean.escapeObjectStrings(params);
    connection.query(`
        SELECT *
            FROM dictionary
        WHERE term_id = '` + params.id + `'
    `, callback);
}
module.exports.findTaskTerms = function (params, callback) {
    sqlClean.escapeObjectStrings(params);
    connection.query(`
        SELECT  
            d.term_id,                
            d.term,
            d.selector        
        FROM task_dictionary AS td
        INNER JOIN dictionary d
            ON d.term_id = td.dictionary_id
        WHERE td.task_id ='` + params.id + `'
    `, callback);
}
module.exports.updateTerm = function (data, callback) {
    sqlClean.escapeObjectStrings(data);
    console.log('SQL TERM UPDATE REQUEST: ', data)
    connection.query(`
        UPDATE dictionary
            SET term = '` + data.term + `',
                selector = '` + data.selector + `'
        WHERE term_id = '` + data.term_id + `'
    `, callback);
}
module.exports.createTerm = function (data, callback) {
    sqlClean.escapeObjectStrings(data);
    console.log('SQL TERM CREATE REQUEST: ', data)
    connection.query(`
        INSERT INTO dictionary
            SET term = '` + data.term + `',
                selector = '` + data.selector + `'
    `, data, callback);
}
