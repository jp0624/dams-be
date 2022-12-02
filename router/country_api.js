var express = require('express');
const router = express.Router();

// Import User Module Containing Functions Related To User Data
var country = require('../models/country');
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
	country.getAllCountries(function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
			//throw err
		};
		res.json(rows);
		return rows;
	})
});

router.get('/:id', function(req, res) {
	//console.log('Get all users request: ', req)
	console.log('req.params: ', req.params.id);

	country.findCountry(req.params, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
			//throw err
		};
		res.json(rows);
		return 'rows';
	})

});

router.put('/', function(req, res) {
	console.log('API COUNTRY UPDATE REQUEST: ', req.body);
	var data = req.body;
	country.updateCountry(data, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
		};
		res.json(rows);
	})
});

router.post('/', function(req, res) {
	console.log('API COUNTRY CREATE REQUEST: ', req.body);
	var data = req.body;
	country.createCountry(data, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
		};
		res.json(rows);
	})
});

router.get('/getcountrylanguages/:code', function(req, res) {
	country.findCountryLanguages(req.params, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
			//throw err
		};
        res.json(rows);
	})

});

router.get('/getcountrysettinggroups/:params', function(req, res) {

	country.findCountrySettingGroups(req.params, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
			//throw err
		};
		
        res.json(rows);
	})

});

router.get('/getcountrysettingtypes/:group_id', function(req, res) {
	console.log('REQUESTED PARAMS TYPES: ', req.params)
	country.findCountrySettingTypes(req.params, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
			//throw err
		};
		console.log('<<<<<<<<<<<<<<<<<<<<<< ', rows);
		
        res.json(rows);
	})

});
router.get('/getcountrysettingtypeoptions/:type_id', function(req, res) {
	console.log('REQUESTED PARAMS OPTIONS: ', req.params)
	country.findCountrySettingTypeOptions(req.params, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
			//throw err
		};
		console.log('<<<<<<<<<<<<<<<<<<<<<< ', rows);
		
        res.json(rows);
	})

});

router.get('/getcountrysettingtypeselected/:country_id/:type_id', function(req, res) {
	console.log('REQUESTED PARAMS SELECTED: ', req.params)
	country.findCountrySettingTypeSelected(req.params, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
			//throw err
		};
		console.log('<<<<<<<<<<<<<<<<<<<<<< ', rows);
		
        res.json(rows);
	})

});

router.get('/getcountrypropstatus/:country_id/:property_id', function(req, res) {
	//console.log('Get all users request: ', req)

	country.findCountryPropStatus(req.params, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
			//throw err
		};
		console.log(rows);
		res.json(rows);
	})

});
router.put('/updatecountryproperty', function(req, res) {
	console.log('PUT ATTR PROPERTY REQUEST: ', req.body);
	
	var data = req.body;
	console.log(data)
	country.updateCountryProperty(data, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
		};
		res.json(rows);
	})

});

router.delete('/removecountryproperty/:country_id/:property_id', function(req, res) {
	console.log('REMOVE ATTR PROPERTY REQUEST: ', req.params);

	var data = req.params;
	console.log(data)

	country.deleteCountryProperty(data, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
		};
		res.json(rows);
	})
});

router.post('/linkcountrylanguages', function(req, res) {

	console.log('API TASK CREATE REQUEST: ', req.body);
	let pendingterms = req.body.languages;

	let curTerms = []; //req.body.terms.cur
	//let newTerms = req.body.languages.new;
	
	// for(let language of req.body.languages.cur){
	// 	curTerms.push(language.code);
	// }

	let params = {
		country_code: req.body.country_code,
		termsToAdd: req.body.languages.add,
		termsToRemove: req.body.languages.delete
	}

	console.log('params: ', params)
	let pendingTermsToRemove = params.termsToRemove.length;
	let pendingTermsToAdd = params.termsToAdd.length;

	for(let term_remove of params.termsToRemove){
		console.log('--language_code: ', term_remove);
		console.log('country_code: ', params.country_code)
		
		language = {
			language_code: term_remove,
			country_code: params.country_code
		}
		
		country.deleteCountryLanguageLink(language, function(err, rows, fields) {
			if(err) {
				console.log('Error: ', err);
			};

			if(rows.affectedRows !== 0){
				console.log('LANGUAGE Deleted: ', language)
				
				
				if( 0 === --pendingTermsToRemove || 0 === pendingTermsToRemove) {
					
					if( 0 === pendingTermsToAdd ) {
						console.log('======================================');
						console.log('======( ALL LANGUAGE LINKS REMOVED )======');
						res.json(rows);
					}
				}
			}
		})
	}

	for(let term_add of params.termsToAdd){
		console.log('++language_code: ', term_add);
		console.log('country_code: ', params.country_code)
		
		language = {
			language_code: term_add,
			country_code: params.country_code
		}
		
		country.addCountryLanguageLink(language, function(err, rows, fields) {
			if(err) {
				console.log('Error: ', err);
			};
			console.log('rows: ', rows)
			if(rows.affectedRows !== 0){
				console.log('LANGUAGE Added: ', language)
				
				
				if( 0 === --pendingTermsToAdd || 0 === pendingTermsToAdd) {
					
					if( 0 === pendingTermsToRemove ) {
						console.log('======================================');
						console.log('======( ALL LANGUAGE LINKS Added )======');
						res.json(rows);
					};
				}
			}
		})
	}

});

module.exports = router;
