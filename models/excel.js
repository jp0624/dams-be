// var env = process.env.NODE_ENV || 'dev';
// var config = require('../config')[env];
var connection = require('./connection');
var sqlClean = require('./_sql_clean');
// var mongodb = require('mongodb');
// var fs = require('fs');

// module.exports.storeLesson = function (data, callback) {
//   // Get a Mongo client to work with the Mongo server
//   var MongoClient = mongodb.MongoClient;

//   // Define where the MongoDB server is
//   var url = `mongodb://${config.mongo.host}:${config.mongo.port}`;
//   // Connect to the server
//   MongoClient.connect(
//     url,
//     { useNewUrlParser: true },
//     function (err, client) {
//       if (err) {
//         console.log('Unable to connect to the Server:', err);
//       } else {
//         console.log('Connected to Server');

//         // Get the documents collection
//         var db = client.db(`${config.mongo.database}`);
//         //call update process
//         processdb(db, data, function (err, result) {
//           // call Insert process
//           client.close();

//           return callback('', result);
//         });
//       }
//     }
//   );
// };

// module.exports.storeInFile = function (data, callback) {
//   const lcode = data.lesson.code.toLowerCase();
//   const ccode = data.lesson.country.toLowerCase();
//   const lacode = data.lesson.language.toLowerCase();
//   const cocode = data.lesson.course.toLowerCase();
//   const vcode = data.lesson.vehicle.toLowerCase();

//   let path = config.lessonsFolderPath + cocode;

//   const fileName = `${cocode}_${lcode}_${vcode}_${ccode}_${lacode}.json`.toLowerCase();

//   if (!fs.existsSync(path)) {
//     // && !fs.existsSync(path + '/json')) {
//     fs.mkdirSync(path);
//   }

//   path += '/' + lcode;
//   if (!fs.existsSync(path)) {
//     fs.mkdirSync(path);
//   }

//   path += '/' + vcode;
//   if (!fs.existsSync(path)) {
//     fs.mkdirSync(path);
//   }

//   path += '/json';
//   if (!fs.existsSync(path)) {
//     fs.mkdirSync(path);
//   }

//   fs.writeFile(`${path}/${fileName}`, JSON.stringify(data), function (err) {
//     if (err) {
//       console.log('Error');
//       console.log(err);
//       return callback(err, '');
//       throw err;
//     }

//     console.log('File updated');
//     return callback('', 'File Created');
//   });
// };

// function processdb(db, data, callback) {
//   var collection = db.collection('lessons');
//   // Get the student data passed from the form

//   var newItem = false;

//   collection.findOneAndReplace({ 'lesson.code': data.lesson.code, 'lesson.country': data.lesson.country, 'lesson.language': data.lesson.language }, data, { upsert: true, returnNewDocument: true }, function (
//     err,
//     result
//   ) {
//     if (err) {
//       console.log(err);
//       return callback(err, '');
//     } else {
//       if (result.lastErrorObject.updatedExisting) {
//         console.log('Updated');
//         return callback('', 'Updated');
//       }

//       if (!result.lastErrorObject.updatedExisting) {
//         newItem = true;
//         return callback('', 'Inserted');
//       }

//     }

//   });
// }

module.exports.getTranslation = function (data, callback) {
  sqlClean.escapeObjectStrings(data);
  console.log('SQL STATUS CREATE REQUEST: ', data);

  connection.query(
    `
        SELECT * from translation
            WHERE
                item_id = '` +
    data.id +
    `'
            AND
                language_code = '` +
    data.lang_code +
    `'
            AND
                country_code = '` +
    data.country_code +
    `'
    `,
    data,
    callback
  );
};

module.exports.updateTranslation = function (data, callback) {
  sqlClean.escapeObjectStrings(data);
  connection.query(
    `
        UPDATE translation
            SET value = '` +
    data.value +
    `',
                item_id = '` +
    data.id +
    `',
                language_code = '` +
    data.lang_code +
    `',
                country_code = '` +
    data.country_code +
    `'
            WHERE
                item_id = '` +
    data.id +
    `'
            AND
                language_code = '` +
    data.lang_code +
    `'
            AND
                country_code = '` +
    data.country_code +
    `'
                
    `,
    data,
    callback
  );
};

module.exports.createTranslation = function (data, callback) {
  sqlClean.escapeObjectStrings(data);
  connection.query(
    `
        INSERT INTO translation
            SET value = '` +
    data.value +
    `',
                item_id = '` +
    data.id +
    `',
                language_code = '` +
    data.lang_code +
    `',
                country_code = '` +
    data.country_code +
    `'
    `,
    data,
    callback
  );
};

module.exports.courseInformation = function (param, callback) {
  sqlClean.escapeObjectStrings(param);
  connection.query(
    `
        SELECT DISTINCT c.course_id, c.name AS course_name, c.code AS course_code,l.lesson_id, l.name AS lesson_name, l.code AS lesson_code, 
        t.task_id, t.name AS task_name, tc.task_content_id, tc.value AS 'template_value', tc.version_id, cv.name AS 'version_name', ct.content_id, 
        ct.content_type_id, tat.element, tat.type, tg._order AS 'grouporder', ta._order AS 'attrorder' ,v.code AS vehicle_code, v1.code AS versionCode
        FROM course c 
        INNER JOIN course_lesson cl ON cl.course_id = c.course_id 
        INNER JOIN lesson l ON l.lesson_id = cl.lesson_id
        INNER JOIN lesson_task lt ON lt.lesson_id = l.lesson_id
        INNER JOIN task t ON t.task_id = lt.task_id
        INNER JOIN task_group tg ON tg.task_id = t.task_id
        INNER JOIN task_content tc ON tc.task_group_id = tg.task_group_id 
        INNER JOIN content ct ON ct.content_item_id = tc.task_content_id  
        INNER JOIN task_attr AS ta ON ta.attr_id = tc.attr_id
        INNER JOIN task_attr_type AS tat ON tat.type_id = ta.attr_type_id
        INNER JOIN content_version cv ON cv.version_id = tc.version_id
        RIGHT JOIN vehicle v ON v.vehicle_id = l.vehicle_id
        LEFT JOIN version v1 ON l.version_id = v1.id
        WHERE c.course_id = '` + param.id + `' AND ct.content_type_id = 2
        ORDER BY l.lesson_id, task_id,grouporder, attrorder, content_id;

        SELECT DISTINCT c.course_id, c.name AS course_name,  c.code AS course_code, l.lesson_id, l.name AS lesson_name, l.code AS lesson_code, t.task_id, t.name AS task_name , d.selector, d.term,
        ct.content_id, ct.content_type_id
        FROM course c 
        INNER JOIN course_lesson cl ON cl.course_id = c.course_id 
        INNER JOIN lesson l ON l.lesson_id = cl.lesson_id 
        INNER JOIN lesson_task lt ON lt.lesson_id = l.lesson_id 
        INNER JOIN task t ON t.task_id = lt.task_id 
        INNER JOIN task_dictionary td ON t.task_id = td.task_id  
        INNER JOIN dictionary d ON d.term_id = td.dictionary_id  
        INNER JOIN content ct ON ct.content_item_id = td.task_dictionary_id 
        WHERE c.course_id = '` + param.id + `' AND ct.content_type_id = 3 
        ORDER BY l.lesson_id, content_id;
  `, callback );
};

module.exports.courseInformationManual = function (param, callback) {
  sqlClean.escapeObjectStrings(param);
  connection.query(
    `
    SELECT DISTINCT c.course_id, c.name AS course_name, c.code AS course_code,l.lesson_id, l.name AS lesson_name, l.code AS lesson_code, t.task_id, t.name AS task_name,tc.task_content_id, tc.value AS 'template_value', tc.version_id, tc.content_id, tat.element, tat.type 
    FROM course c 
    INNER JOIN course_lesson cl ON cl.course_id = c.course_id 
    INNER JOIN lesson l ON l.lesson_id = cl.lesson_id
    INNER JOIN lesson_task lt ON lt.lesson_id = l.lesson_id
    INNER JOIN task t ON t.task_id = lt.task_id
    INNER JOIN task_group tg ON tg.task_id = t.task_id
    INNER JOIN task_content tc ON tc.task_group_id = tg.task_group_id             
    INNER JOIN task_attr AS ta ON ta.attr_id = tc.attr_id
    INNER JOIN task_attr_type AS tat ON tat.type_id = ta.attr_type_id
    WHERE c.course_id = '` +
    param.id +
    `' ORDER BY l.lesson_id, task_id, content_id;
    SELECT DISTINCT c.course_id, c.name AS course_name,  c.code AS course_code, l.lesson_id, l.name AS lesson_name,
    l.code AS lesson_code, t.task_id,
    t.name AS task_name , d.selector, d.term,
    td.content_id
    FROM course c 
    INNER JOIN course_lesson cl ON cl.course_id = c.course_id 
    INNER JOIN lesson l ON l.lesson_id = cl.lesson_id 
    INNER JOIN lesson_task lt ON lt.lesson_id = l.lesson_id 
    INNER JOIN task t ON t.task_id = lt.task_id 
    INNER JOIN task_dictionary td ON t.task_id = td.task_id  
    INNER JOIN dictionary d ON d.term_id = td.dictionary_id
    WHERE c.course_id = '` +
    param.id +
    `' ORDER BY l.lesson_id, content_id;
        `,
    callback
  );
};