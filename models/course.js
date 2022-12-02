var connection = require('./connection');

var sqlClean = require('./_sql_clean');

module.exports.getAllCourses = function(callback) {
    connection.query(`
        SELECT  s.name AS 'status',
                c.course_id AS 'id',
                c.name,
                c.description,
                c.code
            FROM course AS c
        INNER JOIN status AS s
            ON c.status_id = s.status_id
    `, callback);
}
module.exports.findCourse = function(params, callback) {
sqlClean.escapeObjectStrings(params);
	connection.query(`
        SELECT *
            FROM course
        WHERE course_id = '` + params.id + `'
    `, callback);
}
module.exports.updateCourse = function(data, callback) {
sqlClean.escapeObjectStrings(data);
    console.log('SQL COURSE UPDATE REQUEST: ', data)
    connection.query(`
        UPDATE course
            SET name = '` + data.name + `',
                code = '` + data.code + `',
                description = '` + data.description + `',
                status_id = '` + data.status_id + `'
        WHERE course_id = '` + data.course_id + `'
    `, callback);
}
module.exports.updateCourseLessonsOrder = function(data, callback) {
sqlClean.escapeObjectStrings(data);
    console.log('SQL COURSE UPDATE REQUEST: ', data)
    console.log('ORDER: ', data.order)
    console.log('LINK ID: ', data.link_id)
    connection.query(`
        UPDATE course_lesson
            SET _order = '` + data.order + `'
        WHERE course_lesson_id = '` + data.link_id + `'
    `, callback);

    /*
    connection.query(`
        UPDATE course_lesson
            SET order = '` + data.order + `'
        WHERE course_lesson_id = '` + data.link_id + `'
    `, data, callback);
    */
}

module.exports.createCourse = function(data, callback) {
sqlClean.escapeObjectStrings(data);
    console.log('SQL COURSE CREATE REQUEST: ', data)
    /*connection.query(`
        INSERT INTO Customers (
            CustomerName, ContactName, Address, City, PostalCode, Country)
    VALUES ('Cardinal', 'Tom B. Erichsen', 'Skagen 21', 'Stavanger', '4006', 'Norway');
    `);*/
    connection.query(`
        INSERT INTO course
            SET name = '` + data.name + `',
                code = '` + data.code + `',
                description = '` + data.description + `',
                status_id = '` + data.status_id + `'
    `, data, callback);
}

module.exports.findCourseLessonsXXX = function(params, callback) {
sqlClean.escapeObjectStrings(params);
	connection.query(`
		SELECT *
            FROM lesson
		`
    , callback);
}

module.exports.findCourseLessons = function(params, callback) {
sqlClean.escapeObjectStrings(params);
	connection.query(`
        SELECT  l.lesson_id AS id,
                s.name AS 'status',
                l.name,
                l.code,
                l.description,
                cl.course_lesson_id AS 'link_id',
                cl._order AS 'order'
            FROM course_lesson AS cl
		INNER JOIN lesson AS l
			ON cl.lesson_id = l.lesson_id
        INNER JOIN status AS s
            ON l.status_id = s.status_id
            WHERE cl.course_id = '` + params.id + `'
		`
    , callback);
}

module.exports.delete = function(params, callback) {
    sqlClean.escapeObjectStrings(params);
        connection.query(`
        DELETE FROM course_lesson WHERE course_id = '` + params.id + `';
        DELETE FROM course where course_id = '` + params.id + `';
        `
        , callback);
    }
//ORDER BY l.order ASC`