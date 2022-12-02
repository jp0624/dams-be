var mysql = require('mysql');

var connection = require('./connection');

// module.exports.getFileList = function(params, callback) {

//     console.log('PARAMS: ', params);

// 	connection.query(`
//         SELECT  t.task_id,
//                 t.name AS 'task_name',
//                 t.type_id AS 'task_type_id',
//                 tt.name AS 'task_type_name'

//         FROM task AS t

//             INNER JOIN task_type AS tt
//                 ON t.type_id = tt.type_id

//             WHERE
//                 t.task_id = '` + params.task_id + `'

//     `, callback);

// }

//delete me