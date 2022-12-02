var express = require('express');
const router = express.Router();

// Import User Module Containing Functions Related To User Data
var localize = require('../models/localize');
var dictionary = require('../models/dictionary');
var server = require('../models/server');

var course;
var lessons;
var task;
var country_code;
var lang_code;
var response;

var pendingCourses = 0;
var pendingLessons = 0;
var pendingTasks = 0;

// var keycloak = require('../keycloak-middleware');

// // middleware that is specific to this router
// router.use(keycloak.protect(), function timeLog(req, res, next) {
// 	// This function called everytime you access any of the below routes
// 	console.log('Time: ', Date.now());
// 	next();
// })

router.get('/translation/:lessoncode/:countrycode/:languagecode/:vehiclecode?/:versioncode?', function(req, res) {
	console.log('API CONTENT CREATE UPDATE REQUEST: COMING HERE', req.params);

    localize.gettranslation(req.params, function(err, rows) {
		if(err) {
			console.log('Error: ', err);
        };
        let data = processTranslationContent(rows);
		res.status(200).send(data);
	});
});

router.get('/:type/:id/:country_code/:lang_code', function(req, res) {
    // REQUIRED PARAMS
    // ===============
    // type
    // id
    // OPTIONAL PARAMS
    // ===============
    // country_code
    // lang_code
    console.log('req.params: ', req.params);
    country_code = req.params.country_code;
    lang_code = req.params.lang_code;
    //response = res;

    if (req.params.type === 'course') {
        getCourse(req.params, res);
    } else if (req.params.type === 'lesson') {
        getLesson(req.params, res);
    } else if (req.params.type === 'task') {

        req.params.task_id = req.params.id;
        console.log('@@@@@@@@@@@@@@@@@@@@@@@@@@ 1) req.params: ', req.params);
        course = [];
        lesson = [];

        course.push(lesson);
        getTask(req.params, res);
    }
});

router.get('/validation/checklocalcontentitem/:key/:lang_code/:country_code', function(req, res) {
	
	console.log('-req.body: ', req.body);
	console.log('-params: ', req.params);

	localize.checkLocalContentItem(req.params, function(err, rows, fields) {
        
		if(err) {
			console.log('Error: ', err);
			//throw err
        };
        
		res.status(200).send(rows);
	});
});

router.put('/', function(req, res) {
	console.log('API CONTENT UPDATE UPDATE REQUEST: ', req.body);
	
	var data = req.body;

	console.log(data)
	localize.updateLocalContentItem(data, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
		};
		res.status(200).send(rows);
	})
});

router.post('/', function(req, res) {
	var data = req.body;
	console.log(data)
	localize.createLocalContentItem(data, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
		};
		res.status(200).send(rows);
	})
});

router.post('/updateContent', function(req, res) {
	console.log('API CONTENT CREATE UPDATE REQUEST: ', req.body);
	
    var data = req.body;
    let sql = buildContentSqlScript(data);
    console.log(data)
    // console.log(sql)
	localize.updateLocalContent(sql, function(err, rows, fields) {
		if(err) {
			console.log('Error: ', err);
		};
		res.status(200).send(rows);
	})
});

function buildContentSqlScript(data) {
    let sql = ``;

    data.newlist.forEach(element => {
        sql += `INSERT INTO translation (type_id, content_id, value, language_code, country_code) 
        VALUE (2, ${element.contentid}, '${element.translationvalue}', '${data.languagecode}', '${data.countrycode}')
        ON DUPLICATE KEY UPDATE value = '${element.translationvalue}';`
    })

    data.updatelist.forEach(element => {
        sql += `UPDATE translation t SET t.value='${element.translationvalue}' WHERE t.translation_id = ${element.translation_id};`
    })

    data.newdictionarylist.forEach(element => {
        sql += `INSERT INTO translation (type_id, content_id, value, language_code, country_code) 
        VALUE (3, ${element.contentid}, '${element.translationvalue}', '${data.languagecode}', '${data.countrycode}')
        ON DUPLICATE KEY UPDATE value = '${element.translationvalue}';`
    })

    data.updatedictionarylist.forEach(element => {
        sql += `UPDATE translation t SET t.value='${element.translationvalue}' WHERE t.translation_id = ${element.translation_id};`
    })

    return sql;
}

function processTranslationContent(data) {
	if (!(data[0] && data[0].length && data[0].length > 0)) {
		return {};
    }

    let isLastItem = false;
    // let isTaskChanged = false;
    let contentlist = [];
    let task_content = data[0];
    let dictionary_content = data[1];

    // let taskid = 0;
    // let task_group_id = 0;
    let group = {};
    let content = {};
    let attribute = {};

    const taskids = [...(new Set(task_content.map(({task_id}) => task_id)))] 
    
    taskids.forEach(taskid => {
        content = {
            taskid: taskid,
            taskname: '',
            groups: [],
            dictionary: getDictionary(taskid, dictionary_content)
        };
        let contenlist = getTaskItems(taskid, task_content);
        //Unique task Ids and removes the duplicates
        let task_group_ids = [...(new Set(contenlist.map(({task_group_id}) => task_group_id)))];

        task_group_ids.forEach(task_group_id => {
           
            group = {
                id: task_group_id,
                name: '',    
                icon: '', 
                attributes: []           
            }

            let attributes = getAttributeItems(task_group_id, contenlist);
            attributes.forEach(attr => {
                    attribute = {
                        name: attr.taskattributename,
                        contentid: attr.content_id,
                        value: attr.value,
                        translationvalue: attr.translationvalue,
                        placeholder: attr.placeholder,
                        label: attr.label,
                        defaultvalue: attr.default_value,
                        type: attr.type,
                        element: attr.element,
                        altered: false,
                        translation_id: attr.translation_id,
                        version_id: attr.version_id,
                        version_name: attr.version_name,
                        isnew: attr.translation_id ? false : true
                    }
                    if (group.name === '') {
                        group.name = attr.taskattributegroupname;
                        group.icon = attr.icon;
                        if (content.taskname === '') {
                            content.taskname = attr.taskname;
                        }
                    }
                    group.attributes.push(attribute);
            });

            content.groups.push(group);
        });

        contentlist.push(content);
    });

    
    return contentlist;
}

function getDictionary(taskid, dictionarylist) {
    return dictionarylist.filter((dict) => {
        return dict.task_id == taskid;
    });
}

function getTaskItems(taskid, content) {
    return content.filter((cont) => {
        return cont.task_id == taskid;
    });
}

function getAttributeItems(task_group_id, content) {
    return content.filter((cont) => {
        return cont.task_group_id == task_group_id;
    });
}

function getTask(params, res) {

    console.log('@@@@@@@@@@@@@@@@@@@@@@@@@@ 2) params: ', params);

    // REQUIRED PARAMS
    // ===============
    // lesson_code

	localize.getTaskData(params, (t_err, t_rows) => {
        if(t_err) { console.log('Error: ', t_err);}// throw t_err }
        else {
            console.log('@@@@@@@@@@@@@@@@@@@@@@@@@@ 3) t_rows: ', t_rows)
            task = t_rows[0]
            pendingTasks =  t_rows.length;

                getTaskGroups(task, res);

            // if( 0 === --pendingTasks ) {
                
            // } else {
            //     console.log('MULTIPLE TASKS WITH CODE: ', params.task_id);
            // }
        };
    });
}

function getTaskGroups(task, res) {

    // REQUIRED PARAMS
    // ===============
    // task_id

    localize.getTaskGroups(task, (tg_err, tg_rows) => {
        if(tg_err) { console.log('Error: ', tg_err);}// throw tg_err }
        else {

            task.groups = [];
            console.log('lg_rows: ', tg_rows)

            let pendingTaskGroups = tg_rows.length;
            if(tg_rows.length > 0){

                for(let i in tg_rows){

                    task.groups.push(tg_rows[i]);

                    if( 0 === --pendingTaskGroups || 0 === pendingTaskGroups) {
                        console.log('============================');
                        console.log('===========(task)===========');
                        console.log('task: ', task)
                        getTaskGroupContent(task, res);
                    }
                }
            }else {
                if( 0 === --pendingTaskGroups ) {
                    //getTaskGroupContent(lesson);
                }
            }
        }
    })
}

function getTaskGroupContent(task, res) {
    // REQUIRED PARAMS
    // ===============
    // tg_id (task_group_id)

    if(task.groups.length > 0){

        let pendingTaskGroups = task.groups.length;
        for(let tgroup_idx in task.groups){

            console.log('===================================================');
            console.log('pendingTaskGroups: ', pendingTaskGroups)
            console.log('===================================================');

            localize.getTaskGroupContent(task.groups[tgroup_idx], (tgc_err, tgc_rows) => {
                if(tgc_err) { console.log('Error: ', tgc_err);}// throw tgc_err }
                else {
                    task.groups[tgroup_idx].content = [];
                    if(tgc_rows.length > 0){

                        let pendingTaskGroupContent = tgc_rows.length;
                        
                        console.log('===================================================');
                        console.log('pendingTaskGroupContent: ', pendingTaskGroupContent)
                        console.log('===================================================');

                        for(let tgc_idx in tgc_rows){
                            console.log('field: ', tgc_rows[tgc_idx].content_id);
                            console.log('field.type: ', tgc_rows[tgc_idx].type);
                            let contentItem = {
                                content_id: tgc_rows[tgc_idx].content_id,
                                lang_code: lang_code,
                                country_code: country_code
                            }

                            localize.getContentTranslation(contentItem, (tgct_err, tgct_rows) => {
                                if(tgct_err) { console.log('Error: ', tgct_err);}// throw tgct_err }
                                
                                else {
                                    console.log('CONTENT_VALUE: ', tgct_rows[0])
                                    if(tgct_rows.length > 0){
                                        
                                        tgc_rows[tgc_idx].content_value = tgct_rows[0].value;
                                        task.groups[tgroup_idx].content.push(tgc_rows[tgc_idx])

                                        if( 0 === --pendingTaskGroupContent) {
                                            if (0 === --pendingTaskGroups) {
                                                if( 0 === --pendingTasks ) {
                                                    console.log('end-4');
                                                    getTaskTerms(task, res);
                                                    //reqComplete(task, res);
                                                };
                                            }
                                        }

                                    } else {
                                        tgc_rows[tgc_idx].content_value = '';
                                        task.groups[tgroup_idx].content.push(tgc_rows[tgc_idx])

                                        if( 0 === --pendingTaskGroupContent) {
                                            if (0 === --pendingTaskGroups) {
                                                if( 0 === --pendingTasks ) {
                                                    console.log('end-3');
                                                    getTaskTerms(task, res);
                                                    //reqComplete(task, res);
                                                };
                                            }
                                        }
                                    }
                                }

                                console.log('*******************************************')
                                console.log('tgct_rows: ', tgc_rows[tgc_idx])
                                console.log('*******************************************')

                            
                            });
                            

                        }
                    } else {
                        if( 0 === --pendingTaskGroups ) {
                            if( 0 === --pendingTasks ) {
                                console.log('end-2');
                                getTaskTerms(task, res);
                                //reqComplete(task, res);
                            }
                        }
                    }
                }

            })

            // if( 0 === --pendingTasks ) {
            //     lesson.tasks[task_idx].content[cgroup_idx] = contentBlock;
            //     reqComplete(lesson, res);
            // }
        }
    } else {
        if( 0 === pendingTasks ) {
            lesson.tasks[task_idx].content[cgroup_idx] = contentBlock;
            console.log('end-1');

            getTaskTerms(task, res);
            //reqComplete(task, res);
        }
    }


}

function getTaskTerms(task, res) {

    // REQUIRED PARAMS
    // ===============
    // task_id

    let taskDetails = {
        task_id: task.task_id,
        lang_code: lang_code,
        country_code: country_code
    }
    console.log('TASK DETAILS: ', taskDetails)

    localize.getTaskTerms(taskDetails, (dt_err, dt_rows) => {
        if(dt_err) { console.log('Error: ', dt_err);}// throw tg_err }
        else {

            task.terms = [];
            console.log('TERMS dt_rows: ', dt_rows)

            if(dt_rows.length > 0){
                let pendingTaskTerms = dt_rows.length;

                for(let i in dt_rows){

                    dt_rows[i].taskDetails = taskDetails;

                    localize.getTaskTermsLocal(dt_rows[i], (dlt_err, dtl_rows) => {
                        
                        //if(dlt_err) { console.log('Error: ', dtl_err)}
                        
                        if(dtl_rows.length > 0) {
                            dt_rows[i].content_value = dtl_rows[0].content_value;

                            console.log('DICTIONARY TERM: ', dt_rows[i]);
                            task.terms.push(dt_rows[i]);
        
                            if( 0 === --pendingTaskTerms || 0 === pendingTaskTerms) {
                                console.log('============================');
                                console.log('===========(task)===========');
                                console.log('task: ', task)
                                reqComplete(task, res);
                            }

                        } else {

                            task.terms.push(dt_rows[i]);
                            console.log('DICTIONARY TERM: ', dt_rows[i]);
        
                            if( 0 === --pendingTaskTerms || 0 === pendingTaskTerms) {
                                console.log('============================');
                                console.log('===========(task)===========');
                                console.log('task: ', task)
                                reqComplete(task, res);
                            }
                        }


                    });




                }
            }else {
                    reqComplete(task, res);
            }
        }
    })
}
// function getTaskTermsLocal(task, res) {

//     // REQUIRED PARAMS
//     // ===============
//     // task_id

//     let taskDetails = {
//         task_id: task.task_id,
//         lang_code: lang_code,
//         country_code: country_code
//     }
//     console.log('TASK DETAILS: ', taskDetails)

//     localize.getTaskTermsLocal(taskDetails, (dt_err, dt_rows) => {
//         if(dt_err) { console.log('Error: ', dt_err);}// throw tg_err }
//         else {
//         }
//     }
// }

function reqComplete(task, res) {
    console.log('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@')
    console.log('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@')
    console.log('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@')
    console.log('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@')
    console.log('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@')
    
    console.log('---------------- HERE 1 > ----------------')
    console.log('pendingCourses: ', pendingCourses);
    console.log('pendingLessons: ', pendingLessons);
    console.log('pendingTasks: ', pendingTasks);
    // console.log('pendingTaskGroups: ', pendingTaskGroups);
    // console.log('pendingTaskGroupContent: ', pendingTaskGroupContent);
    console.log('---------------- < HERE 1 ----------------')



    console.log('complete! ', country_code + ' - ' + lang_code);
    //console.log('TASK: ', task);
    res.status(200).send(task);

    console.log('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@')
    console.log('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@')
    console.log('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@')
    console.log('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@')
    console.log('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@')
};

//https://codeburst.io/node-js-mysql-and-promises-4c3be599909b

router.get('/getVehicleLocalization/:code', function (req, res) {
	console.log('req.params: ', req.params.code);
	localize.getVehicleLocalization(req.params, function (err, rows) {
		if (err) {
			console.log('Error: ', err);
			res.status(500).send(err);
		};
		res.status(200).send(rows);
	})
});

router.get('/getVersionLocalization/:code', function (req, res) {
	console.log('req.params: ', req.params.code);
	localize.getVersionLocalization(req.params, function (err, rows) {
		if (err) {
			console.log('Error: ', err);
			res.status(500).send(err);
		};
		res.status(200).send(rows);
	})
});

router.get('/getVehicleVersion/:lessoncode/:vehiclecode', function (req, res) {
	console.log('req.params: ', req.params);
	localize.getVehicleVersion(req.params, function (err, rows) {
		if (err) {
			console.log('Error: ', err);
			res.status(500).send(err);
		};
		res.status(200).send(rows);
	})
});


module.exports = router;