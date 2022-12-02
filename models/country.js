var mysql = require('mysql');

var connection = require('./connection');

var sqlClean = require('./_sql_clean');

module.exports.getAllCountries = function(callback) {
    connection.query(`
        SELECT country_id, name, code, continent
            FROM country
        ORDER BY name DESC
    `, callback);
}

module.exports.findCountry = function(params, callback) {
sqlClean.escapeObjectStrings(params);
	connection.query(`
        SELECT country_id, name, code, continent
            FROM country
        WHERE country_id = '` + params.id + `'
    `, callback);
}
module.exports.updateCountry = function(data, callback) {
sqlClean.escapeObjectStrings(data);
    console.log('SQL COUNTRY UPDATE REQUEST: ', data)
    connection.query(`
        UPDATE country
            SET name = '` + data.name + `',
                code = '` + data.code + `',
                continent = '` + data.continent + `'
        WHERE country_id = '` + data.country_id + `'
    `, callback);
}
module.exports.createCountry = function(data, callback) {
sqlClean.escapeObjectStrings(data);
    console.log('SQL COUNTRY CREATE REQUEST: ', data)
    connection.query(`
        INSERT INTO country
            SET name = '` + data.name + `',
                code = '` + data.code + `',
                continent = '` + data.continent + `'
    `, data, callback);
}

module.exports.findCountryLanguages = function(params, callback) {
sqlClean.escapeObjectStrings(params);
	connection.query(`
        SELECT
            l.name AS 'name',
            l.language_id AS 'language_id',
            l.code AS 'code'
            FROM country_language AS cl
		INNER JOIN language AS l
			ON cl.language_code = l.code
            WHERE cl.country_code = '` + params.code + `'
		ORDER BY cl.language_code ASC`
    , callback);
    
    //ON cl.language_code = l.code
    //WHERE cl.country_code = '` + params.code + `'
}
module.exports.findCountrySettingGroups = function(params, callback) {
sqlClean.escapeObjectStrings(params);
	connection.query(`
        SELECT * FROM country_attr_group AS sg
    `, callback);
}
module.exports.findCountrySettingTypes = function(params, callback) {
sqlClean.escapeObjectStrings(params);
	connection.query(`
        SELECT * FROM country_attr_type AS st
            WHERE st.group_id = '` + params.group_id + `'
    `, callback);
}
module.exports.findCountrySettingTypeOptions = function(params, callback) {
sqlClean.escapeObjectStrings(params);
	connection.query(`
        SELECT * FROM country_attr_type_option AS sto
            WHERE sto.type_id = '` + params.type_id + `'
    `, callback);
}

module.exports.findCountrySettingTypeSelected = function(params, callback) {
sqlClean.escapeObjectStrings(params);
	connection.query(`
        SELECT * FROM country_attr AS sts
            WHERE sts.country_id = '` + params.country_id + `' AND sts.type_id = '` + params.type_id + `'
    `, callback);
    //
}

module.exports.findAll = function(callback) {
    connection.query(`
        SELECT name AS Name, code AS Code, code2 AS 'Code 2', continent AS Continent
        FROM country
    `, callback);
}


module.exports.addCountry = function(data, callback) {
sqlClean.escapeObjectStrings(data);
    connection.query(`
        INSERT INTO user 
        SET ?
    `, data, callback);
}

module.exports.findCountryPropStatus = function(data, callback) {
sqlClean.escapeObjectStrings(data);
    console.log('SQL getcountrypropstatus REQUEST: ', data)
	connection.query(`
        SELECT *
            FROM country_property
        WHERE
            country_id          = '` + data.country_id + `'
            AND
            content_version_property_id  = '` + data.property_id + `'
    `, callback);
}

module.exports.updateCountryProperty = function(data, callback) {
sqlClean.escapeObjectStrings(data);

    console.log('SQL UPDATE ATTR PROPERTY REQUEST here: ', data)

    connection.query(`
        INSERT INTO country_property
            SET
                country_id          = '` + data.country_id + `',
                content_version_property_id  = '` + data.property_id + `'

    `, callback);

}
module.exports.deleteCountryProperty = function(data, callback) {
sqlClean.escapeObjectStrings(data);

    console.log('SQL DELETE CONTENET REQUEST: ', data)
   
    connection.query(`
    DELETE FROM country_property
        WHERE
            country_id          = '` + data.country_id + `'
            AND
            content_version_property_id  = '` + data.property_id + `'
    `, callback);
}

module.exports.deleteCountryLanguageLink = function(params, callback) {
sqlClean.escapeObjectStrings(params);
    
    console.log('DELETE COUNTRY LANGUAGE LINK: ', params)
    
    connection.query(`
        DELETE FROM country_language
            WHERE country_code = '` + params.country_code + `'
                AND
                language_code = '` + params.language_code + `'
    `, callback);
}
module.exports.addCountryLanguageLink = function(params, callback) {
sqlClean.escapeObjectStrings(params);

    console.log('ADD COUNTRY LANGUAGE LINK: ', params)

    connection.query(`
        INSERT INTO country_language
            SET
                country_code = '` + params.country_code + `',
                language_code = '` + params.language_code + `'

            ON DUPLICATE KEY
                UPDATE
                    country_code = '` + params.country_code + `'
                AND
                    language_code = '` + params.language_code + `'
    `, callback);

}