var express = require('express');
const router = express.Router();

// Import User Module Containing Functions Related To User Data
var status = require('../models/status');
var server = require('../models/server');

// API Routes
// router.get('/', function(req, res) {
// 	console.log('Empty Get')
// });

// var keycloak = require('../keycloak-middleware');

// // middleware that is specific to this router
// router.use(keycloak.protect(), function timeLog(req, res, next) {
// 	// This function called everytime you access any of the below routes
// 	console.log('Time: ', Date.now());
// 	next();
// })

router.get('/', function(req, res) {
	status.getAllStatuses(function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
			//throw err
        };
        console.log('rows: ', rows)
		res.status(200).send(rows);
	})
});

router.get('/:id', function(req, res) {
	status.findStatus(req.params, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
		};
		res.status(200).send(rows);
	})
});

router.put('/', function(req, res) {
	console.log('API STATUS UPDATE REQUEST: ', req.body);
	var data = req.body;
	status.updateStatus(data, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
		};
		res.status(200).send(rows);
	})
});

router.post('/', function(req, res) {
	console.log('API STATUS CREATE REQUEST: ', req.body);
	var data = req.body;
	status.createStatus(data, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
		};
		res.status(200).send(rows);
	})
});

router.delete('/:id', function(req, res) {
	console.log('Delete a status');
	console.log('req.params: ', req.params.id);
	
	status.delete(req.params, function(err, rows, fields) {
		if (err) {
			console.log('Error :', err);
			res.status(500).send(err);
		}
		else {
			res.status(200).send(true);
		}
	});
});

module.exports = router;
