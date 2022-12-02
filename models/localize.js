var connection = require('./connection');

var sqlClean = require('./_sql_clean');

module.exports.getTaskData = function (params, callback) {
    sqlClean.escapeObjectStrings(params);
    console.log('PARAMS: ', params);

    connection.query(`
        SELECT  t.task_id,
                t.name AS 'task_name',
                t.type_id AS 'task_type_id',
                tt.name AS 'task_type_name'

        FROM task AS t

            INNER JOIN task_type AS tt
                ON t.type_id = tt.type_id

            WHERE
                t.task_id = '` + params.task_id + `'

    `, callback);

}

module.exports.getTaskGroups = function (params, callback) {
    sqlClean.escapeObjectStrings(params);

    console.log('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> params: ', params);
    if (!params.task_id && params.id) {
        params.task_id = params.id;
    }
    connection.query(`
        SELECT  tg.task_group_id AS 'tg_id',
                tg.task_type_attr_group_id AS 'ttag_id',
                tag.name AS 'group_name',
                tag.icon

        FROM task_group AS tg

        INNER JOIN task_type_attr_group AS ttag
            ON ttag.group_id = tg.task_type_attr_group_id
            
        INNER JOIN task_attr_group AS tag
            ON tag.group_id = ttag.attr_group_id

        WHERE
            tg.task_id = '` + params.task_id + `'

    `, callback);

}

module.exports.getContentTranslation = function (params, callback) {
    sqlClean.escapeObjectStrings(params);
    connection.query(`
        SELECT  t.value

        FROM translation AS t

        WHERE
            t.content_id = '` + params.content_id + `'
        AND
            t.language_code = '` + params.lang_code + `'
        AND
            t.country_code = '` + params.country_code + `'

    `, callback);
}

module.exports.getTaskTerms = function (params, callback) {
    sqlClean.escapeObjectStrings(params);
    console.log('getTaskTerms PARAMS: ', params)
    connection.query(`
        SELECT  d.term_id,
            td.task_dictionary_id,
            c.content_id, 
            d.term,
            d.selector
        FROM task_dictionary AS td        
        INNER JOIN dictionary AS d
        ON d.term_id = td.dictionary_id
        INNER JOIN content c 
        ON c.content_item_id = td.task_dictionary_id AND c.content_type_id = 3 
        WHERE td.task_id = '` + params.task_id + `'
    `, callback);
}

module.exports.getTaskTermsLocal = function (params, callback) {
    sqlClean.escapeObjectStrings(params);
    console.log('getTaskTermsLocal PARAMS: ', params)

    connection.query(`
        SELECT  t.value AS 'content_value'
            FROM translation AS t
        WHERE
            t.content_id = '` + params.content_id + `'
            AND
            t.language_code = '` + params.taskDetails.lang_code + `'
            AND
            t.country_code = '` + params.taskDetails.country_code + `'
    `, callback);
}


module.exports.getTaskGroupContent = function (params, callback) {
    sqlClean.escapeObjectStrings(params);

    let sql = `
        SELECT DISTINCT c.content_id, c.content_type_id, tc.task_content_id, tc.value AS 'template_value',
            tc.version_id,
            ta.label,
            ta.placeholder,
            ta.default_value,
            tat.element,
            tat.type 
        FROM task_content AS tc
        INNER JOIN task_attr AS ta
            ON ta.attr_id = tc.attr_id
        INNER JOIN content AS c 
            ON tc.task_content_id = c.content_item_id
        INNER JOIN task_attr_type AS tat
            ON tat.type_id = ta.attr_type_id
        WHERE
            tc.task_group_id ='` + params.tg_id + `' AND content_type_id = 2
        ORDER BY ta._order;
        `;

    console.log('sdfds' + sql);
    connection.query(sql, callback);
}

module.exports.checkLocalContentItem = function (data, callback) {
    sqlClean.escapeObjectStrings(data);

    connection.query(`
        SELECT translation_id
            FROM translation
            WHERE
                content_id = '` + data.key + `'
                AND
                language_code = '` + data.lang_code + `'
                AND
                country_code = '` + data.country_code + `'
                AND
                type_id = 2
    `, callback);
}

module.exports.updateLocalContentItem = function (data, callback) {
    sqlClean.escapeObjectStrings(data);

    connection.query(`
        UPDATE translation
            SET
                value = '` + data.value + `'
        WHERE
            content_id = '` + data.content_id + `'
        AND
            type_id = 2
        AND
            language_code = '` + data.lang_code + `'
        AND 
            country_code = '` + data.country_code + `'

    `, callback);
}
module.exports.updateLocalContent = function (sql, callback) {
    // sqlClean.escapeObjectStrings(data);
    connection.query(sql, callback);
}

module.exports.createLocalContentItem = function (data, callback) {
    sqlClean.escapeObjectStrings(data);

    connection.query(`
        INSERT INTO translation
            SET
                content_id = '` + data.content_id + `',
                value = '` + data.value + `',
                type_id = 2,
                language_code = '` + data.lang_code + `',
                country_code = '` + data.country_code + `'
    `, callback);
}

module.exports.gettranslation = function (params, callback) {
    sqlClean.escapeObjectStrings(params);
    console.log('getTaskTerms PARAMS: ', params)
  /*  connection.query(`
            SELECT task_id, taskorder, taskname, cont.task_group_id, taskattributegroupname, taskgrouporder, 
            taskattributename, taskattributeorder, cont.value,  tr.translation_id, tr.value translationvalue, cont.content_id, icon, version_id, version_name, label, placeholder, default_value, type, element FROM  
            (SELECT ta.task_id, tg.task_group_id, ta.name 'taskname', tag.name 'taskattributegroupname', ta1.name 'taskattributename', 
            ta1._order 'taskattributeorder', tg._order 'taskgrouporder', c.content_id, c.content_type_id, c.content_item_id, tc.value, tag.icon 'icon', 
            lt._order 'taskorder' , tc.version_id, ta1.label, ta1.placeholder, ta1.default_value, tat.type, tat.element, cv.name 'version_name' 
            FROM task_content tc
            INNER JOIN task_group tg ON tg.task_group_id = tc.task_group_id
            INNER JOIN task ta ON ta.task_id = tg.task_id
            INNER JOIN task_attr ta1 ON ta1.attr_id = tc.attr_id
            INNER JOIN task_attr_group tag ON tag.group_id = ta1.group_id
            INNER JOIN lesson_task lt ON lt.task_id = ta.task_id
            INNER JOIN lesson le ON le.lesson_id = lt.lesson_id
            INNER JOIN content c ON c.content_item_id = tc.task_content_id
            INNER JOIN task_attr_type tat ON tat.type_id = ta1.attr_type_id
            INNER JOIN content_version cv ON cv.version_id = tc.version_id
            WHERE le.code = '` + params.lessoncode + `') cont 
            LEFT JOIN translation tr ON tr.content_id = cont.content_id AND tr.language_code='` + params.languagecode + `' AND tr.country_code='` + params.countrycode + `'
            ORDER BY taskorder, task_id, cont.task_group_id, taskgrouporder, taskattributeorder;

            SELECT dict.content_id, dict.term, tr.translation_id, tr.value, task_id, task_dictionary_id, CASE WHEN ISNULL(tr.translation_id) THEN TRUE ELSE FALSE END 'isnew', FALSE 'altered' FROM (SELECT d.term, d.selector, c.content_id, t.task_id, c.content_type_id, td.task_dictionary_id FROM task_dictionary td
            INNER JOIN content c ON c.content_item_id = td.task_dictionary_id
            INNER JOIN task t ON t.task_id = td.task_id
            INNER JOIN lesson_task lt ON lt.task_id = t.task_id
            INNER JOIN lesson le ON le.lesson_id = lt.lesson_id
            INNER JOIN dictionary d ON d.term_id = td.dictionary_id
            WHERE le.code = '` + params.lessoncode + `' AND c.content_type_id = 3) dict
            LEFT JOIN translation tr ON tr.content_id = dict.content_id AND tr.language_code='` + params.languagecode + `' AND tr.country_code='` + params.countrycode + `'
            ORDER BY dict.task_id,dict.term;
    `, callback);*/
    if (!(params.vehiclecode))
      params.vehiclecode = 'PV';
      console.log(params.versioncode);
    if (params.versioncode == undefined)
      params.versioncode = 'NULL';
     connection.query(`SELECT task_id, taskorder, taskname, cont.task_group_id, taskattributegroupname, taskgrouporder, taskattributename, taskattributeorder, cont.value, tr.translation_id, tr.value translationvalue, cont.content_id, icon, version_id, version_name, label, placeholder, default_value, type, element FROM (SELECT ta.task_id, tg.task_group_id, ta.name 'taskname', tag.name 'taskattributegroupname', ta1.name 'taskattributename', ta1._order 'taskattributeorder', tg._order 'taskgrouporder', c.content_id, c.content_type_id, c.content_item_id, tc.value, tag.icon 'icon', lt._order 'taskorder', tc.version_id, ta1.label, ta1.placeholder, ta1.default_value, tat.type, tat.element, cv.name 'version_name' FROM task_content tc 
    INNER JOIN task_group tg ON tg.task_group_id = tc.task_group_id 
    INNER JOIN task ta ON ta.task_id = tg.task_id 
    INNER JOIN task_attr ta1 ON ta1.attr_id = tc.attr_id  
    INNER JOIN task_attr_group tag ON tag.group_id = ta1.group_id  
    INNER JOIN lesson_task lt ON lt.task_id = ta.task_id 
    INNER JOIN lesson le  ON le.lesson_id = lt.lesson_id 
    INNER JOIN content c ON c.content_item_id = tc.task_content_id 
    INNER JOIN task_attr_type tat ON tat.type_id = ta1.attr_type_id 
    INNER JOIN content_version cv ON cv.version_id = tc.version_id 
    RIGHT JOIN vehicle v ON v.vehicle_id = le.vehicle_id WHERE le.code = '` + params.lessoncode + `' AND c.content_type_id = 2 AND v.code = IF('` + params.vehiclecode + `' IS NULL, 'PV', '` + params.vehiclecode + `') AND IF('` + params.versioncode + `' like 'NULL', le.version_id IS NULL, le.version_id = (SELECT v1.id FROM version v1 WHERE v1.code LIKE '` + params.versioncode + `'))) cont LEFT JOIN translation tr ON tr.content_id = cont.content_id AND tr.language_code = '` + params.languagecode + `' AND tr.country_code = '` + params.countrycode + `' ORDER BY taskorder, task_id, cont.task_group_id, taskgrouporder, taskattributeorder;
    SELECT dict.content_id, dict.term, tr.translation_id, tr.value, task_id, task_dictionary_id, CASE WHEN ISNULL(tr.translation_id) THEN TRUE ELSE FALSE END 'isnew', FALSE 'altered' FROM (SELECT  d.term, d.selector, c.content_id, t.task_id, c.content_type_id, td.task_dictionary_id
    FROM task_dictionary td 
    INNER JOIN content c ON c.content_item_id = td.task_dictionary_id 
    INNER JOIN task t ON t.task_id = td.task_id 
    INNER JOIN lesson_task lt ON lt.task_id = t.task_id 
    INNER JOIN lesson le ON le.lesson_id = lt.lesson_id 
    INNER JOIN dictionary d ON d.term_id = td.dictionary_id
    RIGHT JOIN vehicle v ON v.vehicle_id = le.vehicle_id WHERE le.code ='` + params.lessoncode + `' AND c.content_type_id = 3 AND v.code = IF('` + params.vehiclecode + `' IS NULL, 'PV', '` + params.vehiclecode + `') AND IF('` + params.versioncode + `' like 'NULL', le.version_id IS NULL, le.version_id = (SELECT  v1.id FROM version v1 WHERE v1.code LIKE '` + params.versioncode + `'))) dict LEFT JOIN translation tr ON tr.content_id = dict.content_id AND tr.language_code = '` + params.languagecode + `' AND tr.country_code = '` + params.countrycode + `' ORDER BY dict.task_id, dict.term;`, callback);
}
module.exports.getVehicleLocalization = function (params, callback) {
    sqlClean.escapeObjectStrings(params);
    console.log('getTaskTerms PARAMS: ', params)
    connection.query(`SELECT v.name,v.code FROM vehicle v 
                      INNER JOIN lesson l ON  l.vehicle_id =  v.vehicle_id 
                      WHERE l.code = '` + params.code + `' group by v.vehicle_id;`, callback);
}

module.exports.getVersionLocalization = function (params, callback) {
    sqlClean.escapeObjectStrings(params);
    console.log('getTaskTerms PARAMS: ', params)
    connection.query(`SELECT v.name,v.code FROM version v 
                        INNER JOIN lesson l ON  l.version_id =  v.id 
                        WHERE l.code = '` + params.code + `' GROUP BY v.id;`, callback);
}
module.exports.getVehicleVersion = function (params, callback) {
    sqlClean.escapeObjectStrings(params);
    console.log('getTaskTerms PARAMS: ', params)
    connection.query(`SELECT v.name,v.code FROM version v 
                        INNER JOIN lesson l ON  l.version_id =  v.id INNER JOIN vehicle vhcle ON vhcle.vehicle_id =  l.vehicle_id
                        WHERE l.code = '` + params.lessoncode + `' AND vhcle.code = '` + params.vehiclecode + `' GROUP BY v.id;`, callback);
}
// :lessoncode/:countrycode/:languagecode