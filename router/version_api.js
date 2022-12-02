var express = require('express');
const router = express.Router();

// Import Version Module Containing Functions Related To Version Data
var version = require('../models/version');

// var keycloak = require('../keycloak-middleware');

// // middleware that is specific to this router
// router.use(keycloak.protect(), function timeLog(req, res, next) {
// 	// This function called everytime you access any of the below routes
// 	console.log('Time: ', Date.now());
// 	next();
// })

router.get('/', function(req,res) {
	version.getAllVersions(function(err, rows) {
		if(err) {
			console.log('Error: ', err);
		};
		res.status(200).send(rows);
	})
});

router.get('/:id', function(req, res) {
	console.log('req.params: ', req.params.id);
	version.findVersion(req.params, function(err, rows) {
		if(err) {
			console.log('Error: ', err);
		};
		res.status(200).send(rows);
	})

});

router.post('/', function(req, res) {
	console.log('API VERSION CREATE REQUEST: ', req.body);
	var data = req.body;
	console.log('body ===>'+req.body);
	
	version.createVersion(data, function(err, rows) {
		if(err) {
			console.log('Error: ', err);
		};
		
		data["id"] = rows.insertId;
		res.status(200).send(data);
	})
});

router.put('/', function(req, res) {
	console.log('API VERSION UPDATE REQUEST: ', req.body);
	var data = req.body;
	version.updateVersion(data, function(err, rows) {
		if(err) {
            console.log('Error: ', err);
            res.status(500).send(err);
		};
		if(rows.affectedRows==1)
			res.status(200).send(true);
		else 
			res.status(200).send(false);
	})
});

router.delete('/:id', function(req, res) {
	console.log('req.params: ', req.params.id);
	version.deleteVersion(req.params, function(err, rows) {
		if(err) {
            console.log('Error: ', err);
            res.status(500).send(err);
		};
		console.log(rows);
		if(rows.affectedRows==1)
			res.status(200).send(true);
		else 
			res.status(200).send(false);
	})
});

module.exports = router;
