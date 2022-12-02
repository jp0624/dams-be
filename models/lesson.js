var mysql = require('mysql');
var env = process.env.NODE_ENV || 'dev';
var config = require('../config')[env];

var connection = require('./connection');
var sqlClean = require('./_sql_clean');
var mongodb = require('mongodb');
var fs = require('fs');

module.exports.getAllLessons = function (callback) {
    connection.query(`
    SELECT  l.lesson_id AS 'id',
        l.name,
        l.code,
        l.description,
        IFNULL(s.name, '') AS 'status',
        IFNULL(lt.name, '') AS 'Type',
        IFNULL(v.name, '') AS 'Vehicle'
    FROM lesson AS l
    LEFT JOIN status AS s
    ON l.status_id = s.status_id
    LEFT JOIN lesson_type AS lt
    ON l.type_id = lt.type_id
    LEFT JOIN vehicle AS v 
    ON l.vehicle_id = v.vehicle_id;
    `, callback);
}

module.exports.getAllDistinctLessons = function (callback) {
    connection.query(`
    SELECT  l.lesson_id AS 'id',
        l.name,
        l.code,
        l.description,
        IFNULL(s.name, '') AS 'status',
        IFNULL(lt.name, '') AS 'Type',
        IFNULL(v.name, '') AS 'Vehicle'
    FROM lesson AS l
    LEFT JOIN status AS s
    ON l.status_id = s.status_id
    LEFT JOIN lesson_type AS lt
    ON l.type_id = lt.type_id
    LEFT JOIN vehicle AS v 
    ON l.vehicle_id = v.vehicle_id
    GROUP BY l.code;
    `, callback);
}

module.exports.publishAllLessons = function (callback) {
    connection.query(`SELECT DISTINCT
    c.code AS course_code,
    l.code AS lesson_code,
    t1.country_code,
    t1.language_code,
    v1.code AS vehicle_code,
    NULL AS version_code,
    cv.device AS device_code
  FROM lesson l
         INNER JOIN course_lesson cl
           ON l.lesson_id = cl.lesson_id
         INNER JOIN course c
           ON cl.course_id = c.course_id
         INNER JOIN vehicle v1
           ON l.vehicle_id = v1.vehicle_id
         INNER JOIN lesson_task lt
           ON l.lesson_id = lt.lesson_id
         INNER JOIN task t
           ON lt.task_id = t.task_id
         INNER JOIN task_group tg
           ON t.task_id = tg.task_id
         INNER JOIN task_content tc
           ON tc.task_group_id = tg.task_group_id
         INNER JOIN content c1
           ON c1.content_item_id = tc.task_content_id
         INNER JOIN translation t1
           ON t1.content_id = c1.content_id,
       (SELECT DISTINCT
           device
         FROM content_version) cv`, callback);
}
module.exports.findLesson = function (params, callback) {
    sqlClean.escapeObjectStrings(params);
    //SELECT *
    connection.query(`
        SELECT  code,
                description,
                lesson_id AS 'id',
                name,
                status_id,
                url_private,
                vehicle_id,
                type_id,
                version_id
            FROM lesson
        WHERE lesson_id = '` + params.id + `'
    `, callback);
}

module.exports.updateLesson = function (data, callback) {
    sqlClean.escapeObjectStrings(data);
    let type_id = data.type_id || 'null';
    let version_id = data.version_id || 'null';
    //Console.log('------------------------------------------', data);
    console.log('SQL LESSON UPDATE REQUEST: ', data)
    connection.query(`
        UPDATE lesson
            SET name = '` + data.name + `',
                code = '` + data.code + `',
                description = '` + data.description + `',
                status_id = '` + data.status_id + `',
                url_private = '` + data.url_private + `',
                vehicle_id = '` + data.vehicle_id + `',
                type_id = ` + type_id + `
        WHERE lesson_id = '` + data.id + `'
    `, callback);
}

module.exports.updateLessonTasksOrder = function (data, callback) {
    sqlClean.escapeObjectStrings(data);
    console.log('SQL LESSON UPDATE REQUEST: ', data)
    console.log('ORDER: ', data.order)
    console.log('LINK ID: ', data.link_id)
    connection.query(`
        UPDATE lesson_task
            SET _order = '` + data.order + `'
        WHERE lesson_task_id = '` + data.link_id + `'
    `, callback);
}

module.exports.checkLinkCourseLesson = function (data, callback) {
    sqlClean.escapeObjectStrings(data);
    console.log('SQL CHECK COURSE-LESSON LINK REQUEST: ', data)
    connection.query(`
        SELECT *
            FROM course_lesson
        WHERE
            lesson_id = '` + data.lesson_id + `'
            AND
            course_id = '` + data.course_id + `'
    `, callback);
}
module.exports.setLinkCourseLesson = function (data, callback) {
    sqlClean.escapeObjectStrings(data);
    console.log('SQL SET COURSE-LESSON LINK REQUEST: ', data)
    connection.query(`
        INSERT INTO course_lesson
            SET lesson_id = '` + data.lesson_id + `',
                course_id = '` + data.course_id + `'
    `, data, callback);
}
module.exports.createLesson = function (data, callback) {
    sqlClean.escapeObjectStrings(data);
    console.log('SQL LESSON CREATE REQUEST: ', data)
    let type_id = data.type_id || 'null';
    let version_id = data.version_id || 'null';
    connection.query(`
        INSERT INTO lesson
            SET name = '` + data.name + `',
                code = '` + data.code + `',
                description = '` + data.description + `',
                status_id = '` + data.status_id + `',
                url_private = '` + data.url_private + `',
                vehicle_id = '` + data.vehicle_id + `',
                type_id = ` + type_id + `,
                version_id = `+ version_id +`
    `, data, callback);
}

// Copy Lesson Start
module.exports.copyLesson = function (data, callback) {
    sqlClean.escapeObjectStrings(data);
    console.log('SQL COPY LESSON CREATE REQUEST: ', data)
    let type_id = data.type_id || 'NULL';
       /* let sqlQuery = `INSERT INTO lesson
                        SET name = '${data.name}',
                        code = '${data.code}',
                        description = '${data.description}',
                        status_id = '${data.status_id}',
                        url_private = '${data.url_private}',
                        vehicle_id = '${data.vehicle_id}',
                        type_id = '${type_id}',
                        version_id = '${data.version_id}';`;
            sqlQuery += ` SET @lessonId = LAST_INSERT_ID();`;
            sqlQuery += `INSERT INTO course_lesson (lesson_id,course_id,_order) 
                         SELECT @lessonId,course_id,_order FROM 
                         course_lesson WHERE lesson_id ='${data.id}';`;  
                         // stored procedure for copy lesson
            sqlQuery += `call copyLesson(${data.id}, @lessonId);`;*/
            sqlQuery = `call sp_create_subversions_lessons(${data.id}, ${data.name}, ${data.code}, ${data.description}, ${data.status_id}, ${data.url_private}, ${data.vehicle_id}, ${type_id})`;
    console.log(sqlQuery);
    connection.query(sqlQuery, data, callback);
}

module.exports.lessonVehicleVersionValidation = function (data, callback) {
    sqlClean.escapeObjectStrings(data);
    console.log('SQL VEHICLE TYPE CHECHKING REQUEST: ', data)   

    let qryString = '';
    if(data.vehicle_type) qryString += ` and l.vehicle_id='${data.vehicle_type}'`;
    // if(data.version_id) 
    //     qryString += ` and version_id ='${data.version_id}'`;
    // else
    //     qryString += ` and version_id IS NULL`;
     if(data.id)
         qryString += ` and lesson_id <> '${data.id}'`;
        let sqlQuery = `SELECT COUNT(*) as totalCount FROM lesson  l 
                        WHERE l.code ='${data.lesson_code}' ${qryString};`;                    
    console.log(sqlQuery);
    connection.query(sqlQuery, data, callback);
}
// Copy Lesson End
// lesson search start

module.exports.createSearch =  function (data, callback) {
    sqlClean.escapeObjectStrings(data);
    console.log('SQL LESSON SEARCH REQUEST: ', data)
    
    let languageCode = data.languagecode;
    let lessonCode   = data.lessoncode;
    let countryCode  = data.countrycode;
    let CourseCode   = data.coursecode;
    let statusCode   = data.statuscode;
    let vehicleCode  = data.vehiclecode;
    let queryString  = ' ';
    if(languageCode) queryString += `and lang.code = '`+languageCode+`'`;
    if(countryCode)  queryString += `and ctry.code = '`+countryCode+`'`;
    if(vehicleCode)  queryString += `and v.code = '`+vehicleCode+`'`;
    if(CourseCode)   queryString += `and c.code = '`+CourseCode+`'`;
    if(lessonCode)   queryString += `and l.code = '`+lessonCode+`'`;
    if(statusCode)   queryString += `and l.status_id = '`+statusCode+`'`;

    connection.query(`
    SELECT DISTINCT 
    sat.name as status,
    v.name as VechicleType,
    ctry.name as nameOfCountry,
    l.name as Lesson,
    lang.name as Language,
    c.code as Course
    FROM course as c INNER JOIN course_lesson as cl ON c.course_id = cl.course_id
    INNER JOIN  lesson as l ON l.lesson_id = cl.lesson_id
    INNER JOIN status as sat ON sat.status_id = l.status_id
    INNER JOIN  lesson_type as lt ON lt.type_id = l.type_id
    INNER JOIN  vehicle as v ON v.vehicle_id = l.vehicle_id
    INNER JOIN  lesson_task as ltask ON ltask.lesson_id = l.lesson_id
    INNER JOIN  task as t ON t.task_id = ltask.task_id INNER JOIN task_group tg ON tg.task_id = t.task_id
    INNER JOIN task_type_attr_group ttag ON ttag.group_id = tg.task_type_attr_group_id
    INNER JOIN task_type tt ON ttag.task_type_id =tt.type_id
    INNER JOIN task_attr_group tag ON tag.group_id = ttag.attr_group_id
    INNER JOIN task_attr ta ON ta.group_id = tag.group_id
    INNER JOIN task_content tc ON tc.task_group_id = tg.task_group_id AND ta.attr_id = tc.attr_id
    INNER JOIN content con ON con.content_item_id = tc.task_content_id AND con.content_type_id= 2
    LEFT OUTER JOIN translation t1 ON t1.content_id = con.content_id 
    LEFT OUTER JOIN country as ctry ON ctry.code = t1.country_code
    LEFT OUTER JOIN language as lang ON lang.code = t1.language_code
    WHERE 1 ` + queryString + `
    `, callback);
   
}
// lesson search end
/*
module.exports.findLesson = function(params, callback) {
sqlClean.escapeObjectStrings(params);
    connection.query(`
        SELECT  l.lesson_id AS 'lesson_id',
                l.name AS 'Name',
                l.code AS 'Code',
                l.description AS 'Description',
                l.url_private AS 'Private URL',
                s.name AS 'Status',
                v.name AS 'Vehicle'
            FROM lesson AS l
        INNER JOIN status AS s
            ON l.status_id = s.status_id
        INNER JOIN vehicle AS v
            ON l.vehicle_id = v.vehicle_id
        WHERE lesson_id = '` + params.id + `'
    `, callback);
}
*/

module.exports.findLessonVersions = function (params, callback) {
    sqlClean.escapeObjectStrings(params);
    connection.query(`
        SELECT *
            FROM lesson_version
        WHERE lesson_id = '` + params.id + `'
    `, callback);
}

module.exports.findLessonTasks = function (params, callback) {
    sqlClean.escapeObjectStrings(params);
    connection.query(`
    SELECT  t.task_id AS id,
            s.name AS 'status',
            t.name,
            tt.name AS 'type',
            lt.menu_display AS 'menu display',
            lt.section_marker AS 'section marker',
            lt.lesson_task_id AS 'link_id',
            lt._order AS 'order'
        FROM lesson_task AS lt
    INNER JOIN task AS t
        ON lt.task_id = t.task_id
    INNER JOIN status AS s
        ON t.status_id = s.status_id
    INNER JOIN task_type AS tt
        ON t.type_id = tt.type_id
    WHERE lt.lesson_id = '` + params.id + `'
    `
        , callback);
}

module.exports.findLessonInfo = function (params, callback) {
    sqlClean.escapeObjectStrings(params);
    connection.query(`
        SELECT  c.code course, l.code, v.code AS vehicle   FROM lesson l 
        INNER JOIN course_lesson cl ON l.lesson_id = cl.lesson_id
        INNER JOIN course c ON c.course_id = cl.course_id
        INNER JOIN vehicle v ON v.vehicle_id = l.vehicle_id 
        WHERE l.lesson_id = '` + params.id + `'`, callback);
}

module.exports.delete = function (params, callback) {
    sqlClean.escapeObjectStrings(params);
    connection.query(`
        DELETE FROM  lesson_task WHERE lesson_id = '` + params.id + `';
        DELETE FROM lesson WHERE lesson_id = '` + params.id + `';
        `
        , callback);
}

module.exports.exporttojson = function (params, callback) {

    sqlClean.escapeObjectStrings(params);

    let sql = `call sp_export_lesson_to_json(?, ?, ?, ?, ?,?);`;

    connection.query(sql, [params.countrycode, params.langcode, params.lessoncode,params.deviceId,params.vehiclecode, params.versioncode], callback);
}

module.exports.bulkexporttojson = function (params, callback) {

    sqlClean.escapeObjectStrings(params);

    let sql = `call sp_export_lesson_to_json(?, ?, ?, ?, ?,?);`;
    connection.query(sql, [params.country_code, params.language_code, params.lesson_code,params.device_code,params.vehicle_code, params.version_code], callback);
}
module.exports.storeLesson = function (data, callback) {
    // Get a Mongo client to work with the Mongo server
    var MongoClient = mongodb.MongoClient;
    var url = '';
    //In local environment
    url = `mongodb://${config.mongo.host}:${config.mongo.port}`;
    
    //In production environment
    if (config.mongo.user && config.mongo.password) {
        url = `mongodb://${config.mongo.user}:${config.mongo.password}@${config.mongo.host}:${config.mongo.port}`;
    }
    // Define where the MongoDB server is

    // Connect to the server
    MongoClient.connect(
        url,
        { useNewUrlParser: true },
        function (err, client) {
            if (err) {
                console.log('Unable to connect to the Server:', err);
            } else {
                console.log('Connected to Server');

                // Get the documents collection
                var db = client.db(`${config.mongo.database}`);
                //call update process
                processdb(db, data, function (err, result) {
                    // call Insert process
                    client.close();

                    return callback('', result);
                });
            }
        }
    );
};

module.exports.storeInFile = function (data,  callback) {
    data = JSON.parse(data);
    let versioncode = data.version_code;
    console.log('data.version_code',data.version_code);
    console.log('versioncode',versioncode);
    
    if (versioncode != null) {
    versioncode = versioncode.toLowerCase();   
    }
    console.log(data.version_code);
   
    const cocode = data.course_code.toLowerCase();
    const lcode = data.lesson_code.toLowerCase();
    const vcode = data.vehicle_code.toLowerCase();
    const ccode = data.country_code.toLowerCase();
    const lacode = data.lang_code.toLowerCase();
    const deviceId = data.device_code;
    const jsonFolderName = `json`;
    const defaultFolder = `default`;
    let fileName;    
    fileName = `default.json`;
    if (deviceId == 1)
      fileName = `default.json`;
    if (deviceId == 2)
      fileName = `mobile.json`;
    let path;
    if (data.version_code != null)
         path = `${config.lessonsFolderPath}${cocode}/${lcode}/${vcode}/${ccode}/${lacode}/${jsonFolderName}/${versioncode}`;
    else
        path = `${config.lessonsFolderPath}${cocode}/${lcode}/${vcode}/${ccode}/${lacode}/${jsonFolderName}/${defaultFolder}`;
  console.log(path);
    if ( !fs.existsSync(path) ) {
        let tempPath = `${config.lessonsFolderPath}${cocode}`;
        if (!fs.existsSync(tempPath)) {
            fs.mkdirSync(tempPath);
        }
    
        tempPath += '/' + lcode;
        if (!fs.existsSync(tempPath)) {
            fs.mkdirSync(tempPath);
        }
    
        tempPath += '/' + vcode;
        if (!fs.existsSync(tempPath)) {
            fs.mkdirSync(tempPath);
        }

        tempPath += '/' + ccode;
        if (!fs.existsSync(tempPath)) {
            fs.mkdirSync(tempPath);
        }

        tempPath += '/' + lacode;
        if (!fs.existsSync(tempPath)) {
            fs.mkdirSync(tempPath);
        }
    
        tempPath += '/' + jsonFolderName;
        if (!fs.existsSync(tempPath)) {
            fs.mkdirSync(tempPath);
        }
        if (versioncode != null) {
            tempPath += '/' + versioncode;
            if (!fs.existsSync(tempPath)) {
                fs.mkdirSync(tempPath);
            }
        } else {
            tempPath += '/' + defaultFolder;
            if (!fs.existsSync(tempPath)) {
                fs.mkdirSync(tempPath);
            }
        }
    }

    fs.writeFile(`${path}/${fileName}`, JSON.stringify(data), function (err) {
        if (err) {
            console.log('Error');
            console.log(err);
            return callback(err, '');
          } 
        console.log('File created');
       // return callback('', 'File Created');
    });
};

function processdb(db, data, callback) {
    var collection = db.collection('lessons');
    // Get the student data passed from the form
    data = JSON.parse(data);
    var newItem = false;

    collection.findOneAndReplace({ 'lesson_code': data.lesson_code, 'country_code': data.country_code, 'lang_code': data.lang_code }, data, { upsert: true, returnNewDocument: true }, function (
        err,
        result
    ) {
        if (err) {
            console.log(err);
            return callback(err, '');
        } else {
            if (result.lastErrorObject.updatedExisting) {
                console.log('Updated');
                return callback('', 'Updated');
            }

            if (!result.lastErrorObject.updatedExisting) {
                newItem = true;
                return callback('', 'Inserted');
            }
        }
    });
}