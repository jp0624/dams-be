var mysql = require('mysql');

var connection = mysql.createConnection({
	/*
	host: 'localhost',
	user: 'john',
	password: '1q2w3e',
	database: 'dams_schema'
	*/
	host: 'localhost',
	user: 'dams',
	password: 'Password#1',
	database: 'dams_schema'
	
});

function connectDatabase() {
	connection.connect(function(err) {
	if (err) {
		console.error('error connecting: ' + err.stack);
		setTimeout(connectDatabase, 2000);
		return;
	}
	
	console.log('connected as id ' + connection.threadId);
		console.log("Database connected");
	});
}
connection.on('error', function(err) {
	console.log('db error', err);

	if(err.code === 'PROTOCOL_CONNECTION_LOST') { // Connection to the MySQL server is usually
		console.log('SENDING CONNECT DATABASE AGAIN! 1')
		connectDatabase();                         // lost due to either server restart, or a
	} else {                                      // connnection idle timeout (the wait_timeout
		console.log('SENDING CONNECT DATABASE AGAIN! 2')
		//connectDatabase();
		throw err;                                  // server variable configures this)
	}
});
connectDatabase();

module.exports = connection;