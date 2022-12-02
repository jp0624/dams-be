var express = require('express');
const router = express.Router();

// Import User Module Containing Functions Related To User Data
var login = require('../models/login');
var server = require('../models/server');
var bcrypt = require('bcryptjs');
// var group = require('../models/group');

// API Routes
router.get('/', function(req, res) {
	console.log('Empty Get')
});


router.post('/login', function(req, res, next) {
    var data = req.body;
    console.log('DATA[EMAIL]: ', data.email);
    
	login.checkEmail(data, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
            server.sendResponse(data, res);
            return
        };
        if(Object.keys(rows).length === 0) {
            console.log('NO FOUND USER (1)');
            data.message = 'UserNotExist';
            server.sendResponse(data, res);
            return
        }
        else if(Object.keys(rows).length){
            console.log('FOUND USER');
            
            var string = JSON.stringify(rows);
            var json =  JSON.parse(string);        

            data.user_id = json[0].user_id;
            data.hash = json[0].hash;
            data.name = json[0].name;
            data.message = 'UserExists';
            data.loggedin = false;
            
            data.tokenstart = +new Date
            data.tokenend = +new Date(new Date().getTime() + 60 * 60 * 24 * 1000);

            bcrypt.compare(data.password, data.hash, function(err, response) {
                if(err){
                    console.log('Error: ', err);
                    data.loggedin = false;
                    server.sendResponse(data, res);
                    return false

                } else if (!res) {
                    data.loggedin = false;
                    data.message = 'WrongUsernameOrPasswordError';
                    server.sendResponse(data, res);
                    return

                } else {
                    console.log('PASSWORD COMPARE: ', response);
                    
                    data.loggedin = response;
                    data.message = 'UserExistsPasswordMatch';

                    console.log('DATA TO SEND ', data);
                    server.sendResponse(data, res);
                    return
                }
                //server.sendResponse(data);
            });

        } else {
            data.message = 'UserNotExist';
            console.log('NO FOUND USER (2)');
            server.sendResponse(data, res);
            return
        }
    })
});

router.post('/POSTlogin', function(req, res, next) {
    var data = req.body;
    var validUser = false;

    console.log('HERE 1');
    
    /*
	user.addUser(data, function(err, info) {
		if(err) {
			console.log('Error: ', err);
			//throw err
		};
		console.log(info);
		user.sendResponse(true, res);
    });
    */
    
	login.checkuser(data, function(err, rows, fields) {
        temp = [
            'test'
        ]
			console.log('RESPONSE?: ', fields);
        return info;
        
		if(err) {
			console.log('Error: ', err);
			//throw err
        };
        console.log('Login res1: ', fields);
        
        //res.status(200).send(info);
        res.status(200).send(rows);
        
        // because Object.keys(new Date()).length === 0;
        // we have to do some additional check
        //Object.keys(obj).length === 0 && obj.constructor === Object

        if(Object.keys(fields).length){
            console.log('FOUND USER');
            //return info;
            //server.sendResponse(true, info);
            //validUser = true;
        } else {
            console.log('NO FOUND USER');
            //server.sendResponse(false, info);
        }

        console.log('INFO: ', rows.json());
		//return 'rows';
    })
    

});

module.exports = router;
