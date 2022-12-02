var express = require('express');
const router = express.Router();

var lessonType = require('../models/lesson_type');
var server = require('../models/server');

// var keycloak = require('../keycloak-middleware');

// // middleware that is specific to this router
// router.use(keycloak.protect(), function timeLog(req, res, next) {
// 	// This function called everytime you access any of the below routes
// 	console.log('Time: ', Date.now());
// 	next();
// })

router.get('/', function(req, res) {
	lessonType.getAllLessonTypes(function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
			//throw err
        };
        console.log('rows: ', rows)
		res.status(200).send(rows);
	})
});

router.get('/:id', function(req, res) {
	console.log('req.params: ', req.params.id);

	lessonType.findLessonType(req.params, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
			//throw err
		};
		res.status(200).send(rows[0]);
	})
});

router.put('/', function(req, res) {
	console.log('API VEHICLE UPDATE REQUEST: ', req.body);
	var data = req.body;
	lessonType.updateLessonType(data, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
		};
		res.status(200).send(rows);
	})
});

router.post('/', function(req, res) {
	console.log('API VEHICLE CREATE REQUEST: ', req.body);
	var data = req.body;
	lessonType.createLessonType(data, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
		};
		res.status(200).send(rows);
	})
});

router.delete('/:id', function(req, res) {
	console.log('req.params: ', req.params.id);

	lessonType.deleteLessonType(req.params, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
			//throw err
		};
		res.status(200).send(rows);
	})
});

module.exports = router;

