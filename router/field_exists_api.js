var express = require('express');
const router = express.Router();

// Import User Module Containing Functions Related To User Data
var field_exists = require('../models/field_exists');

// var keycloak = require('../keycloak-middleware');

// // middleware that is specific to this router
// router.use(keycloak.protect(), function timeLog(req, res, next) {
// 	// This function called everytime you access any of the below routes
// 	console.log('Time: ', Date.now());
// 	next();
// })


router.get('/field-exists/:table_name/:column_name/:value', function(req, res) {
console.log('coming here');
    field_exists.findFieldValue(req.params, function(err, rows) {
        console.log(rows);
        if(err) {
            console.log('Error: ', err);
            //throw err
        };

        var exists = (rows.length === 1);

        res.status(200).send(exists);
    })

});

module.exports = router;
