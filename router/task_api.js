var express = require('express');
const router = express.Router();

// Import User Module Containing Functions Related To User Data
var task = require('../models/task');
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

router.post('/getalltasks', function(req, res) {
    var data = req.body;
    //console.log('Get all tasks request: ', req);
	task.getAllTasks(data, function(err, rows, fields) {
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

	task.findTask(req.params, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
			//throw err
		};
		res.status(200).send(rows);
	})
});

router.post('/', function(req, res) {
	console.log('API TASK CREATE REQUEST: ', req.body);
	var data = req.body.taskMeta ? req.body.taskMeta : req.body;
	if (data.name) {
		task.createTask(data, function(err, rows, fields) {
			if(err) {
				console.log('Error: ', err);
			};
			res.status(200).send(rows);
		})
	}
	else {
		res.status(200).send({});
	}
});

router.put('/', function(req, res) {
	console.log('API TASK UPDATE REQUEST: ', req.body);
	var data = req.body;
	task.updateTask(data, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
		};
		res.status(200).send(rows);
	})
});

router.get('/', function(req, res) {
    
    //console.log('Get all tasks request: ', req);
	task.getalltaskslist( function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
			//throw err
        };
        console.log('rows: ', rows)
		res.status(200).send(rows);
	})
});

router.get('/gettemplatecontentvalue/:key', function(req, res) {
	console.log('Get all users request: ', req.params)
	//console.log('req.params: ', req.params.key);
	task.findTemplateContentValue(req.params, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
			//throw err
		};
		res.status(200).send(rows);
	})
});

router.get('/getcontentvalue/:group/:attr', function(req, res) {
	console.log('Get all users request: ', req.params)
	//console.log('req.params: ', req.params.key);
	task.findContentValue(req.params, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
			//throw err
		};
		res.status(200).send(rows);
	})
});

router.get('/checkcontentitem/:key', function(req, res) {

	console.log('-req.body: ', req.body);
	console.log('-params: ', req.params);

	task.checkContentItem(req.params, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
			//throw err
		};

		res.status(200).send(rows);
	});
});

router.get('/checkcontentitem/:attrid/:groupid/:versionid', function(req, res) {

	console.log('-params: ', req.params);

	task.checkContentItemV1(req.params, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
			//throw err
		};
		res.status(200).send(rows);
	})
});

router.get('/checklocalcontentitem/:key/:lang_code/:country_code', function(req, res) {
	
	console.log('-req.body: ', req.body);
	console.log('-params: ', req.params);

	task.checkLocalContentItem(req.params, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
			//throw err
		};
		res.status(200).send(rows);
	})
});

router.get('/getcontentlocal/:key/:lang', function(req, res) {
	
	console.log('key: ', req.params.key);
	console.log('lang: ', req.params.lang);
	
	task.findContentLocal(req.params, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
			//throw err
		};
		res.status(200).send(rows);
	})
});

router.put('/linklessontask/:lesson_id/:task_id', function(req, res) {
	
	console.log('API COURSE UPDATE REQUEST: ', req.body);
	var data = req.body;
	task.checkLinkLessonTask(data, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
		};
		console.log('rows: ', rows);
		if(rows.length === 0){
			
			task.setLinkLessonTask(data, function(err, rows, fields) {
				if(err) {
					console.log('Error: ', err);
				};
				console.log('rows: ', rows);
				res.status(200).send(rows);
			})

		}
		//res.status(200).send(rows);
	})
});

router.put('/updateorderofgroup/:group_id/:order', function(req, res) {
	console.log('API TASK UPDATE REQUEST: ', req.params);
	var data = req.params;

	task.updateOrderofGroup(data, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
		};
		res.status(200).send(rows);
	})
	
});

router.put('/updatecontentitem', function(req, res) {
	console.log('API CONTENT UPDATE UPDATE REQUEST: ', req.body);
	
	var data = req.body;
	console.log(data)
	task.updateContentItem(data, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
		};
		res.status(200).send(rows);
	})
});

router.put('/updatecontentitem/:attrid/:groupid/:versionid', function(req, res) {
	console.log('API CONTENT UPDATE UPDATE REQUEST: ', req.body);
	
	var data = req.body;
	var params = req.params;
	console.log(data)
	task.updateContentItemV1(data, params, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
		};
		res.status(200).send(rows);
	})
});

router.put('/updateattrversion', function(req, res) {
	console.log('PUT ATTR VERSION REQUEST: ', req.body);
	
	var data = req.body;
	console.log(data)
	task.updateAttrVersion(data, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
		};
		if (rows && rows.insertId && rows.insertId > 0) {
			task.updateAttrVersionInContent(rows.insertId, function(err, row) {
				if(err) {
					console.log('Error: ', err);
				};
				if (row && row.insertId && row.insertId > 0) { 
					res.status(200).send(rows);
				}
			});
		}
		
	})
});

router.delete('/removeattrversion/:content_id', function(req, res) {
	console.log('REMOVE ATTR VERSION REQUEST: ', req.params);

	var data = req.params;
	console.log(data)

	task.deleteAttrVersion(data, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
		};
		res.status(200).send(rows);
	})
});

router.put('/updatelocalcontentitem', function(req, res) {
	console.log('API CONTENT UPDATE UPDATE REQUEST: ', req.body);
	
	var data = req.body;

	console.log(data)
	task.updateLocalContentItem(data, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
		};
		res.status(200).send(rows);
	})
});

router.post('/createcontentitem/', function(req, res) {
	console.log('API CONTENT CREATE UPDATE REQUEST: ', req.body);
	
	var data = req.body;
	console.log(data);
	task.createContentItem(data, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
		};

		if (rows) {
			task.createContent(rows.insertId, 2, function(err, rows1, fields) {
				if(err) {
					console.log('Error: ', err);
				};
				res.status(200).send(rows1);
			});
		}
	})
});

router.post('/addtermstotask/', function(req, res){
	var data = req.body;
	console.log(data);

	task.addTermsToTask(data, function(err, rows){
		if(err) {
			console.log('Error: ', err);
			res.status(200).send({});
		};

		if (rows) {
			res.status(200).send(rows);
		}
	});
});

router.post('/createlocalcontentitem/', function(req, res) {
	console.log('API CONTENT CREATE UPDATE REQUEST: ', req.body);
	
	var data = req.body;
	console.log(data)
	task.createLocalContentItem(data, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
		};
		res.status(200).send(rows);
	})
});

router.post('/createtaskgroup', function(req, res) {
	console.log('API TASK CREATE REQUEST: ', req.body);
	var data = req.body;
	task.createTaskGroup(data, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
		};
		res.status(200).send(rows);
	})
});

router.get('/gettasktype/:id', function(req, res) {
	//console.log('Get all users request: ', req)
	console.log('req.params>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>: ', req.params.id);

	task.findTaskType(req.params, function(err, rows, fields) {
		if(err) {
			console.log('Error>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>: ', err);
			//throw err
		};
		res.status(200).send(rows);
	})
});

router.get('/gettasktypegroups/:type_id/:task_id', function(req, res) {
	//console.log('Get all users request: ', req)
	console.log('req.params: ', req.params.id);

	task.findTaskTypeGroups(req.params, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
			//throw err
		};
		console.log('NEW REQUEST ROWS: ', rows);
		res.status(200).send(rows);
	})
});

router.get('/tasktypecontentoptions/getalltasktypegroups', function(req, res) {
	//console.log('Get all users request: ', req)
	task.findAllTaskTypeGroups(req.params, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
			//throw err
		};
		console.log('NEW REQUEST ROWS: ', rows);
		res.status(200).send(rows);
	})
});

router.get('/getalltasktypegroupsbytype/:id', function(req, res) {
	//console.log('Get all users request: ', req)
	console.log('req.params: ', req.params);

	task.findAllTaskTypeGroupsByType(req.params, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
			//throw err
		};
		console.log('NEW REQUEST ROWS: ', rows);
		res.status(200).send(rows);
	})
});

router.get('/gettaskattr/:id', function(req, res) {
	//console.log('Get all users request: ', req)
	console.log('req.params: ', req.params.id);

	task.findTaskAttr(req.params, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
			//throw err
		};
		let pendingTaskAttr = rows.length;
		
		for(let row of rows){
			if(row.type === 'truefalse'){
				console.log('BOOM THIS IS A DROP DOWN!')
				row.options = [
					{
						'value': 'true',
						'key': 2
					},
					{
						'value': 'false',
						'key': 1
					}
				]
				if(0 === --pendingTaskAttr || 0 === pendingTaskAttr){
					console.log(rows);
					res.status(200).send(rows);
				}
			} else {
				
				if(0 === --pendingTaskAttr || 0 === pendingTaskAttr){
					console.log(rows);
					res.status(200).send(rows);

				}
			}
		}
	})
});

router.get('/getattrversions/:group_id/:attr_id', function(req, res) {
	//console.log('Get all users request: ', req)
	console.log('req.params: ', req.params.id);

	task.findAttrVersions(req.params, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
			//throw err
		};
		console.log(rows);
		res.status(200).send(rows);
	})
});

router.get('/getattrverstatus/:id', function(req, res) {
	//console.log('Get all users request: ', req)
	console.log('req.params: ', req.params.id);

	task.findAttrVerStatus(req.params, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
			//throw err
		};
		console.log(rows);
		res.status(200).send(rows);
	})
});

router.get('/gettaskattrbylink/:id', function(req, res) {
	//console.log('Get all users request: ', req)
	console.log('req.params: ', req.params.id);

	task.findTaskAttrByLink(req.params, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
			//throw err
		};
		console.log(rows);
		res.status(200).send(rows);
	})
});

router.post('/linktaskterms', function(req, res) {

	console.log('API TASK CREATE REQUEST: ', req.body);
	let pendingterms = req.body.terms;

	// let curTerms = [] //req.body.terms.cur
	// let newTerms = req.body.terms.new
	
	// for(let term of req.body.terms.cur){
	// 	curTerms.push(term.term_id);
	// }

	let params = {
		task_id: req.body.task_id,
		termsToAdd: req.body.terms.add,
		termsToRemove: req.body.terms.delete
	}

	let pendingTermsToRemove = params.termsToRemove.length;
	let pendingTermsToAdd = params.termsToAdd.length;

	for(let term_remove of params.termsToRemove){
		console.log('term_remove: ', term_remove);
		console.log('task_id: ', params.task_id)
		
		term = {
			id: term_remove,
			task_id: params.task_id
		}
		
		task.deleteTaskDictionaryTermLink(term, function(err, rows, fields) {

			if (err) {
				console.log('Error: ', err);
			};

			if (rows) {
				if (rows.length > 0 && rows[0].length> 0) {
					task.deleteContent(rows[0][0]['task_dictionary_id'], 3, function(err, rows1, fields) {
						if (err) {
							console.log('Error: ', err);
						};
					});
				}

				console.log('Term Deleted: ', term);

				if( 0 === --pendingTermsToRemove || 0 === pendingTermsToRemove) {
					
					if( 0 === pendingTermsToAdd ) {
						console.log('======================================');
						console.log('======( ALL TERM LINKS REMOVED )======');
						res.status(200).send(rows);
					}
				}
			}

		});
	}
	
	for(let term_add of params.termsToAdd){
		console.log('term_add: ', term_add);
		console.log('task_id: ', params.task_id)
		
		term = {
			id: term_add,
			task_id: params.task_id
		}
		
		task.addTaskDictionaryTermLink(term, function(err, rows, fields) {
			if(err) {
				console.log('Error: ', err);
			};
			if(rows){
				console.log('Term Added: ', term)
				
				if (rows.insertId) {
					task.createContent(rows.insertId, 3, function(err, rows1, fields) {
						if(err) {
							console.log('Error: ', err);
						};
					});
				}

				if( 0 === --pendingTermsToAdd || 0 === pendingTermsToAdd) {
					
					if( 0 === pendingTermsToRemove ) {
						console.log('======================================');
						console.log('======( ALL TERM LINKS Added )======');
						res.status(200).send(rows);
					};
				}
			}
		})
	}
});

router.get('/findtaskattrgroupbytasktype/:task_type_id', function(req, res) {
	console.log('req.params:', req.params);

	task.findTaskAttrGroupByTaskType(req.params, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
			//throw err
		};
				console.log(rows);
		res.status(200).send(rows);
	})
});

router.get('/get/gettasktype', function(req, res) {
	task.getTaskType(req.param, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
			//throw err
		};
		console.log(rows);
		res.status(200).send(rows);
	})
});

router.get('/get/gettaskattrgroup', function(req, res) {
	task.getTaskAttrGroup(req.param, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
			//throw err
		};
		console.log(rows);
		res.status(200).send(rows);
	})
});

router.put('/updatetasktypeattrgroup', function(req, res) {
	task.updatetasktypeattrgroup(req.body, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
			//throw err
		};
		console.log(rows);
		res.status(200).send(rows);
	})
});

router.post('/updatetasktype', function(req, res) {
	task.inserttasktype(req.body, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
			//throw err
		};
		console.log(rows);
		res.status(200).send(rows);
	})
});

router.put('/updatetasktype', function(req, res) {
	task.updatetasktype(req.body, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
			//throw err
		};
		console.log(rows);
		res.status(200).send(rows);
	})
});

router.get('/findtasktypebyid/:type_id', function(req, res) {
	task.findtasktypeById(req.params, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
			//throw err
		};
		console.log(rows);
		if (rows.length > 0){
			res.status(200).send(rows[0]);
		}
		else {
			res.status(200).send({});
		}
		
	})
});

router.get('/tasktype/getalltasktypes', (req, res) => {
	task.getTaskTypes(req.params, (err, rows, fields) => {
		if(err) {
			console.log('Error: ', err);
		};
		console.log(rows);
		res.status(200).send(rows);
	})
})

router.delete('/deletetasktype/:type_id', (req, res) => {
	task.deletetasktype(req.params, (err, rows, fields) => {
		if(err) {
			console.log('Error: ', err);
			res.status(500).send(err);
		}
		else {
			res.status(200).send(true);
		}
	})
})

//Task attr group
router.post('/updatetaskattrgroup', function(req, res) {
	task.insertTaskAttrGroup(req.body, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
			//throw err
		};
		console.log(rows);
		res.status(200).send(rows);
	})
});

router.put('/updatetaskattrgroup', function(req, res) {
	task.updateTaskAttrGroup(req.body, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
			//throw err
		};
		console.log(rows);
		res.status(200).send(rows);
	})
});

router.get('/findtaskattrgroupbyid/:group_id', function(req, res) {
	task.findTaskAttrGroupById(req.params, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
			//throw err
		};
		console.log(rows);
		if (rows.length > 0){
			res.status(200).send(rows[0]);
		}
		else {
			res.status(200).send({});
		}
		
	})
});

router.get('/taskattrgroup/gettaskattrgroups', (req, res) => {
	task.getTaskAttrGroups(req.params, (err, rows, fields) => {
		if(err) {
			console.log('Error: ', err);
		};
		console.log(rows);
		res.status(200).send(rows);
	})
})

router.delete('/deletetaskattrgroup/:group_id', (req, res) => {
	task.deleteTaskAttrGroup(req.params, (err, rows, fields) => {
		if(err) {
			console.log('Error: ', err);
			res.status(500).send(err);
		}
		else {
			res.status(200).send(rows);
		}
		console.log(rows);
		
	})
})

router.delete('/:id', (req, res) => {
	task.deleteTask(req.params, (err, rows, fields) => {
		if(err) {
			console.log('Error: ', err);
			res.status(500).send(err);
		}
		else {
			res.status(200).send(rows);
		}
		
		console.log(rows);
	})
})

router.get('/taskfullinfo/:id', function(req, res) {
	task.taskFullInfo(req.params, function(err, rows, fields) {

		if(err) {
			console.log('Error: ', err);
		};

		console.log(rows);

		let finalData = processTaskMgmt(rows);


		if (finalData) {
			res.status(200).send(finalData);
		}
		else {
			res.status(200).send({});
		}

	});
});

router.delete('/taskdictionary/:id', function(req, res) {
	task.taskdictionarydelete(req.params, function(err, rows, fields) {

		if(err) {
			console.log('Error: ', err);
		};

		console.log(rows);

		res.status(200).send(rows);

	});
})

router.post('/addtotaskgroup', function(req, res) {
	var data = req.body;
	let groupid;
	// let finalop;
	task.createTaskGroup(data, function(err, rows){
		console.log(rows[1]['insertId']);
		groupid = +rows[1]['insertId'];

		if (groupid > 0) {
			task.createTaskContent(groupid, data.attributes, function(err, rows1){
				console.log(rows1);
				//finalop = rows;
				
				let op = rows1[rows1.length - 2][0];
				op.content = rows1[rows1.length - 1];
				
				res.status(200).send(op);
			});
		}
	});
})

router.delete('/deletegroup/:id', function(req, res) {
	task.deleteGroup(req.params.id, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
		};
		res.status(200).send(rows);
	});
});

router.put('/changetaskgrouporder', function(req, res) {

	let data = req.body;

	task.changeTaskGroupOrder(data, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
		};
		res.status(200).send(rows);
	});
});

// router.get('/gettaskattrswithvaluebygroupid/:id', function(req, res) {

// 	let params = req.params;

// 	task.taskAttrsWithValueByGroupId(params, function(err, rows, fields) {
// 		if(err) {
// 			console.log('Error: ', err);
// 		};
// 		res.status(200).send(rows);
// 	});
// });

router.put('/updatetaskcontent', (req, res) => {
	let data = req.body;

	task.updateTaskContent(data, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
		};
		res.status(200).send(rows);
	});
});

router.get('/getversionsunselected/:groupid/:attrid', (req, res) => {
	task.findVersions(req.params, function(err, rows, fields) {
			if(err) { console.log('Error: ', err) };
			res.status(200).send(rows);
	});
})

router.get('/gettaskcontentbygroupid/:groupid', (req, res) => {
	task.getTaskContentByGroupId(req.params, function(err, rows, fields) {
			if(err) { console.log('Error: ', err) };
			res.status(200).send(rows);
	});
})

router.post('/addversioncontent', (req, res) => {
	let data = req.body;
	task.addVersionContent(data, function(err, rows, fields) {
		if(err) { console.log('Error: ', err) };
		res.status(200).send(rows);
	});
})

function processTaskMgmt(data) {
	if (!(data && data.length && data.length > 0 && data[0][0])) {
		return {};
	}

	let task = data[0][0];
	let content = data[1];
	let dictionary = data[2];
	let taskInfo = {
		task_id: task['task_id'], 
		type_id: task['type_id'], 
		status_id: task['status_id'], 
		name: task['name'], 
		description: task['description'], 
		lock_type_id: +task['lock_type'], 
		lock_time:task['lock_time'], 
		heading: '', 
		display_main: task['display_main'], 
		display_next: task['display_next'], 
		display_innav: task['display_innav'],
		groups: [],
		dictionary:[]
	};

	let isLastItem = false;

	if (content && content.length > 0) {
		let task_group_id = 0;
		let group = {};

		content.forEach(element => {
			
			isLastItem = true;
			if (task_group_id === 0) {
				group = { 
					group_id : element['task_group_id'],
					tagname : element['tagname'],
					icon :  element['icon'],
					order : element['tgorder'],
					content : []
				};

				
			}

			if ( task_group_id != 0  && task_group_id != element['task_group_id'] ) {
				isLastItem = false;
				task_group_id = element['task_group_id'];
				taskInfo.groups.push( group );

				group = { 
					group_id : element['task_group_id'],
					tagname : element['tagname'],
					icon :  element['icon'],
					order : element['tgorder'],
					content : []
				};
			}

			task_group_id = element['task_group_id'];

			group.content.push({
				id: element['task_content_id'],
				attrid: element['attr_id'],
				label: element['label'],
				placeholder: element['placeholder'],
				default_value: element['default_value'],
				value: element['value'],
				type : element['tatype'],
				element : element['taelement'],
				version : element['version_id'],
				version_name : element['version_name']
			})
		});

		if (isLastItem) { 
			taskInfo.groups.push( group );
		}
	}

	if (dictionary && dictionary.length != undefined  && dictionary.length > 0) {
		taskInfo.dictionary = dictionary;
	}

	return taskInfo;
}

module.exports = router;