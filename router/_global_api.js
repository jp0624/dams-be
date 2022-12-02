var express = require('express');
const router = express.Router();
// Import User Module Containing Functions Related To User Data
var global = require('../models/_global');
var server = require('../models/server');

// API Routes
router.get('/', function(req, res) {
	console.log('Empty Get')
});

router.delete('/deletelink/:table/:id', function(req, res) {
	//Not used
	console.log('API CONTENT DELETE REQUEST: ', req.params);
	var data = req.params;
	console.log(data)
	
	global.deleteLink(data, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
		};
		res.status(200).send(rows);
	})
});

router.delete('/deletelinkwithpkname/:table/:primarykey/:id', function(req, res) {
	console.log('API CONTENT DELETE REQUEST: ', req.params);
	var data = req.params;
	console.log(data)
	
	global.deleteLinkWithPkName(data, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
		};
		res.status(200).send(rows);
	})
});

router.get('/getgstatuses', function(req, res) {
	global.findStatuses(req.params, function(err, rows, fields) {
		if(err) { console.log('Error: ', err) };
		res.status(200).send(rows);
	});
});

router.get('/getgversions', function(req, res) {
	global.findVersions(req.params, function(err, rows, fields) {
		if(err) { console.log('Error: ', err) };
		res.status(200).send(rows);
	});
});

router.get('/getgproperties', function(req, res) {
	global.findProperties(req.params, function(err, rows, fields) {
		if(err) { console.log('Error: ', err) };
		res.status(200).send(rows);
	});
});

router.get('/getgstatus/:id', function(req, res) {
	global.findStatus(req.params, function(err, rows, fields) {
		if(err) { console.log('Error: ', err) };
		res.status(200).send(rows);
	});
});

router.get('/getgvehicles', function(req, res) {
	global.findVehicles(req.params, function(err, rows, fields) {
		if(err) { console.log('Error: ', err) };
		res.status(200).send(rows);
	});
});

router.get('/getglocktypes', function(req, res) {
	global.findLocktypes(req.params, function(err, rows, fields) {
		if(err) { console.log('Error: ', err) };
		res.status(200).send(rows);
	});
});

router.get('/getgvehicle/:id', function(req, res) {
	global.findVehicle(req.params, function(err, rows, fields) {
		if(err) { console.log('Error: ', err) };
		res.status(200).send(rows);
	});
});

router.get('/getgtasktypes', function(req, res) {
	global.findTaskTypes(req.params, function(err, rows, fields) {
		if(err) { console.log('Error: ', err) };
		res.status(200).send(rows);
	});
});

router.get('/getgtasktype/:id', function(req, res) {
	global.findTaskType(req.params, function(err, rows, fields) {
		if(err) { console.log('Error: ', err) };
		res.status(200).send(rows);
	});
});

router.get('/getcolumns/:table', function(req, res) {
	//Not used
    //SHOW COLUMNS FROM my_table;
	console.log('req.params: ', req.params.id);

	global.findColumns(req.params, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
			//throw err
		};
		res.status(200).send(rows);
	})
});

router.get('/getglessontypes', function(req, res) {
	global.getglessontypes(req.params, function(err, rows, fields) {
		if(err) { console.log('Error: ', err) };
		res.status(200).send(rows);
	});
});
//get lesson version
router.get('/getLessonVersion', function(req, res) {
	global.getLessonVersion(req.params, function(err, rows, fields) {
		if(err) { console.log('Error: ', err) };
		res.status(200).send(rows);
	});
});
module.exports = router;