var express = require('express');
const router = express.Router();

var vehicle = require('../models/vehicle');
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
	vehicle.getAllVehicles(function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
			//throw err
        };
        console.log('rows: ', rows)
		res.status(200).send(rows);
	})
});

router.get('/:id', function(req, res) {
	//console.log('Get all users request: ', req)
	console.log('req.params: ', req.params.id);

	vehicle.findVehicle(req.params, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
			//throw err
		};
		res.status(200).send(rows);
	})

});

router.put('/', function(req, res) {
	console.log('API VEHICLE UPDATE REQUEST: ', req.body);
	var data = req.body;
	vehicle.updateVehicle(data, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
		};
		res.status(200).send(rows);
	})
});

router.post('/', function(req, res) {
	console.log('API VEHICLE CREATE REQUEST: ', req.body);
	var data = req.body;
	vehicle.createVehicle(data, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
		};
		res.status(200).send(rows);
	})
});

router.delete('/:id', function(req, res) {
	console.log('Delete a vehicle');
	console.log('req.params: ', req.params.id);
	vehicle.delete(req.params, function(err, rows, fields) {
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
