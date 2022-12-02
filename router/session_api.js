var express = require('express');
const router = express.Router();

// Import User Module Containing Functions Related To User Data
var session = require('../models/session');
// var group = require('../models/group');

// API Routes
router.get('/', function(req, res) {
	console.log('Empty Get')
});

router.get('/checksession', function(req, res) {

	//console.log('Get all users request: ', req)

	user.checksession(function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
			//throw err
		};
		res.status(200).send(rows);
		console.log('Check Session Res: ', rows);
		return 'rows';
	})
});