USE dams_schema_int1xxxxxxxxxxxxxxxxxxxxxxx;
DELIMITER $$

--
-- Create procedure `sp_task_list`
--
CREATE PROCEDURE sp_task_list(IN startindex int,
IN pagesize int,
IN sortfield varchar(100),
IN sortorder varchar(4),
IN searchtext varchar(100))
BEGIN

  SET @DIR = CASE WHEN sortorder = '' THEN 'DESC' ELSE sortorder END;
  SET @startindex = CONVERT(startindex, char);
  SET @pagesize = CONVERT(pagesize, char);
  SET @searchtextnew = '';

  IF searchtext != '' THEN
    SET @searchtextnew = CONCAT('WHERE t.name like ''', '%', searchtext, '%', '''');
  END IF;

  SET @sql1 = CONCAT('SELECT s.name AS "status", t.task_id AS "id", tt.name AS "type", t.name,t.description FROM task as t INNER JOIN status AS s ON t.status_id = s.status_id INNER JOIN task_type AS tt ON t.type_id = tt.type_id ', @searchtextnew, ' ORDER BY ', sortfield, ' ', @DIR, ' LIMIT ', @startindex, ' ,', @pagesize, ';');
  SET @sql2 = CONCAT('SELECT  COUNT(''', '*', ''') AS ', '"@totalRecords"', ' FROM task as t INNER JOIN status AS s ON t.status_id = s.status_id INNER JOIN task_type AS tt ON t.type_id = tt.type_id ', @searchtextnew, ';');
  -- SELECT @sql2;

  PREPARE statmentsql1 FROM @sql1;
  EXECUTE statmentsql1;
  DEALLOCATE PREPARE statmentsql1;

  PREPARE statmentsql2 FROM @sql2;
  EXECUTE statmentsql2;
  DEALLOCATE PREPARE statmentsql2;

END
$$

DELIMITER ;

DELIMITER $$

--
-- Create procedure `sp_export_lesson_to_json`
--
CREATE PROCEDURE sp_export_lesson_to_json(IN countrycode VARCHAR(255), IN languagecode VARCHAR(255), IN lessoncode VARCHAR(100))
BEGIN

/* global variables */
SET @country_code := countrycode;
SET @language_code := languagecode;
SET @lesson_code := lessoncode;
SET @content_version_property_id_imperial := 5;
SET @content_version_property_id_metric := 6;
SET @is_imperial := FALSE;
SET @is_metric := FALSE;
SET @lang_dir := '';
SET @lesson_id := 0;
/* lang_dir */
SELECT @lang_dir := l.text_dir FROM language AS l WHERE l.code = @language_code;

/* is_imperial */
SELECT  @is_imperial := TRUE FROM country_property AS cp
    INNER JOIN content_version_property AS cvp
        ON cvp.property_id = cp.content_version_property_id
    INNER JOIN country AS c
        ON c.code = @country_code
WHERE
    cp.country_id = c.country_id
    AND
    cp.content_version_property_id = @content_version_property_id_imperial;

/* is_metric */
SELECT  @is_metric := TRUE FROM country_property AS cp
    INNER JOIN content_version_property AS cvp
        ON cvp.property_id = cp.content_version_property_id
    INNER JOIN country AS c
        ON c.code = @country_code
WHERE
    cp.country_id = c.country_id
    AND
    cp.content_version_property_id = @content_version_property_id_metric;

/* Lesson query*/
SELECT
  lesson.lesson_id,
  lesson.code AS 'lesson_code',
  lesson.name AS 'lesson_name',
  course.code AS 'course_code',
  course.name AS 'course_name',
  lesson_type.type_id,
  lesson_type.name AS 'lesson_type',
  @is_imperial AS 'is_imperial',
  @is_metric AS 'is_metric',
  @lang_dir AS 'lang_dir',
  @country_code AS 'country_code',
  @language_code AS 'lang_code',
  v.code AS 'vehicle_code'
FROM course_lesson
  INNER JOIN course
    ON course.course_id = course_lesson.course_id
  INNER JOIN lesson
    ON course_lesson.lesson_id = lesson.lesson_id
  INNER JOIN lesson_type
    ON lesson.type_id = lesson_type.type_id
  INNER JOIN vehicle v ON v.vehicle_id = lesson.vehicle_id
WHERE lesson.code = @lesson_code;

SELECT @lesson_id := lesson.lesson_id FROM lesson WHERE lesson.code = @lesson_code;

DROP TEMPORARY TABLE IF EXISTS tmp_tbl_versionlist; 

CREATE TEMPORARY TABLE IF NOT EXISTS tmp_tbl_versionlist AS (SELECT * FROM (SELECT 1 AS 'version_id'
  UNION DISTINCT
SELECT DISTINCT cv.version_id FROM content_version cv 
  INNER JOIN content_version_group cvg ON cvg.version_id = cv.version_id
  INNER JOIN content_version_property cvp ON cvp.property_id = cvg.property_id
  INNER JOIN country_property cp ON cp.content_version_property_id = cvp.property_id
  INNER JOIN country c ON c.country_id = cp.country_id WHERE c.code = @country_code ) T ORDER BY T. version_id);

SELECT DISTINCT t.name, t.type_id 'task_type_id', tt.code_angular 'pagetype', lt1.value 'lockType', lt.task_id, t.display_main, t.display_next, t.display_innav, t.lock_time 'lockTime',
  TRUE 'pagecenter' 
  FROM task_content tc
INNER JOIN task_group tg ON tc.task_group_id = tg.task_group_id 
INNER JOIN task t ON t.task_id = tg.task_id 
INNER JOIN task_type tt ON tt.type_id = t.type_id 
INNER JOIN lock_type lt1 ON lt1.lock_type_id = t.lock_type
INNER JOIN lesson_task lt ON lt.task_id = t.task_id   
INNER JOIN task_attr ta ON ta.attr_id = tc.attr_id 
WHERE tc.version_id IN (SELECT DISTINCT version_id FROM tmp_tbl_versionlist) AND lt.lesson_id = @lesson_id 
ORDER BY lt._order;

SELECT lt.task_id,
  ta.`group`, TA.type, 
  CASE WHEN t1.value IS NULL OR t1.value = '' THEN tc.value ELSE t1.value END AS 'value', 
  c.content_id, TC.task_group_id, tc.version_id, tc.attr_id
  FROM task_content tc
INNER JOIN task_group tg ON tc.task_group_id = tg.task_group_id 
INNER JOIN task t ON t.task_id = tg.task_id 
INNER JOIN task_type tt ON tt.type_id = t.type_id 
INNER JOIN lock_type lt1 ON lt1.lock_type_id = t.lock_type
INNER JOIN lesson_task lt ON lt.task_id = t.task_id   
INNER JOIN task_attr ta ON ta.attr_id = tc.attr_id 
LEFT  JOIN content c ON c.content_item_id = tc.task_content_id AND c.content_type_id = 2 
LEFT JOIN translation t1 ON t1.content_id = c.content_id AND t1.language_code = @language_code AND t1.country_code=@country_code 
WHERE tc.version_id IN (SELECT DISTINCT version_id FROM tmp_tbl_versionlist) AND lt.lesson_id = @lesson_id  
ORDER BY  lt._order, tg._order, tc.task_group_id, ta.`group`, ta.type, ta._order, tc.attr_id, tc.version_id;



SELECT td.task_id, d.term, d.selector, t1.value FROM task_dictionary td 
  INNER JOIN dictionary d ON td.dictionary_id = d.term_id   
  LEFT  JOIN content c ON c.content_item_id = td.task_dictionary_id AND c.content_type_id = 3 
  LEFT JOIN translation t1 ON t1.content_id = c.content_id AND t1.language_code = @language_code AND t1.country_code=@country_code  
WHERE td.task_id IN (SELECT DISTINCT lt.task_id FROM lesson_task lt WHERE lt.lesson_id=@lesson_id);

END
$$

DELIMITER ;

DELIMITER $$

CREATE FUNCTION GetValidCountryCode(countrycode VARCHAR(25), languagecode VARCHAR(25), lessoncode VARCHAR(25))
  RETURNS varchar(25)
BEGIN

SET @Ccode := countrycode;
SET @Lcode := languagecode;
SET @LeCode := lessoncode;
SET @cnt := 0;

SET @cnt = (SELECT COUNT('*') FROM Translation t 
  INNER JOIN task_content tc ON t.item_id = tc.content_id 
  INNER JOIN task_group tg ON tg.task_group_id = tc.task_group_id
  INNER JOIN task ta ON ta.task_id = tg.task_id
  INNER JOIN lesson_task lt ON lt.task_id = ta.task_id
  INNER JOIN lesson le ON le.lesson_id = lt.lesson_id 
  INNER JOIN Country c ON c.code = t.country_code  
  WHERE t.country_code = @Ccode AND t.language_code = @Lcode AND le.code = @LeCode);

IF(@cnt = 0) THEN 
  SET countrycode := (SELECT code2 FROM country WHERE code = @Ccode LIMIT 1);
  SET @cnt = (SELECT COUNT('*') FROM Translation t 
  INNER JOIN task_content tc ON t.item_id = tc.content_id 
  INNER JOIN task_group tg ON tg.task_group_id = tc.task_group_id
  INNER JOIN task ta ON ta.task_id = tg.task_id
  INNER JOIN lesson_task lt ON lt.task_id = ta.task_id
  INNER JOIN lesson le ON le.lesson_id = lt.lesson_id 
  INNER JOIN Country c ON c.code = t.country_code  
  WHERE t.country_code = countrycode AND t.language_code = @Lcode AND le.code = @LeCode);
END IF;

IF(@cnt = 0) THEN 
  SET countrycode := '';
END IF;

RETURN countrycode;

END
$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE dams_schema.sp_export_lesson_to_json_v2(IN countrycode VARCHAR(255), IN languagecode VARCHAR(255), IN lessoncode VARCHAR(100))
BEGIN

/* global variables */
SET @country_code := countrycode;
SET @language_code := languagecode;
SET @lesson_code := lessoncode;
SET @content_version_property_id_imperial := 5;
SET @content_version_property_id_metric := 6;
SET @is_imperial := FALSE;
SET @is_metric := FALSE;
SET @lang_dir := '';
SET @lesson_id := 0;

SET @task_type_question := 10;
/* lang_dir */
SELECT @lang_dir := l.text_dir FROM language AS l WHERE l.code = @language_code;

/* is_imperial */
SELECT  @is_imperial := TRUE FROM country_property AS cp
    INNER JOIN content_version_property AS cvp
        ON cvp.property_id = cp.content_version_property_id
    INNER JOIN country AS c
        ON c.code = @country_code
WHERE
    cp.country_id = c.country_id
    AND
    cp.content_version_property_id = @content_version_property_id_imperial;

/* is_metric */
SELECT  @is_metric := TRUE FROM country_property AS cp
    INNER JOIN content_version_property AS cvp
        ON cvp.property_id = cp.content_version_property_id
    INNER JOIN country AS c
        ON c.code = @country_code
WHERE
    cp.country_id = c.country_id
    AND
    cp.content_version_property_id = @content_version_property_id_metric;

/* Lesson query*/
SELECT
  lesson.lesson_id,
  lesson.code AS 'lesson_code',
  lesson.name AS 'lesson_name',
  course.code AS 'course_code',
  course.name AS 'course_name',
  lesson_type.type_id,
  lesson_type.name AS 'lesson_type',
  @is_imperial AS 'is_imperial',
  @is_metric AS 'is_metric',
  @lang_dir AS 'lang_dir',
  @country_code AS 'country_code',
  @language_code AS 'lang_code',
  v.code AS 'vehicle_code'
FROM course_lesson
  INNER JOIN course
    ON course.course_id = course_lesson.course_id
  INNER JOIN lesson
    ON course_lesson.lesson_id = lesson.lesson_id
  INNER JOIN lesson_type
    ON lesson.type_id = lesson_type.type_id
  INNER JOIN vehicle v ON v.vehicle_id = lesson.vehicle_id
WHERE lesson.code = @lesson_code;

SELECT @lesson_id := lesson.lesson_id FROM lesson WHERE lesson.code = @lesson_code;
/* TEMPORARY table */
DROP TEMPORARY TABLE IF EXISTS tmp_tbl_versionlist; 
DROP TEMPORARY TABLE IF EXISTS tmp_tbl_versionlist2; 

CREATE TEMPORARY TABLE IF NOT EXISTS tmp_tbl_versionlist AS (SELECT * FROM (SELECT 1 AS 'version_id'
  UNION DISTINCT
SELECT DISTINCT cv.version_id FROM content_version cv 
  INNER JOIN content_version_group cvg ON cvg.version_id = cv.version_id
  INNER JOIN content_version_property cvp ON cvp.property_id = cvg.property_id
  INNER JOIN country_property cp ON cp.content_version_property_id = cvp.property_id
  INNER JOIN country c ON c.country_id = cp.country_id WHERE c.code = @country_code ) T ORDER BY T. version_id);

CREATE TEMPORARY TABLE IF NOT EXISTS tmp_tbl_versionlist2 AS (SELECT * FROM (SELECT 1 AS 'version_id'
  UNION DISTINCT
SELECT DISTINCT cv.version_id FROM content_version cv 
  INNER JOIN content_version_group cvg ON cvg.version_id = cv.version_id
  INNER JOIN content_version_property cvp ON cvp.property_id = cvg.property_id
  INNER JOIN country_property cp ON cp.content_version_property_id = cvp.property_id
  INNER JOIN country c ON c.country_id = cp.country_id WHERE c.code = @country_code ) T ORDER BY T. version_id);

SELECT DISTINCT t.name, t.type_id 'task_type_id', tt.code_angular 'pagetype', lt1.value 'lockType', lt.task_id, t.display_main, t.display_next, t.display_innav, t.lock_time 'lockTime',
  TRUE 'pagecenter' , lt._order
  FROM task_content tc
INNER JOIN task_group tg ON tc.task_group_id = tg.task_group_id 
INNER JOIN task t ON t.task_id = tg.task_id 
INNER JOIN task_type tt ON tt.type_id = t.type_id 
INNER JOIN lock_type lt1 ON lt1.lock_type_id = t.lock_type
INNER JOIN lesson_task lt ON lt.task_id = t.task_id   
INNER JOIN task_attr ta ON ta.attr_id = tc.attr_id 
WHERE tc.version_id IN (SELECT DISTINCT version_id FROM tmp_tbl_versionlist) AND lt.lesson_id = @lesson_id 
ORDER BY lt._order;

SELECT task_id,`group`, type, `value`, content_id, task_group_id, version_id, attr_id, lt_order 
FROM (
SELECT lt.task_id,
  ta.`group`, ta.type, 
  CASE WHEN t1.value IS NULL OR t1.value = '' THEN tc.value ELSE t1.value END AS 'value', 
  c.content_id, tc.task_group_id, tc.version_id, tc.attr_id, lt._order 'lt_order',
  tg._order 'tg_order', ta._order 'ta_order'
  FROM task_content tc
INNER JOIN task_group tg ON tc.task_group_id = tg.task_group_id 
INNER JOIN task t ON t.task_id = tg.task_id 
INNER JOIN task_type tt ON tt.type_id = t.type_id 
INNER JOIN lock_type lt1 ON lt1.lock_type_id = t.lock_type
INNER JOIN lesson_task lt ON lt.task_id = t.task_id   
INNER JOIN task_attr ta ON ta.attr_id = tc.attr_id 
LEFT  JOIN content c ON c.content_item_id = tc.task_content_id AND c.content_type_id = 2 
LEFT JOIN translation t1 ON t1.content_id = c.content_id AND t1.language_code = @language_code AND t1.country_code=@country_code 
WHERE tc.version_id IN (SELECT DISTINCT version_id FROM tmp_tbl_versionlist) AND lt.lesson_id = @lesson_id AND t.type_id !=10
UNION 
SELECT lt.task_id,
  ta.`group`, ta.type, 
  CASE WHEN t1.value IS NULL OR t1.value = '' THEN tc.value ELSE t1.value END AS 'value', 
  c.content_id, tc.task_group_id, tc.version_id, tc.attr_id, lt._order 'lt_order',
  tg._order 'tg_order', ta._order 'ta_order'
  FROM task_content tc
INNER JOIN task_group tg ON tc.task_group_id = tg.task_group_id 
INNER JOIN task t ON t.task_id = tg.task_id 
INNER JOIN task_type tt ON tt.type_id = t.type_id 
INNER JOIN lock_type lt1 ON lt1.lock_type_id = t.lock_type
INNER JOIN lesson_task lt ON lt.task_id = t.task_id   
INNER JOIN task_attr ta ON ta.attr_id = tc.attr_id 
INNER JOIN content c ON c.content_item_id = tc.task_content_id AND c.content_type_id = 2 
INNER JOIN translation t1 ON t1.content_id = c.content_id AND t1.language_code = @language_code AND t1.country_code=@country_code 
WHERE tc.version_id IN (SELECT DISTINCT version_id FROM tmp_tbl_versionlist2) AND lt.lesson_id = @lesson_id AND t.type_id = 10
) AS T1 
ORDER BY  lt_order, tg_order, task_group_id, `group`, type, ta_order, attr_id, version_id;

-- SELECT td.task_id, d.term, d.selector, t1.value FROM task_dictionary td 
--   INNER JOIN dictionary d ON td.dictionary_id = d.term_id   
--   LEFT  JOIN content c ON c.content_item_id = td.task_dictionary_id AND c.content_type_id = 3 
--   LEFT JOIN translation t1 ON t1.content_id = c.content_id AND t1.language_code = @language_code AND t1.country_code=@country_code  
-- WHERE td.task_id IN (SELECT DISTINCT lt.task_id FROM lesson_task lt WHERE lt.lesson_id=@lesson_id);

END
$$
DELIMITER ;