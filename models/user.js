var bcrypt = require('bcryptjs');

var connection = require('./connection');

var sqlClean = require('./_sql_clean');

/*
module.exports.findAll = function(callback) {
	connection.query("SELECT * FROM user ORDER BY user_id ASC", callback);
}
*/
module.exports.findAllUsers = function(callback) {
	//SELECT u.user_id AS 'User ID', u.name AS 'Name', g.name AS 'Account Type', u.email AS 'E-Mail Address'
	connection.query(`
		SELECT u.user_id, u.name, g.name AS 'user_type', u.email, u.group_id
			FROM user AS u
		INNER JOIN user_group AS g
			ON u.group_id = g.group_id
		ORDER BY user_id ASC`
	, callback);
}

module.exports.findUser = function(params, callback) {
	sqlClean.escapeObjectStrings(params);
		connection.query(`
			SELECT u.user_id, u.name, u.hash, u.email, u.group_id
				FROM user AS u
			WHERE user_id = '` + params.id + `'
		`, callback);
}

module.exports.updateUser = function(data, callback) {
	sqlClean.escapeObjectStrings(data);
		console.log('SQL USER UPDATE REQUEST: ', data)
		connection.query(`
			UPDATE user
				SET name = '` + data.name + `',
					group_id = '` + data.group_id + `',
					email = '` + data.email + `',
					hash = '` + data.hash + `'
			WHERE user_id = '` + data.user_id + `'
		`, callback);
}

module.exports.findAllGroups = function(callback) {
	//SELECT u.user_id AS 'User ID', u.name AS 'Name', g.name AS 'Account Type', u.email AS 'E-Mail Address'
	connection.query(`
		SELECT *
			FROM user_group
	`, callback);
}

module.exports.findGroup = function(params, callback) {
	sqlClean.escapeObjectStrings(params);
		connection.query(`
			SELECT *
				FROM user_group
			WHERE group_id = '` + params.id + `'
		`, callback);
}

module.exports.updateGroup = function(data, callback) {
	sqlClean.escapeObjectStrings(data);
		console.log('SQL GROUP UPDATE REQUEST: ', data)
		connection.query(`
			UPDATE user_group
				SET name = '` + data.name + `',
					description = '` + data.description + `'
			WHERE group_id = '` + data.group_id + `'
		`, callback);
}

module.exports.createGroup = function(data, callback) {
	sqlClean.escapeObjectStrings(data);
		console.log('SQL GROUP CREATE REQUEST: ', data)
		connection.query(`
			INSERT INTO user_group
				SET name = '` + data.name + `',
					description = '` + data.description + `'
		`, data, callback);
}

module.exports.createUser = function(data, callback) {
	sqlClean.escapeObjectStrings(data);
		console.log('data: ', data);
		connection.query(`INSERT INTO user
							SET name = '` + data.name + `',
								email = '` + data.email + `',
								group_id = '` + data.group_id + `',
								hash = '` + data.hash + `'
						`, data, callback);
}

module.exports.findByUsername = function(name, callback) {
	connection.query("SELECT * FROM user WHERE name = '" + name + "'", callback);
}

module.exports.findByEmail = function(data, callback) {
	sqlClean.escapeObjectStrings(data);
		email = data.email
		connection.query("SELECT * FROM user WHERE email = '" + email + "'", callback);
}

module.exports.findByGroupId = function(group_id, callback) {
	connection.query("SELECT * FROM user WHERE group_id = '" + group_id + "'", callback);
}

module.exports.encrypt = function(data, callback) {
	sqlClean.escapeObjectStrings(data);
		bcrypt.genSalt(10, function(err, salt) {
			bcrypt.hash(data.password, salt, callback);
		});
}
