var connection = require('./connection');

var sqlClean = require('./_sql_clean');

module.exports.checkEmail = function(data, callback) {
sqlClean.escapeObjectStrings(data);
    connection.query(`SELECT * FROM user
        WHERE email = '` + data.email + `'`
    , callback);
}
module.exports.checkPassword = function(data, callback) {
sqlClean.escapeObjectStrings(data);
    
    console.log('>>');
    console.log('>> DATA ', data);
    console.log('>>');

    /*
    connection.query(`
        SELECT * FROM user
            WHERE user_id = '` + data.user_id + `'`
    , callback);
    */

}

module.exports.checkuser = function(data, callback) {
sqlClean.escapeObjectStrings(data);

	/*
    connection.query(`
        SELECT u.user_id AS 'User ID', u.name AS 'Name', g.name AS 'Account Type', u.email AS 'E-Mail Address'
            FROM user AS 'u' 
        INNER JOIN user_group AS 'g'
            ON u.group_id = g.group_id
        ORDER BY user_id ASC
    `, callback);
    */

    console.log('data: ', data)
    console.log('data.email: ', data.email)

    connection.query(`SELECT * FROM user
        WHERE email = '` + data.email + `' 
            AND password = '` + data.password + `'`
    , callback);
}

module.exports.findByGroupId = function(group_id, callback) {
	connection.query("SELECT * FROM user WHERE group_id = '" + group_id + "'", callback);
}

module.exports.addUser = function(data, callback) {
sqlClean.escapeObjectStrings(data);
	connection.query("INSERT INTO user SET ?", data, callback);
}