var express = require('express');
const router = express.Router();
var bcrypt = require('bcryptjs');

// Import User Module Containing Functions Related To User Data
var user = require('../models/user');
var server = require('../models/server');
//var group = require('../models/group');

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
	user.findAllUsers(function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
			//throw err
		};
		res.status(200).send(rows);
		return 'rows';
	})
});

router.get('/:id', function(req, res) {
	user.findUser(req.params, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
			//throw err
		};
		res.status(200).send(rows);
		return 'rows';
	})
});

router.post('/', function(req, res, next) {	
	var data = req.body;
	console.log('data: ', data);

	user.findByEmail(data, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
            server.sendResponse(data, res);
            return
        };				
		if(Object.keys(rows).length > 0) {
			console.log('EMAIL ALREADY ASSIGNED');

			res.send(false);
			return
			//server.sendResponse(false, res);
		} else {
			console.log('NEW USER CREATED');
			bcrypt.hash(data.password, 10, function(err, hash) {

				data.hash = hash
				console.log('CRRRRRRRRRRRRRRRRRRRRRRREATE USER: ', data)
				user.createUser(data, function(err, info) {
					if(err) throw err;
					console.log(info);
					
					res.send(true);
					//server.sendResponse(true, res);
				});
			  });	
		};
	});
});

router.put('/', function(req, res) {
	console.log('API USER UPDATE REQUEST: ', req.body);
	var data = req.body;

	if(data.password){
		bcrypt.hash(data.password, 10, function(err, hash) {
			data.hash = hash
			console.log('NEW DATA HASH: ', data)
			user.updateUser(data, function(err, rows, fields) {
				if(err) {
					console.log('Error: ', err);
				};
				res.status(200).send(rows);
			})
		});	
	} else {
		console.log('Password was empty: ', data)
		user.updateUser(data, function(err, rows, fields) {
			if(err) {
				console.log('Error: ', err);
			};
			res.status(200).send(rows);
		})
	}
});

router.get('/groups/group/', function(req, res) {
	console.log('Get all users request: ', req);
	user.findAllGroups(function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
			//throw err
		};
		res.status(200).send(rows);
		return 'rows';
	})
});

router.get('/groups/group/:id', function(req, res) {
	console.log('Get group: ', req.params);
	user.findGroup(req.params, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
			//throw err
		};
		res.status(200).send(rows);
		return 'rows';
	})

});

router.put('/groups/group', function(req, res) {
	console.log('API GROUP UPDATE REQUEST: ', req.body);
	var data = req.body;
	user.updateGroup(data, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
		};
		res.status(200).send(rows);
	})
});

router.post('/groups/group', function(req, res) {
	console.log('API GROUP CREATE REQUEST: ', req.body);
	var data = req.body;
	user.createGroup(data, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
		};
		res.status(200).send(rows);
	})
});

module.exports = router;
