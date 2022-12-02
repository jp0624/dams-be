var express = require('express');
const router = express.Router();

// Import User Module Containing Functions Related To User Data
var language = require('../models/language');
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
		language.getAllLanguages(function(err, rows, fields) {
			if(err) {
				console.log('Error: ', err);
				//throw err
			};
			res.status(200).send(rows);
			return 'rows';
		})
});

router.get('/:id', function(req, res) {

	console.log('req.params: ', req.params.id);
	language.findLanguage(req.params, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
			//throw err
		};
		res.status(200).send(rows);
	})

});

router.post('/', function(req, res) {
	console.log('API LANGUAGE CREATE REQUEST: ', req.body);
	var data = req.body;
	language.createLanguage(data, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
		};
		res.status(200).send(rows);
	})
});

//router.put('/updatelanguage/:data', function(req, res) {
router.put('/', function(req, res) {
	console.log('API LANGUAGE UPDATE REQUEST: ', req.body);
	var data = req.body;
	language.updateLanguage(data, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
		};
		res.status(200).send(rows);
	})
});

module.exports = router;
