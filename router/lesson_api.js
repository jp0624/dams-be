var express = require('express');
const router = express.Router();
// Import User Module Containing Functions Related To User Data
var lesson = require('../models/lesson');
var server = require('../models/server');

// var keycloak = require('../keycloak-middleware');

var env = process.env.NODE_ENV || 'dev';
var config = require('../config')[env];

// Commented for copy lesson function, Because it take time to run the stored procedure especially which has more translation in lesson.

// middleware that is specific to this router
/* router.use(keycloak.protect(), function timeLog(req, res, next) {
	// This function called everytime you access any of the below routes
	console.log('Time: ', Date.now());
	next();
}) */

// API Home page routes
// router.get('/', function(req, res) {
// 	console.log('Lesson Home Get')
// 	res.status(200).send('Success : Lessons home controller');
// });

router.get('/', function (req, res) {

	lesson.getAllLessons(function (err, rows, fields) {
		if (err) {
			console.log('Error: ', err);
			res.status(500).send(err);
			//throw err
		};
		console.log('rows: ', rows)
		if (rows && rows.length > 0) {
			res.status(200).send(rows);
			//res.status(200).send(rows)
		}
		else {
			res.status(404).send([]);
		}
	})
});

router.get('/getAllDistinctLessons', function (req, res) {

	lesson.getAllDistinctLessons(function (err, rows, fields) {
		if (err) {
			console.log('Error: ', err);
			res.status(500).send(err);
			//throw err
		};
		console.log('rows: ', rows)
		if (rows && rows.length > 0) {
			res.status(200).send(rows);
			//res.status(200).send(rows)
		}
		else {
			res.status(404).send([]);
		}
	})
});

	router.get('/publishAllLesson', function (req, res) {
		lesson.publishAllLessons(function (err, rows, fields) {
			if (err) {
				console.log('Error: ', err);
				result = res.status(500).send(err);
			};
			if (rows && rows.length > 0) {

				for(var i = 0; i < rows.length; i++) {
					console.log(rows[i].course_code, rows[i].lesson_code,rows[i].country_code,rows[i].language_code,rows[i].vehicle_code,rows[i].version_code);								
							lesson.bulkexporttojson(rows[i], function (err, data, fields) {
							if (err) {
									console.log(err);
									res.status(500).send(err);
								}
								else {
									let lessonInfo = {
										lesson: data[3],
										tasks: data[5],
										content: data[6],
										dictionary: data[7]
									};
									let op = processJsonLessonInformation(lessonInfo.lesson, lessonInfo.tasks, lessonInfo.content, lessonInfo.dictionary);
									var versioncode = data[3][0].version_code;	
				
										if(versioncode != null) {
											op = processSubVersioning(op, versioncode);
										}						
									
										lesson.storeInFile(JSON.stringify(op), function (err, result) {
											if (err) {
												res.status(500).send(err);
											}
											res.status(200).send({ result: result });
										});
										
								}
						});
				}
                result = res.status(200).send(rows);
            } else {
				result = res.status(404).send([]);
			}
		}) 
	});



router.get('/:id', function (req, res) {
	//console.log('Get all users request: ', req)
	console.log('req.params: ', req.params.id);

	lesson.findLesson(req.params, function (err, rows, fields) {
		if (err) {
			console.log('Error: ', err);
			res.status(500).send(err);
			//throw err
		};
		//res.status(200).json(rows);
		res.status(200).send(rows);
	})

});

router.post('/', function (req, res) {
	console.log('API LESSON CREATE REQUEST: ', req.body);
	var data = req.body;
	lesson.createLesson(data, function (err, rows, fields) {
		if (err) {
			console.log('Error: ', err);
			res.status(500).send(err);
		};
		res.status(200).send(rows);
	})
});

//copy lesson start
router.post('/copyLesson', function (req, res) {
	console.log('API LESSON COPY REQUEST: ', req.body);
	var data = req.body;
	lesson.copyLesson(data, function (err, rows) {
		console.log(rows);
		if (err) {
			console.log('Error: ', err);
			res.status(500).send(err);
		};
		res.status(200).send(rows);
	})
});

router.post('/vehicleType', function (req, res) {
	console.log('API LESSON VEHICLE TYPE CHECHKING REQUEST: ', req.body);
	var data = req.body;
	lesson.lessonVehicleVersionValidation(data, function (err, rows) {
		console.log(rows);
		if (err) {
			console.log('Error: ', err);
			res.status(500).send(err);
		};
		res.status(200).send(rows);
	})
});

router.post('/versionValidation', function (req, res) {
	console.log('API LESSON VERSION CHECHKING REQUEST: ', req.body);
	var data = req.body;
	lesson.versionValidation(data, function (err, rows) {
		console.log(rows);
		if (err) {
			console.log('Error: ', err);
			res.status(500).send(err);
		};
		res.status(200).send(rows);
	})
});

//copy lesson end

// lesson search start
router.post('/search', function (req, res) {
	console.log('API LESSON SEARCH REQUEST: ', req.body);
	var data = req.body;
	lesson.createSearch(data, function (err, rows, fields) {
		if (err) {
			console.log('Error: ', err);
			res.status(500).send(err);
		};
		res.status(200).send(rows);
	})
});
// lesson search end


router.put('/', function (req, res) {
	console.log('API COURSE UPDATE REQUEST: ', req.body);
	var data = req.body;
	lesson.updateLesson(data, function (err, rows, fields) {
		if (err) {
			console.log('Error: ', err);
			res.status(500).send(err);
		};
		res.status(200).send(rows);
	})
});

router.put('/linkcourselesson/:course_id/:lesson_id', function (req, res) {

	console.log('API COURSE UPDATE REQUEST: ', req.body);
	var data = req.body;
	lesson.checkLinkCourseLesson(data, function (err, rows, fields) {
		if (err) {
			console.log('Error: ', err);
			// res.status(500).send(err);
		};
		console.log('rows: ', rows);
		if (rows.length === 0) {

			lesson.setLinkCourseLesson(data, function (err, rows, fields) {
				if (err) {
					console.log('Error: ', err);
					res.status(500).send(err);
				};
				console.log('rows: ', rows);
				res.status(200).send(rows);
			})

		}
		//res.status(200).send(rows);
	})
});

router.put('/updatelessontasksorder/:link_id', function (req, res) {
	console.log('API COURSE UPDATE REQUEST: ', req.body);
	//console.log('API COURSE UPDATE REQUEST: ', req.params);

	var data = req.body;
	lesson.updateLessonTasksOrder(data, function (err, rows, fields) {
		if (err) {
			console.log('Error: ', err);
			res.status(500).send(err);
		};
		res.status(200).send(rows);
	})
});

router.get('/getlessonversions/:id', function (req, res) {
	//console.log('Get all users request: ', req)
	console.log('req.params: ', req.params.id);

	lesson.findLessonVersions(req.params, function (err, rows, fields) {
		if (err) {
			console.log('Error: ', err);
			res.status(500).send(err);
			//throw err
		};
		res.status(200).send(rows);
	})
});

router.get('/getlessontasks/:id', function (req, res) {
	//console.log('Get all users request: ', req)
	console.log('GET LTs req.params: ', req.params.id);

	lesson.findLessonTasks(req.params, function (err, rows, fields) {
		if (err) {
			console.log('Error: ', err);
			//throw err
			res.status(500).send(err);
		};
		console.log(rows);
		res.status(200).send(rows);
	})

});

router.get('/getlessoninfo/:id', function (req, res) {

	//console.log('Get all users request: ', req)
	console.log('GET LTs req.params: ', req.params.id);

	lesson.findLessonInfo(req.params, function (err, rows, fields) {
		if (err) {
			console.log('Error: ', err);
			//throw err
			res.status(500).send(err);
		};
		console.log(rows);

		res.status(200).send(rows);
	})

});

router.delete('/:id', function (req, res) {
	console.log('Delete a course');
	console.log('req.params: ', req.params.id);
	lesson.delete(req.params, function (err, rows, fields) {
		if (err) {
			console.log('Error :', err);
			res.status(200).send(false);
		}
		else {
			res.status(200).send(true);
		}
	});
});



router.get('/exporttojson/:countrycode/:langcode/:lessoncode/:vehiclecode/:versioncode/:deviceId',
	function (req, res) {
		console.log(req.params);
		lesson.exporttojson(req.params, function (err, data, fields) {
			if (err) {
				console.log(err);
				res.status(500).send(err);
			}
			else {
				let lessonInfo = {
					lesson: data[3],
					tasks: data[5],
					content: data[6],
					dictionary: data[7]
				};
				let op = processJsonLessonInformation(lessonInfo.lesson, lessonInfo.tasks, lessonInfo.content, lessonInfo.dictionary);
				let versioncode = req.params.versioncode;

				if(versioncode !== null || versioncode !== ''){
					op = processSubVersioning(op, versioncode);
				}
				//mongo api call
				console.log(JSON.stringify(op));

				if (config.isMongoStorageRequired) {
					lesson.storeLesson(JSON.stringify(op), function (err, result) {
						if (result) {
							if (result == 'Updated' || result == 'Inserted') {
								lesson.storeInFile(JSON.stringify(op), function (err, result) {
									if (err) {
										res.status(500).send(err);
									}
									res.status(200).send({ result: result });
								});
							}
						} else if (err) {
							res.status(500).send(err);
						} else {
							res.status(200).send('No Action');
						}
					});
				} else {
					console.log('No Mongo code..');
					lesson.storeInFile(JSON.stringify(op), versioncode, function (err, result) {
						if (err) {
							res.status(500).send(err);
						}
						res.status(200).send({ result: result });
					});
				}
			}
		});
	}
);

function processJsonLessonInformation(lesson, tasksinfo, content, dictionary) {
	let finalOutput = {};

	finalOutput.lesson_id = lesson[0].lesson_id;
	finalOutput.lesson_code = lesson[0].lesson_code;
	finalOutput.lesson_name = lesson[0].lesson_name;
	finalOutput.course_name = lesson[0].course_name;
	finalOutput.course_code = lesson[0].course_code;
	finalOutput.vehicle_code = lesson[0].vehicle_code;	
	finalOutput.type_id = lesson[0].type_id;
	finalOutput.lesson_type = lesson[0].lesson_type;
	finalOutput.is_imperial = lesson[0].is_imperial;
	finalOutput.is_metric = lesson[0].is_metric;
	finalOutput.lang_dir = lesson[0].lang_dir;
	finalOutput.country_code = lesson[0].country_code;
	finalOutput.lang_code = lesson[0].lang_code;
	finalOutput.device_code = lesson[0].device_code;
	finalOutput.version_code = lesson[0].version_code;
	finalOutput.tasks = tasksinfo;

	finalOutput.tasks.forEach((task) => {
		//console.log(task);
		task.dictionary = [];
		let taskdictionary = dictionary.filter((dic) => {
			return dic.task_id == task.task_id;
		})
		if (taskdictionary && taskdictionary.length && taskdictionary.length > 0) {
			processdictionary(task, taskdictionary);
		}

		processContent(task, content, taskdictionary);
	})

	return finalOutput;
};

function processdictionary(task, taskdictionary) {
	taskdictionary.forEach((dicitem) => {
		task.dictionary.push(
			{
				term: dicitem.term,
				selector: dicitem.selector,
				value: dicitem.value
			}
		);
	});
}

function processContent(task, content1, dictionaryterms) {
	//console.log('Cont');
	//console.log(content1);

	let taskContents = content1.filter(function (cont) {
		return cont.task_id == task.task_id;
	});

	var removeItems = [];
	// task.content = taskContents;
	let attrId = 0;
	let taskgrpid = 0;
	taskContents.forEach((cont, ind) => {
		//console.log(cont, ind);

		if (attrId == cont.attr_id && taskgrpid == cont.task_group_id) {
			removeItems.push(ind - 1);
		}

		attrId = cont.attr_id;
		taskgrpid = cont.task_group_id;
	});

	//Remove the low proprity duplicate content
	if (removeItems.length > 0) {
		removeItems.reverse();
		removeItems.forEach((ind) => {
			taskContents.splice(ind, 1);
		});
	};

	//clone and sort the content
	let contentCopy = taskContents.slice();
	// contentCopy.sort(function (obj1, obj2) {

	// 	if (obj1.task_group_id < obj2.task_group_id) { return -1; }
	// 	if (obj1.task_group_id > obj2.task_group_id) { return 1; }
	// 	if (obj1.group < obj2.group) { return -1; }
	// 	if (obj1.group > obj2.group) { return 1; }

	// 	return 0;
	// });
	let op = [];
	let tg_id = 0;
	let firstTime = true;
	let groupName = '';
	let obj1 = {};
	let obj2 = {};

	contentCopy.forEach((data, ind) => {
		if ((data.task_group_id != tg_id ) && tg_id != 0) {
			firstTime = true;
			op.push(obj2);
		};

		if (firstTime) {
			obj2 = Object.assign({}, obj1);
		}

		groupName = data.group;

		if (firstTime && groupName) {
			obj2[groupName] = {};
			obj2[groupName][data.type] = data.value;
		} else if (groupName) {
			if (!obj2[groupName]) {
				obj2[groupName] = {};
				obj2[groupName][data.type] = data.value;
			} else {
				obj2[groupName][data.type] = data.value;
			}
			
		}

		tg_id = data.task_group_id;
		firstTime = false;
	});

	if ( obj2 )
		op.push(obj2);
	


	task.content = op;
	//console.log(removeItems);
}

function processSubVersioning(op, versioncode){
	var contentVideoIndex = findIndexInData(op.tasks, 'name', 'Video');
	if(versioncode.toLowerCase()  === 'es'){
		var essential = groupByEssential('essential', op.tasks[contentVideoIndex].content);
		op = cleanEssential(op, contentVideoIndex, 'essential');

		var questions = groupByQuestion(op.tasks);
		op.tasks[contentVideoIndex].content.push({'essential' : essential , 'questions' : questions});
		op = cleanQuestions(op);
	}else{
		var questions = groupByQuestion(op.tasks);
		op.tasks[contentVideoIndex].content[1]['questions'] = questions;
		op = cleanQuestions(op);
	}
	return op;
}

function findIndexInData(data, property, value) {
	for(var i = 0, l = data.length ; i < l ; i++) {	
	  if(data[i][property] === value) {
		return i;
	  }
	}
	return -1;
  }

function groupByEssential(key, array) {
	var result = [];
	for (var i = 0; i < array.length; i++) {
		if(array[i][key] != null){
			result.push(array[i][key]);
		}
	}
	return result;
  }
  
 function groupByQuestion(array){
	var result = [];
	for (var i = 0; i < array.length; i++) {
		if(array[i].name.match('Question') != null){
			result.push(array[i]);
		}
	}
	return result;
 }
 
 function cleanEssential(op, index, key){
	for (var i = 0; i < op.tasks[index].content.length; i++) {
		if(op.tasks[index].content[i][key] != null){
			op.tasks[index].content.splice(i, 1);
			cleanEssential(op, index, key);
		}
	}
	return op;
 }
 
 function cleanQuestions(op){
	for (var i = 0; i < op.tasks.length; i++) {
		if(op.tasks[i].name.match('Question') != null){
			op.tasks.splice(i, 1);
			cleanQuestions(op);
		}
	}
	return op;
 };



module.exports = router;
