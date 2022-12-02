var connection = require('./connection');
var sqlClean = require('./_sql_clean');

module.exports.getAllLessonTypes = function(callback) {
    connection.query(`
        SELECT *
            FROM lesson_type
    `, callback);
}

module.exports.findLessonType = function(params, callback) {
    sqlClean.escapeObjectStrings(params);
        connection.query(`
            SELECT *
                FROM lesson_type
            WHERE type_id = '` + params.id + `'  LIMIT 1
        `, callback);
}

module.exports.updateLessonType = function(data, callback) {
    sqlClean.escapeObjectStrings(data);
        console.log('SQL LessonType UPDATE REQUEST: ', data)
        connection.query(`
            UPDATE lesson_type
                SET name = '` + data.name + `',
                    description = '` + data.description + `'
            WHERE type_id = '` + data.type_id + `'
        `, callback);
}

module.exports.createLessonType = function(data, callback) {
    sqlClean.escapeObjectStrings(data);
        console.log('SQL LessonType CREATE REQUEST: ', data)
        connection.query(`
            INSERT INTO lesson_type
                SET name = '` + data.name + `',
                    description = '` + data.description + `'
        `, data, callback);
}

module.exports.deleteLessonType = function(params, callback) {
    sqlClean.escapeObjectStrings(params);
        connection.query(`
            DELETE FROM lesson_type 
                WHERE type_id = '` + params.id + `'
        `, callback);
}
