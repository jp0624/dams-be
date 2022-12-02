var express = require('express');
const router = express.Router();
var env = process.env.NODE_ENV || 'dev';
var config = require('./../config')[env];
var session = require('express-session');
var Keycloak = require('keycloak-connect');
var memoryStore = new session.MemoryStore();
var keycloak = new Keycloak({ store: memoryStore }, config.keycloak);

// Import User Module Containing Functions Related To User Data
var course = require('../models/course');
// var server = require('../models/server');

// API Routes
// router.get('/', function(req, res) {
// 	console.log('Empty Get')
// });

//router.get('/', keycloak.protect('supervisor'), function(req, res) {
	
// var keycloak = require('../keycloak-middleware');

// // middleware that is specific to this router
// router.use(keycloak.protect(), function timeLog(req, res, next) {
// 	// This function called everytime you access any of the below routes
// 	console.log('Time: ', Date.now());
// 	next();
// })

router.get('/', function(req, res) {
	course.getAllCourses(function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
			//throw err
        };
        console.log('rows: ', rows)
		res.status(200).send(rows);
	});
});

router.get('/:id', function(req, res) {
	//console.log('Get all users request: ', req)
	console.log('req.params: ', req.params.id);

	course.findCourse(req.params, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
			//throw err
		};
		res.status(200).send(rows);
	})
});

router.post('/', function(req, res) {
	console.log('API COURSE CREATE REQUEST: ', req.body);
	var data = req.body;
	course.createCourse(data, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
		};
		res.status(200).send(rows);
	})
});

router.put('/', function(req, res) {
	console.log('API COURSE UPDATE REQUEST: ', req.body);
	var data = req.body;
	course.updateCourse(data, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
		};
		res.status(200).send(rows);
	})
});

router.put('/updatecourselessonsorder', function(req, res) {
	console.log('API COURSE UPDATE REQUEST: ', req.body);
	//console.log('API COURSE UPDATE REQUEST: ', req.params);
	
	var data = req.body;
	course.updateCourseLessonsOrder(data, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
		};
		res.status(200).send(rows);
	})
});

router.get('/getcourselessons/:id', function(req, res) {
	//console.log('Get all users request: ', req)
	console.log('req.params: ', req.params.id);

	course.findCourseLessons(req.params, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
			//throw err
		};
		res.status(200).send(rows);
	})
});

router.delete('/:id', function(req, res) {
	console.log('Delete a course');
	console.log('req.params: ', req.params.id);
	course.delete(req.params, function(err, rows, fields) {
		if (err) {
			console.log('Error :', err);
			res.status(200).send(false);
		}
		else {
			res.status(200).send(true);
		}
	});
});

module.exports = router;
