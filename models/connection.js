var mysql = require('mysql');
var env = process.env.NODE_ENV || 'dev';
var config = require('../config')[env];

var pool = mysql.createPool({
    connectionLimit : 50, //important
    host: config.mysql.host,
    port: config.mysql.port,
    user: config.mysql.user,
    password: config.mysql.password,
    database: config.mysql.database,
    multipleStatements: true
});

pool.getConnection(function(err,connection){
    if (err) {
        console.log("code : 100, status : Error in connection database");
        return;
    }
    console.log('connected as id ' + connection.threadId);
})

module.exports = pool;var mysql = require('mysql');
var env = process.env.NODE_ENV || 'dev';
var config = require('../config')[env];

var pool = mysql.createPool({
    connectionLimit : 50, //important
    host: config.mysql.host,
    port: config.mysql.port,
    user: config.mysql.user,
    password: config.mysql.password,
    database: config.mysql.database,
    multipleStatements: true
});

pool.getConnection(function(err,connection){
    if (err) {
        console.log("code : 100, status : Error in connection database");
        return;
    }
    console.log('connected as id ' + connection.threadId);
})

module.exports = pool;