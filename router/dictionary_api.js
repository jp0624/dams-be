var express = require('express');
const router = express.Router();

// Import User Module Containing Functions Related To User Data
var dictionary = require('../models/dictionary');
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
	dictionary.getAllTerms(function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
			//throw err
        };
        console.log('rows: ', rows)
		res.status(200).send(rows);
	})
});

router.get('/:id', function(req, res) {
	dictionary.findTerm(req.params, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
			//throw err
		};
		res.status(200).send(rows);
	})
});

router.post('/', function(req, res) {
	console.log('API TERM CREATE REQUEST: ', req.body);
	var data = req.body;
	dictionary.createTerm(data, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
		};
		res.status(200).send(rows);
	})
});

router.put('/', function(req, res) {
	console.log('API TERM UPDATE REQUEST: ', req.body);
	var data = req.body;
	dictionary.updateTerm(data, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
		};
		res.status(200).send(rows);
	})
});

router.get('/gettaskterms/:id', function(req, res) {
	//console.log('Get all users request: ', req)
	console.log('req.params: ', req.params.id);

	dictionary.findTaskTerms(req.params, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
			//throw err
		};
		res.status(200).send(rows);
	})

});

module.exports = router;
