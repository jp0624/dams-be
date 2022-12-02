var connection = require('./connection');

var sqlClean = require('./_sql_clean');

module.exports.findStatuses = function(params, callback) {
sqlClean.escapeObjectStrings(params);
	connection.query(`
        SELECT *
            FROM status
    `, callback);
}
module.exports.findVersions = function(params, callback) {
sqlClean.escapeObjectStrings(params);
	connection.query(`
        SELECT *
            FROM content_version
    `, callback);
}
module.exports.findProperties = function(params, callback) {
sqlClean.escapeObjectStrings(params);
	connection.query(`
        SELECT *
            FROM content_version_property
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

module.exports.deleteLink = function(data, callback) {
sqlClean.escapeObjectStrings(data);
    console.log('SQL CREATE CONTENET REQUEST: ', data)
    
    connection.query(`
    DELETE FROM ` + data.table + `
        WHERE ` + data.table + `_id = '` + data.id + `'
    `, callback);
}

module.exports.deleteLinkWithPkName = function(data, callback) {
    sqlClean.escapeObjectStrings(data);
        console.log('SQL CREATE CONTENET REQUEST: ', data)
        
        connection.query(`
        DELETE FROM ` + data.table + `
            WHERE ` + data.primarykey + ` = '` + data.id + `'
        `, callback);
    }

module.exports.findVehicles = function(params, callback) {
sqlClean.escapeObjectStrings(params);
	connection.query(`
        SELECT *
            FROM vehicle
    `, callback);
}
module.exports.getglessontypes = function(params, callback) {
    sqlClean.escapeObjectStrings(params);
        connection.query(`
            SELECT *
                FROM lesson_type
        `, callback);
    }

module.exports.findLocktypes = function(params, callback) {
sqlClean.escapeObjectStrings(params);
	connection.query(`
        SELECT *
            FROM lock_type
    `, callback);
}

module.exports.findVehicle = function(params, callback) {
sqlClean.escapeObjectStrings(params);
	connection.query(`
        SELECT *
            FROM vehicle
        WHERE vehicle_id = '` + params.id + `'
    `, callback);
}

module.exports.findTaskTypes = function(params, callback) {
sqlClean.escapeObjectStrings(params);
	connection.query(`
        SELECT *
            FROM task_type
    `, callback);
}

module.exports.findTaskType = function(params, callback) {
sqlClean.escapeObjectStrings(params);
	connection.query(`
        SELECT *
            FROM task_type
        WHERE type_id = '` + params.id + `'
    `, callback);
}

//get lesson version
module.exports.getLessonVersion = function(params, callback) {
    sqlClean.escapeObjectStrings(params);
    connection.query(`SELECT *
    FROM version`, callback);
}
