var mysql = require('mysql');
var connection = require('./connection');
var sqlClean = require('./_sql_clean');

module.exports.getAllTasks = function (data, callback) {

    let sql = `call sp_task_list(?, ?, ?, ?, ?);`;

    connection.query(sql, [data.startindex, data.pagesize, data.sortfield, data.sortorder, data.searchtext], callback);
}

module.exports.getalltaskslist = function (callback) {

    let sql = `SELECT  s.name AS 'status',
                    t.task_id AS 'id',
                    tt.name AS 'type',
                    t.name,
                    t.description
                FROM task as t
                INNER JOIN status AS s
                ON t.status_id = s.status_id
                INNER JOIN task_type AS tt
                ON t.type_id = tt.type_id;`;

    connection.query(sql, callback);
}

module.exports.checkTaskLinks = function (params, callback) {
    sqlClean.escapeObjectStrings(params);
    console.log('PARAMS TO CHECK: ', params);
    connection.query(`
        SELECT  *
            FROM task_dictionary as dt
        WHERE dt.task_id = '` + params.task_id + `'
            AND dt.dictionary_id = '` + params.dictionary_id + `'
    `, callback);
}

module.exports.findTask = function (params, callback) {
    sqlClean.escapeObjectStrings(params);
    connection.query(`
        SELECT  task_id AS 'id',
                name,
                heading,
                description,
                status_id,
                type_id,
                lock_type,
                lock_time,
                display_main,
                display_next
            FROM task
        WHERE task_id = '` + params.id + `'
    `, callback);
}

module.exports.deleteTaskDictionaryTermLink = function (params, callback) {
    sqlClean.escapeObjectStrings(params);
    connection.query(`
    SELECT task_dictionary_id FROM task_dictionary
        WHERE task_id = '` + params.task_id + `'
            AND
              dictionary_id = '` + params.id + `';
    DELETE FROM task_dictionary
        WHERE task_id = '` + params.task_id + `'
            AND
              dictionary_id = '` + params.id + `';
    `, callback);
}

module.exports.addTaskDictionaryTermLink = function (data, callback) {

    sqlClean.escapeObjectStrings(data);

    data.content_id = data.task_id + '-' + data.id
    console.log('SQL UPDATE ATTR VERSION REQUEST here: ', data)

    connection.query(`
        INSERT INTO task_dictionary
            SET                
                task_id = '` + data.task_id + `',
                dictionary_id = '` + data.id + `'
            ON DUPLICATE KEY
                UPDATE
                    task_id = '` + data.task_id + `',
                    dictionary_id = '` + data.id + `'
    `, callback);
}

module.exports.findTemplateContentValue = function (params, callback) {
    sqlClean.escapeObjectStrings(params);
    connection.query(`
        SELECT  tc.value,
                tc.version_id,
                v.name AS 'version'

            FROM task_content AS tc

        INNER JOIN content_version AS v
            ON v.version_id = tc.version_id

        WHERE
            tc.content_id = '` + params.key + `'
    `, callback);
}

module.exports.findContentValue = function (params, callback) {
    sqlClean.escapeObjectStrings(params);
    connection.query(`
        SELECT  tc.value,
                tc.version_id,
                v.name AS 'version'

            FROM task_content AS tc
            
        INNER JOIN content_version AS v
            ON v.version_id = tc.version_id

        WHERE
            tc.task_group_id = '` + params.group + `'
        AND 
            tc.attr_id = '` + params.attr + `'
    `, callback);
}

module.exports.findContentLocal = function (params, callback) {
    sqlClean.escapeObjectStrings(params);
    connection.query(`
        SELECT value
            FROM translation
        WHERE
            item_id = '` + params.key + `'
        AND 
            language_code = '` + params.lang + `'
    `, callback);
}

module.exports.updateTask = function (data, callback) {
    sqlClean.escapeObjectStrings(data);

    //var dataString = JSON.stringify(data);
    //data = JSON.parse(dataString)
    // dataString = mysql_real_escape_string (dataString)
    // data = JSON.parse(dataString)

    console.log('SQL TASK UPDATE REQUEST: ', data)
    let display_main_val = (data.display_main === true || data.display_main === 1) ? 1 : 0;
    let display_next_val = (data.display_next === true || data.display_main === 1) ? 1 : 0;

    connection.query(`
        UPDATE task
            SET name = '` + data.name + `',
                heading = '` + data.heading + `',
                description = '` + data.description + `',
                type_id = '` + data.type_id + `',
                status_id = '` + data.status_id + `',
                lock_type = '` + data.lock_type_id + `',
                lock_time = '` + data.lock_time + `',
                display_main = '` + display_main_val + `',
                display_next = '` + display_next_val + `'
        WHERE task_id = '` + data.task_id + `'
    `, callback);
}

module.exports.checkContentItem = function (params, callback) {
    sqlClean.escapeObjectStrings(params);

    connection.query(`
        SELECT value
            FROM task_content
            WHERE
                content_id = '` + params.key + `'
    `, callback);
}

module.exports.checkContentItemV1 = function (params, callback) {
    sqlClean.escapeObjectStrings(params);
    // :attrid/:groupid/:versionid
    connection.query(`
        SELECT value
            FROM task_content
            WHERE
                attr_id = ` + params.attrid + ` and task_group_id = ` + params.groupid + ` and version_id = ` + params.versionid, callback);
}

module.exports.checkLocalContentItem = function (data, callback) {
    sqlClean.escapeObjectStrings(data);

    connection.query(`
        SELECT translation_id
            FROM translation
            WHERE
                item_id = '` + data.key + `'
                AND
                language_code = '` + data.lang_code + `'
                AND
                country_code = '` + data.country_code + `'
                AND
                type_id = 2
    `, callback);
}
//updateAttrVersion

module.exports.updateAttrVersion = function (data, callback) {

    sqlClean.escapeObjectStrings(data);
    data.content_id = data.attr_id + '-' + data.group_id + '-' + data.version_id

    connection.query(`
        INSERT INTO task_content
            SET
                task_group_id   = '` + data.group_id + `',
                attr_id         = '` + data.attr_id + `',
                version_id      = '` + data.version_id + `'
        ON DUPLICATE KEY
            UPDATE 
                task_group_id   = '` + data.group_id + `',
                attr_id         = '` + data.attr_id + `',
                version_id      = '` + data.version_id + `'
        `, callback);
}

module.exports.updateAttrVersionInContent = function (data, callback) {

    sqlClean.escapeObjectStrings(data);

    connection.query(`
        INSERT INTO content
            SET
                content_type_id = 2,
                content_item_id = '` + data + `'
        ON DUPLICATE KEY
            UPDATE 
            content_type_id = 2,
            content_item_id = '` + data + `'
        `, callback);
}

module.exports.deleteAttrVersion = function (data, callback) {
    sqlClean.escapeObjectStrings(data);

    connection.query(`
    DELETE FROM task_content
        WHERE
            content_id = '` + data.content_id + `'
    `, callback);
}

module.exports.updateContentItem = function (data, callback) {
    sqlClean.escapeObjectStrings(data);

    connection.query(`
        UPDATE task_content
            SET
                value = '` + data.value + `'
        WHERE
            attr_id = ` + data.attrid + ` AND  
            task_group_id = ` + data.groupid + ` AND 
            version_id = ` + data.versionid
        , callback);
}

module.exports.updateContentItemV1 = function (data, params, callback) {
    sqlClean.escapeObjectStrings(data);

    connection.query(`
        UPDATE task_content
            SET
                value = '` + data.value + `'
        WHERE
            attr_id = ` + params.attrid + ` AND  
            task_group_id = ` + params.groupid + ` AND 
            version_id = ` + params.versionid
        , callback);
}

module.exports.updateOrderofGroup = function (params, callback) {
    sqlClean.escapeObjectStrings(params);

    connection.query(`
        UPDATE task_group
            SET
                _order = '` + params.order + `'
        WHERE
            task_group_id = '` + params.group_id + `'

    `, callback);
}

module.exports.updateLocalContentItem = function (data, callback) {
    sqlClean.escapeObjectStrings(data);

    connection.query(`
        UPDATE translation
            SET
                value = '` + data.value + `'
        WHERE
            item_id = '` + data.content_id + `'
        AND
            type_id = 2
        AND
            language_code = '` + data.lang_code + `'
        AND 
            country_code = '` + data.country_code + `'

    `, callback);
}

module.exports.createContentItem = function (data, callback) {
    sqlClean.escapeObjectStrings(data);

    connection.query(`
        INSERT INTO task_content
            SET
                value = '` + data.value + `',
                attr_id = '` + data.attr_id + `',
                task_group_id = '` + data.task_group_id + `'
        `, callback);
}

module.exports.addTermsToTask = function(data, callback) {
    sqlClean.escapeObjectStrings(data);
    console.log(data.terms);
    let sql = ``;
    if (data.terms && data.terms.length>0) {
        data.terms.forEach(element => {
            sql += `
                INSERT INTO task_dictionary
                SET                
                    task_id = '` + data.taskid + `',
                    dictionary_id = '` + element + `'
                ON DUPLICATE KEY
                    UPDATE
                        task_id = '` + data.taskid + `',
                        dictionary_id = '` + element + `';
            `;
        })
    }

    connection.query(sql, callback);
}

module.exports.createContent = function (rowid, typeid, callback) {

    connection.query(`
        INSERT INTO content
            SET
            content_type_id = '` + typeid + `',
            content_item_id = '` + rowid + `'
        `, callback);
}

module.exports.deleteContent = function (rowid, type, callback) {

    connection.query(`
        DELETE FROM content 
            WHERE content_type_id = '` + type + `' AND content_item_id = ` + rowid + `;
        `, callback);

}

module.exports.createLocalContentItem = function (data, callback) {
    sqlClean.escapeObjectStrings(data);

    connection.query(`
        INSERT INTO translation
            SET
                item_id = '` + data.content_id + `',
                value = '` + data.value + `',
                type_id = 2,
                language_code = '` + data.lang_code + `',
                country_code = '` + data.country_code + `'
    `, callback);
}

module.exports.checkLinkLessonTask = function (data, callback) {
    sqlClean.escapeObjectStrings(data);

    connection.query(`
        SELECT *
            FROM lesson_task
        WHERE
            lesson_id = '` + data.lesson_id + `'
            AND
            task_id = '` + data.task_id + `'
    `, callback);
}

module.exports.setLinkLessonTask = function (data, callback) {
    sqlClean.escapeObjectStrings(data);
    connection.query(`
        INSERT INTO lesson_task
            SET lesson_id = '` + data.lesson_id + `',
                task_id = '` + data.task_id + `'
    `, data, callback);
}

module.exports.createTask = function (data, callback) {

    let display_main_val = (data.display_main === true || data.display_main === 1) ? 1 : 0;
    let display_next_val = (data.display_next === true || data.display_main === 1) ? 1 : 0;

    sqlClean.escapeObjectStrings(data);

    connection.query(`
        INSERT INTO task
            SET name = '` + data.name + `',
                heading = '` + data.heading + `',
                description = '` + data.description + `',
                type_id = '` + data.type_id + `',
                status_id = '` + data.status_id + `',
                lock_type = '` + data.lock_type_id + `',
                lock_time = '` + data.lock_time + `',
                display_main = '` + display_main_val + `',
                display_next = '` + display_next_val + `'
    `, data, callback);
}

// module.exports.createTaskGroup = function (data, callback) {
//     sqlClean.escapeObjectStrings(data);
//     connection.query(`
//         SET @order_number := 0;
//         SELECT @order_number := tg._order+1 FROM task_group tg WHERE task_id = '` + data.task_id + `' ORDER BY tg._order DESC LIMIT 1;
//         INSERT INTO task_group
//             SET 
//                 task_id = '` + data.task_id + `',
//                 task_type_attr_group_id = '` + data.link_id + `',
//                 _order = @order_number;
//     `, data, callback);
// }

module.exports.findAttrVerStatus = function (data, callback) {
    sqlClean.escapeObjectStrings(data);
    let arr = data.id.split('-');

    connection.query(`
        SELECT *
            FROM task_content
        WHERE
            attr_id = '` + arr[0] + `' AND 
            task_group_id = '` + arr[1] + `' AND 
            version_id = '` + arr[2] + `' 
    `, callback);
}

module.exports.findAttrVersions = function (data, callback) {
    sqlClean.escapeObjectStrings(data);
    connection.query(`
        SELECT *
            FROM task_content
        WHERE
            task_group_id = '` + data.group_id + `'
        AND
            attr_id = '` + data.attr_id + `'
    `, callback);
}

module.exports.findTaskType = function (data, callback) {
    sqlClean.escapeObjectStrings(data);
    connection.query(`
        SELECT tt.*
            FROM task_type AS tt

        INNER JOIN task AS t
            ON t.task_id = '` + data.id + `'
            
        WHERE tt.type_id = t.type_id
    `, callback);
}

module.exports.findTaskTypeGroups = function (data, callback) {
    sqlClean.escapeObjectStrings(data);
    connection.query(`
    
    SELECT  ttag.*,
            tg.*,
            tag.*,
            tag.name AS 'child_type',
            tag.icon,
            tt.child,
            t.*,
            t.type_id AS 'TYPE',
            tg.task_group_id
        FROM task_type_attr_group AS ttag

        INNER JOIN task_group AS tg
            ON tg.task_id = '` + data.task_id + `'
        
        INNER JOIN task_attr_group AS tag
            ON tag.group_id = ttag.attr_group_id
            
        INNER JOIN task_type AS tt
            ON tt.type_id = ttag.task_type_id
        
        INNER JOIN task AS t
            ON t.task_id = '` + data.task_id + `'

        WHERE ttag.group_id = tg.task_type_attr_group_id
            AND ttag.task_type_id = t.type_id
  
        ORDER BY tg._order
    `, callback);
}

module.exports.findAllTaskTypeGroups = function (data, callback) {
    sqlClean.escapeObjectStrings(data);
    connection.query(`
    
    SELECT  
            ttg.group_id AS 'link_id',
            tag.name,
            tag.group_id,
            tag.icon,
            tt.name AS 'type',
            tt.child,
            tt.type_id

        FROM task_type AS tt

    INNER JOIN task_type_attr_group AS ttg
        ON tt.type_id = ttg.task_type_id
    
    INNER JOIN task_attr_group AS tag
        ON tag.group_id = ttg.attr_group_id

    WHERE tag.group_id = ttg.attr_group_id
        AND tt.type_id = ttg.task_type_id

    ORDER BY tt.type_id

    `, callback);
}

module.exports.findAllTaskTypeGroupsByType = function (data, callback) {
    sqlClean.escapeObjectStrings(data);
    connection.query(`
    
    SELECT  
            ttg.group_id AS 'link_id',
            tag.name,
            tag.group_id,
            tag.icon,
            tt.name AS 'Task Type',
            tt.child,
            tt.type_id

        FROM task_type AS tt

    INNER JOIN task_type_attr_group AS ttg
        ON tt.type_id = ttg.task_type_id
    
    INNER JOIN task_attr_group AS tag
        ON tag.group_id = ttg.attr_group_id

    WHERE tag.group_id = ttg.attr_group_id
        AND tt.type_id = ttg.task_type_id
        AND tt.type_id = '` + data.id + `'

    ORDER BY tt.type_id

    `, callback);
}  //'` + data.id + `'


module.exports.findTaskAttrByLink = function (data, callback) {
    sqlClean.escapeObjectStrings(data);
    connection.query(`
    SELECT  
            ttg.group_id AS 'ttg_id',
            tag.name AS 'Task Type',
            tag.group_id AS 'tag_id'

        FROM task_type_attr_group AS ttg

    INNER JOIN task_attr_group AS tag
        ON ttg.attr_group_id = tag.group_id

    WHERE
        ttg.group_id = '` + data.id + `'
    ORDER BY ttg._order
    `, callback);
}

module.exports.OLDfindTaskTypeGroups = function (data, callback) {
    sqlClean.escapeObjectStrings(data);
    connection.query(`
    SELECT at.*, tg._order AS 'order'

        FROM task_type_attr_group AS tg

    INNER JOIN task_attr_group AS at
        ON tg.attr_group_id = at.group_id

    WHERE tg.task_type_id = '` + data.type_id + `'
        AND tg.task_id = '` + data.task_id + `'
        
    ORDER BY tg._order
    `, callback);
}

module.exports.findTaskAttr = function (params, callback) {
    sqlClean.escapeObjectStrings(params);
    connection.query(`
    SELECT a.*, at.element, at.type, at.versioning
        FROM task_attr AS a
    INNER JOIN task_attr_type AS at
        ON a.attr_type_id = at.type_id
    WHERE a.group_id = '` + params.id + `'
    ORDER BY a._order
    `, callback);
}

module.exports.findTaskAttrGroupByTaskType = function (params, callback) {
    sqlClean.escapeObjectStrings(params);
    connection.query(`
    SELECT * FROM task_type_attr_group WHERE task_type_id = '` + params.task_type_id + `'ORDER BY _order`, callback);
}

module.exports.getTaskType = function (params, callback) {
    sqlClean.escapeObjectStrings(params);
    connection.query(`
    SELECT * FROM task_type ORDER BY name`, callback);
}

module.exports.getTaskAttrGroup = function (params, callback) {
    sqlClean.escapeObjectStrings(params);
    connection.query(`SELECT * FROM task_attr_group ORDER BY name`, callback);
}

module.exports.updatetasktypeattrgroup = function (data, callback) {

    sqlClean.escapeObjectStrings(data);
    var task_type_id = data.type_id;
    console.log(data);

    let sqlQueryString = '';

    sqlQueryString += 'DELETE FROM task_type_attr_group WHERE task_type_id = ' + task_type_id + ';';

    data.attr_groups.forEach((element, index) => {
        if (element.checked) {
            sqlQueryString += 'INSERT INTO task_type_attr_group SET attr_group_id = ' + element.group_id + ', task_type_id = ' + task_type_id + ', _order = ' + index + 1 + ';';
        }
    });
    sqlQueryString += 'SELECT true;'
    console.log(sqlQueryString);

    connection.query(sqlQueryString, callback);
}

//Task types
module.exports.getTaskTypes = (data, callback) => {
    sqlClean.escapeObjectStrings(data);
    console.log(data);

    let sqlQueryString = '';

    sqlQueryString += `SELECT type_id, name, description, code_angular, child, status_id FROM task_type`;

    console.log(sqlQueryString);

    connection.query(sqlQueryString, callback);
}

module.exports.inserttasktype = function (data, callback) {

    sqlClean.escapeObjectStrings(data);
    var task_type_id = data.type_id;
    console.log(data);

    let sqlQueryString = '';

    sqlQueryString += `INSERT INTO task_type SET name = '${data.name}',
    description='${data.description}',
    code_angular='${data.code_angular}',
    child='${data.child}',
    status_id = ${data.status_id}`;

    console.log(sqlQueryString);

    connection.query(sqlQueryString, callback);
}

module.exports.findtasktypeById = (data, callback) => {
    sqlClean.escapeObjectStrings(data);
    console.log(data);

    let sqlQueryString = '';

    sqlQueryString += `SELECT type_id, name, description, code_angular, child, status_id FROM task_type WHERE type_id = ${data.type_id} LIMIT 1`;

    console.log(sqlQueryString);

    connection.query(sqlQueryString, callback);
}

module.exports.updatetasktype = function (data, callback) {

    sqlClean.escapeObjectStrings(data);
    var task_type_id = data.type_id;
    console.log(data);

    let sqlQueryString = '';

    sqlQueryString += `UPDATE task_type SET name = '${data.name}',
    description='${data.description}',
    code_angular='${data.code_angular}',
    child='${data.child}',
    status_id = ${data.status_id}
    WHERE type_id = ${data.type_id}
    `;

    console.log(sqlQueryString);

    connection.query(sqlQueryString, callback);
}

module.exports.deletetasktype = function (data, callback) {

    sqlClean.escapeObjectStrings(data);
    console.log(data);

    let sqlQueryString = '';

    //sqlQueryString += `UPDATE task_type SET status_id = 0 WHERE type_id = ${data.type_id}`;
    sqlQueryString += `DELETE FROM task_type WHERE type_id = ${data.type_id}`;

    console.log(sqlQueryString);

    connection.query(sqlQueryString, callback);
}

//Task attr group
module.exports.getTaskAttrGroups = (data, callback) => {
    sqlClean.escapeObjectStrings(data);
    console.log(data);

    let sqlQueryString = '';

    sqlQueryString += `SELECT group_id, name, icon FROM task_attr_group;`;

    console.log(sqlQueryString);

    connection.query(sqlQueryString, callback);
}

module.exports.insertTaskAttrGroup = function (data, callback) {

    sqlClean.escapeObjectStrings(data);
    var task_type_id = data.type_id;
    console.log(data);

    let sqlQueryString = '';

    sqlQueryString += `INSERT INTO task_attr_group SET name = '${data.name}', icon = '${data.icon}';`;

    console.log(sqlQueryString);

    connection.query(sqlQueryString, callback);
}

module.exports.findTaskAttrGroupById = (data, callback) => {
    sqlClean.escapeObjectStrings(data);
    console.log(data);

    let sqlQueryString = '';

    sqlQueryString += `SELECT group_id, name, icon FROM task_attr_group WHERE group_id = ${data.group_id} LIMIT 1;`;

    console.log(sqlQueryString);

    connection.query(sqlQueryString, callback);
}

module.exports.updateTaskAttrGroup = function (data, callback) {

    sqlClean.escapeObjectStrings(data);
    console.log(data);

    let sqlQueryString = '';

    sqlQueryString += `UPDATE task_attr_group SET name = '${data.name}',
    icon='${data.icon}' 
    WHERE group_id = ${data.group_id};`;

    console.log(sqlQueryString);

    connection.query(sqlQueryString, callback);
}

module.exports.deleteTaskAttrGroup = function (data, callback) {

    sqlClean.escapeObjectStrings(data);
    console.log(data);

    let sqlQueryString = '';

    sqlQueryString += `DELETE FROM task_attr_group WHERE group_id = ${data.group_id};`;

    console.log(sqlQueryString);

    connection.query(sqlQueryString, callback);
}

module.exports.deleteTask = function (params, callback) {

    sqlClean.escapeObjectStrings(params);
    console.log(params);

    let sqlQueryString = '';

    sqlQueryString += `
                        DELETE FROM translation WHERE content_id IN (SELECT DISTINCT content_id FROM content WHERE content_type_id = 2 AND content_item_id IN (SELECT DISTINCT task_content_id FROM task_content WHERE task_group_id IN (SELECT distinct task_group_id FROM task_group WHERE task_id =  ${params.id})));
                        DELETE FROM translation WHERE content_id IN (SELECT DISTINCT content_id FROM content WHERE content_type_id = 3 AND content_item_id IN (SELECT DISTINCT td.task_dictionary_id FROM task_dictionary td WHERE task_id =  ${params.id}));
                        DELETE FROM task_content WHERE task_group_id IN (SELECT DISTINCT task_group_id FROM task_group WHERE task_id =  ${params.id});
                        DELETE FROM task_dictionary WHERE task_id =  ${params.id};
                        DELETE FROM task_group WHERE task_id =  ${params.id};
                        DELETE FROM task WHERE task_id = ${params.id};`;

    console.log(sqlQueryString);

    connection.query(sqlQueryString, callback);
}

module.exports.taskFullInfo = function(params, callback) {
    sqlClean.escapeObjectStrings(params);
    console.log(params);

        let sql = `SELECT t.task_id,
        type_id,
        status_id,
        t.name,
        description,
        lock_type,
        lock_time,
        heading,
        display_main,
        display_next,
        display_innav
        FROM task t WHERE t.task_id=${params.id} LIMIT 1;
        SELECT DISTINCT
        tc1.task_content_id,
        t.task_id,
        tc1.task_group_id,
        ta.attr_id,
        tc1.value,
        cv.version_id,
        cv.name 'version_name',
        ta.name 'taname',
        placeholder,
        default_value,
        label,
        ta._order,
        tag.name 'tagname',
        tag.icon,
        tg._order 'tgorder',
        tat.element 'taelement',
        tat.type 'tatype'
      FROM task_group tg
        INNER JOIN task_content tc1 ON tg.task_group_id = tc1.task_group_id
        INNER JOIN content_version cv ON cv.version_id = tc1.version_id
        INNER JOIN task t ON t.task_id = tg.task_id
        INNER JOIN task_attr ta ON ta.attr_id = tc1.attr_id
        INNER JOIN task_attr_group tag ON tag.group_id = ta.group_id
        INNER JOIN task_attr_type tat ON tat.type_id = ta.attr_type_id
        LEFT JOIN task_attr_type_option tato  ON tato.type_id = tat.type_id
      WHERE t.task_id = ${params.id} ORDER BY tg._order, tg.task_group_id, ta._order;
        SELECT td.task_dictionary_id, d.term_id, d.term, d.selector FROM task_dictionary td
        INNER JOIN dictionary d ON d.term_id = td.dictionary_id
        WHERE td.task_id = ${params.id}`;      
    console.log(sql);
    connection.query(sql, callback);
}

module.exports.taskdictionarydelete = function(params, callback) {
    sqlClean.escapeObjectStrings(params);
    console.log(params);

    let sql = `DELETE FROM task_dictionary WHERE task_dictionary_id = ${params.id}`;

    console.log(sql);
    connection.query(sql, callback);
}

module.exports.createTaskGroup = (data, callback) => {
    sqlClean.escapeObjectStrings(data);
    console.log(data);

    let sql = `
                SELECT @order := IFNULL(MAX(_order)+1, 0) FROM task_group 
                WHERE task_id = ${data.taskid};
                INSERT INTO task_group (task_type_attr_group_id, task_id, _order) 
                VALUES(${data.linkid}, ${data.taskid}, @order);
                SELECT LAST_INSERT_ID() 'newid';
            `;

    // let sql = `
    //             SELECT @order := IFNULL(MAX(_order)+1, 0) FROM task_group 
    //             WHERE task_type_attr_group_id = ${data.linkid} AND task_id = ${data.taskid};
    //             INSERT INTO task_group (task_type_attr_group_id, task_id, _order) 
    //             VALUES(${data.linkid}, ${data.taskid}, @order);
    //             SELECT LAST_INSERT_ID() 'newid';
    //         `;

    console.log(sql);
    connection.query(sql, callback);
}

module.exports.createTaskContent = (groupid, attributes, callback) => {
    sqlClean.escapeObjectStrings(groupid);
    console.log(groupid);
    let sql = ``;
    Object.keys(attributes).forEach((key) => {
        //parseInt(key);
        attributes[key];
        sql += `INSERT INTO task_content (task_group_id, attr_id, value, version_id) 
                VALUES (${groupid}, ${key}, '${attributes[key]}', 1);`
        sql += `INSERT INTO content (content_item_id, content_type_id) 
                VALUES (LAST_INSERT_ID(), 2);`  
    });

    sql += `
        SELECT ${groupid} 'group_id', name 'tagname', icon, tg._order 'order' FROM task_type_attr_group ttag 
        INNER JOIN task_group tg ON ttag.group_id = tg.task_type_attr_group_id
        INNER JOIN task_attr_group tag ON tag.group_id = ttag.attr_group_id
        WHERE tg.task_group_id = ${groupid};

        SELECT tc.task_content_id 'id', label, ta.placeholder, ta.default_value, tc.value, ta.type, tat.element, tc.version_id 'version', ta.attr_id 'attrid' FROM task_content tc 
        INNER JOIN task_attr ta ON ta.attr_id = tc.attr_id
        INNER JOIN task_attr_type tat ON tat.type_id = ta.attr_type_id
        WHERE tc.task_group_id = ${groupid}  ORDER BY ta._order;
    `
    console.log(sql);
    connection.query(sql, callback);
}


module.exports.deleteGroup = (groupid, callback) => {
    sqlClean.escapeObjectStrings(groupid);
    console.log(groupid);

    let sql =  `SELECT @ord := _order, @taskid := task_id FROM task_group WHERE task_group_id = ${groupid}; 
                DELETE FROM task_content WHERE task_group_id = ${groupid};
                DELETE FROM task_group WHERE task_group_id = ${groupid};
                SELECT @ord;
                SELECT @taskid;
                UPDATE task_group tg SET tg._order = tg._order - 1 WHERE tg.task_id=@taskid AND tg._order > @ord;`;

    console.log(sql);
    connection.query(sql, callback);
}

module.exports.changeTaskGroupOrder = (data, callback) => {
    sqlClean.escapeObjectStrings(data);
    console.log(data);

    let sql =  ``;
    data.forEach((ele)=>{
        sql +=  `UPDATE task_group tg SET tg._order = ${ele.order} WHERE tg.task_group_id = ${ele.groupid};`;
    });

    console.log(sql);
    connection.query(sql, callback);
}

// module.exports.taskAttrsWithValueByGroupId = (params, callback) => {

//     sqlClean.escapeObjectStrings(params);
//     console.log(params);

//     let sql =  ``;
//     sql +=  `SELECT tc.task_content_id, ta.attr_id, tat.element, tat.type, tc.value, ta.name, ta.placeholder, ta.label, ta.default_value, ta._order, tc.task_group_id, tc.version_id FROM task_attr ta 
//                 INNER JOIN task_attr_type tat ON tat.type_id = ta.attr_type_id
//                 INNER  JOIN task_attr_group tag ON tag.group_id = ta.group_id 
//                 INNER JOIN task_type_attr_group ttag ON ttag.attr_group_id = tag.group_id
//                 INNER JOIN task_group tg ON tg.task_type_attr_group_id = ttag.group_id
//                 INNER JOIN task_content tc ON tc.attr_id = ta.attr_id AND tc.task_group_id = tg.task_group_id
//             WHERE tg.task_group_id = ${params.id};
//             `;

//     console.log(sql);
//     connection.query(sql, callback);
// }

module.exports.updateTaskContent = (data, callback) => {
    sqlClean.escapeObjectStrings(data);
    let sql =  ``;
    Object.keys(data).forEach( (key) => {
        console.log(key);
        console.log(data[key]);

        sql += `UPDATE task_content SET value = '${data[key]}' WHERE task_content_id = '${key}';`;
    });

    console.log(sql);
    connection.query(sql, callback);
}

module.exports.findVersions = (params, callback) => {
    sqlClean.escapeObjectStrings(params);

    let sql =  `SELECT * FROM content_version WHERE version_id NOT IN (SELECT version_id FROM task_content WHERE task_group_id = ${params.groupid} AND attr_id= ${params.attrid});`;
    
    console.log(sql);
    connection.query(sql, callback);
}

module.exports.getTaskContentByGroupId = (params, callback) => {
    sqlClean.escapeObjectStrings(params);

    let sql =  `SELECT ta.attr_id 'attrid', ta.default_value, tat.element, tc.task_content_id 'id', ta.label, ta.placeholder, tat.type, value, tc.version_id 'version', cv.name 'version_name' FROM task_content tc 
                INNER JOIN task_attr ta ON ta.attr_id = tc.attr_id
                INNER JOIN task_attr_type tat ON ta.attr_type_id = tat.type_id
                INNER JOIN content_version cv ON cv.version_id = tc.version_id
                WHERE tc.task_group_id = ${params.groupid};`;
    
    console.log(sql);
    connection.query(sql, callback);
}

module.exports.addVersionContent = (data, callback) => {
    sqlClean.escapeObjectStrings(data);

    let groupid = data.groupid;
    let attrid = data.attrid;
    let versionswithvalue = data.versions;
    let sql = ``;
    if (versionswithvalue) {
        Object.keys(versionswithvalue).forEach(key => {
            if (versionswithvalue[key]) {
                sql += `INSERT INTO task_content (task_group_id, attr_id, version_id, value) VALUES ('${groupid}', '${attrid}', '${key}', '${versionswithvalue[key]}');`;
            }
        });
    }

    connection.query(sql, callback);
}

