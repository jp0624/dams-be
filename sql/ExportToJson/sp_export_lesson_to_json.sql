CREATE DEFINER = 'root'@'localhost'
PROCEDURE dams_schema.sp_export_lesson_to_json(IN countrycode varchar(255), IN languagecode varchar(255), IN lessoncode varchar(100), IN vehiclecode varchar(100), IN versioncode varchar(100))
BEGIN

  /* global variables */
  SET @country_code := countrycode;
  SET @language_code := languagecode;
  SET @lesson_code := lessoncode;
  SET @vehicle_code := vehiclecode;
  SET @version_code := versioncode;
  SET @content_version_property_id_imperial := 5;
  SET @content_version_property_id_metric := 6;
  SET @is_imperial := FALSE;
  SET @is_metric := FALSE;
  SET @lang_dir := '';
  SET @lesson_id := 0;

  SET @task_type_question := 10;
  /* lang_dir */
  SELECT
    @lang_dir := l.text_dir
  FROM language AS l
  WHERE l.code = @language_code;

  /* is_imperial */
  SELECT
    @is_imperial := TRUE
  FROM country_property AS cp
    INNER JOIN content_version_property AS cvp
      ON cvp.property_id = cp.content_version_property_id
    INNER JOIN country AS c
      ON c.code = @country_code
  WHERE cp.country_id = c.country_id
  AND cp.content_version_property_id = @content_version_property_id_imperial;

  /* is_metric */
  SELECT
    @is_metric := TRUE
  FROM country_property AS cp
    INNER JOIN content_version_property AS cvp
      ON cvp.property_id = cp.content_version_property_id
    INNER JOIN country AS c
      ON c.code = @country_code
  WHERE cp.country_id = c.country_id
  AND cp.content_version_property_id = @content_version_property_id_metric;

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
    v.code AS 'vehicle_code',
    v1.code AS 'version_code'
  FROM course_lesson
    INNER JOIN course
      ON course.course_id = course_lesson.course_id
    INNER JOIN lesson
      ON course_lesson.lesson_id = lesson.lesson_id
    INNER JOIN lesson_type
      ON lesson.type_id = lesson_type.type_id
    INNER JOIN vehicle v
      ON v.vehicle_id = lesson.vehicle_id
    LEFT JOIN version v1
      ON v1.id = lesson.version_id

  WHERE lesson.code LIKE @lesson_code
  AND IF(@vehicle_code IS NULL, v.code LIKE 'PV', v.code LIKE @vehicle_code)
  AND IF(@version_code IS NULL, lesson.version_id IS NULL, v1.code LIKE @version_code);

  SELECT
    @lesson_id := lesson.lesson_id
  FROM lesson
    INNER JOIN lesson_type
      ON lesson.type_id = lesson_type.type_id
    INNER JOIN vehicle v
      ON v.vehicle_id = lesson.vehicle_id
    LEFT JOIN version v1
      ON v1.id = lesson.version_id

  WHERE lesson.code LIKE @lesson_code
  AND IF(@vehicle_code IS NULL, v.code LIKE 'PV', v.code LIKE @vehicle_code)
  AND IF(@version_code IS NULL, lesson.version_id IS NULL, v1.code LIKE @version_code);


  /* TEMPORARY table */
  DROP TEMPORARY TABLE IF EXISTS tmp_tbl_versionlist;

  CREATE TEMPORARY TABLE IF NOT EXISTS tmp_tbl_versionlist AS (SELECT
      *
    FROM (SELECT
        1 AS 'version_id'
      UNION DISTINCT
      SELECT DISTINCT
        cv.version_id
      FROM content_version cv
        INNER JOIN content_version_group cvg
          ON cvg.version_id = cv.version_id
        INNER JOIN content_version_property cvp
          ON cvp.property_id = cvg.property_id
        INNER JOIN country_property cp
          ON cp.content_version_property_id = cvp.property_id
        INNER JOIN country c
          ON c.country_id = cp.country_id
      WHERE c.code = @country_code) T
    ORDER BY T.version_id);

  SELECT DISTINCT
    t.name,
    t.type_id 'task_type_id',
    tt.code_angular 'pagetype',
    lt1.value 'lockType',
    lt.task_id,
    t.display_main,
    t.display_next,
    t.display_innav,
    t.lock_time 'lockTime',
    TRUE 'pagecenter'
  FROM task_content tc
    INNER JOIN task_group tg
      ON tc.task_group_id = tg.task_group_id
    INNER JOIN task t
      ON t.task_id = tg.task_id
    INNER JOIN task_type tt
      ON tt.type_id = t.type_id
    INNER JOIN lock_type lt1
      ON lt1.lock_type_id = t.lock_type
    INNER JOIN lesson_task lt
      ON lt.task_id = t.task_id
    INNER JOIN task_attr ta
      ON ta.attr_id = tc.attr_id
    LEFT JOIN content c
      ON c.content_item_id = tc.task_content_id
      AND c.content_type_id = 2
    RIGHT JOIN lesson l
      ON lt.lesson_id = l.lesson_id
    RIGHT JOIN course_lesson cl
      ON l.lesson_id = cl.lesson_id
    RIGHT JOIN course c1
      ON cl.course_id = c1.course_id
    LEFT JOIN translation t1
      ON t1.content_id = c.content_id
      AND t1.language_code = @language_code
      AND t1.country_code = @country_code
  WHERE tc.version_id IN (SELECT DISTINCT
      version_id
    FROM tmp_tbl_versionlist)
  AND lt.lesson_id = @lesson_id
  AND IF(tt.type_id = 10
  AND c1.code = 'DDT', t1.translation_id IS NOT NULL, TRUE)
  ORDER BY tc.task_content_id;

  SELECT
    lt.task_id,
    ta.`group`,
    TA.type,
    CASE WHEN t1.value IS NULL OR
        t1.value = '' THEN tc.value ELSE t1.value END AS 'value',
    c.content_id,
    TC.task_group_id,
    tc.version_id,
    tc.attr_id
  FROM task_content tc
    INNER JOIN task_group tg
      ON tc.task_group_id = tg.task_group_id
    INNER JOIN task t
      ON t.task_id = tg.task_id
    INNER JOIN task_type tt
      ON tt.type_id = t.type_id
    INNER JOIN lock_type lt1
      ON lt1.lock_type_id = t.lock_type
    INNER JOIN lesson_task lt
      ON lt.task_id = t.task_id
    INNER JOIN task_attr ta
      ON ta.attr_id = tc.attr_id
    LEFT JOIN content c
      ON c.content_item_id = tc.task_content_id
      AND c.content_type_id = 2
    RIGHT JOIN lesson l
      ON lt.lesson_id = l.lesson_id
    RIGHT JOIN course_lesson cl
      ON l.lesson_id = cl.lesson_id
    RIGHT JOIN course c1
      ON cl.course_id = c1.course_id
    LEFT JOIN translation t1
      ON t1.content_id = c.content_id
      AND t1.language_code = @language_code
      AND t1.country_code = @country_code
  WHERE tc.version_id IN (SELECT DISTINCT
      version_id
    FROM tmp_tbl_versionlist)
  AND lt.lesson_id = @lesson_id
  AND IF(tt.type_id = 10
  AND c1.code = 'DDT', t1.translation_id IS NOT NULL, TRUE)
  ORDER BY lt._order, tg._order, tc.task_group_id, ta.`group`, ta.type, ta._order, tc.attr_id, tc.version_id;



  SELECT
    td.task_id,
    d.term,
    d.selector,
    t1.value
  FROM task_dictionary td
    INNER JOIN dictionary d
      ON td.dictionary_id = d.term_id
    LEFT JOIN content c
      ON c.content_item_id = td.task_dictionary_id
      AND c.content_type_id = 3
    LEFT JOIN translation t1
      ON t1.content_id = c.content_id
      AND t1.language_code = @language_code
      AND t1.country_code = @country_code
  WHERE td.task_id IN (SELECT DISTINCT
      lt.task_id
    FROM lesson_task lt
    WHERE lt.lesson_id = @lesson_id);

END