var connection = require('./connection');

module.exports.checksession = function(callback) {
	connection.query(`
		SELECT u.user_id AS 'User ID', u.name AS 'Name', g.name AS 'Account Type', u.email AS 'E-Mail Address'
			FROM user AS u
		INNER JOIN user_group AS g
			ON u.group_id = g.group_id
		ORDER BY user_id ASC`
	, callback);
}