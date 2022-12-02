CREATE DEFINER = 'root'@'localhost'

PROCEDURE copyLesson(IN oldLessonId int(11), IN newLessonId int(11))
PROCEDURE dams_schema.copyLesson(IN oldLessonId int(11), IN newLessonId int(11))

BEGIN
  SELECT
    @oldlessonid := oldLessonId;
  SELECT
    @newLessonId := newLessonId;
  BEGIN
    DECLARE taskdone int DEFAULT FALSE;

    DECLARE o_task_id int(11);
    DECLARE o_var_type_id int(5);
    DECLARE o_status_id int(5);
    DECLARE o_task_name varchar(25);
    DECLARE o_description varchar(1255);
    DECLARE o_lock_type int(5);
    DECLARE o_lock_time int(25);
    DECLARE o_heading varchar(45);
    DECLARE o_display_main tinyint(1);
    DECLARE o_display_next tinyint(1);
    DECLARE o_display_innav tinyint(1);
    DECLARE o_order int(3);
    DECLARE o_menu_display int(1);
    DECLARE o_section_marker int(1);

    DECLARE task_list CURSOR FOR

    SELECT DISTINCT
      t.task_id,
      t.type_id,
      t.status_id,
      t.name,
      t.description,
      t.lock_type,
      t.lock_time,
      t.heading,
      t.display_main,
      t.display_next,
      t.display_innav,
      lt._order,
      lt.menu_display,
      lt.section_marker
    FROM lesson l
      INNER JOIN lesson_task lt
        ON l.lesson_id = lt.lesson_id
      INNER JOIN task AS t
        ON t.task_id = lt.task_id
    WHERE l.lesson_id = @oldlessonid;



    DECLARE CONTINUE HANDLER FOR NOT FOUND SET taskdone = TRUE;

    OPEN task_list;

  read_task_loop:

    LOOP
      FETCH task_list INTO o_task_id, o_var_type_id, o_status_id, o_task_name, o_description, o_lock_type, o_lock_time,
      o_heading, o_display_main, o_display_next, o_display_innav, o_order, o_menu_display, o_section_marker;

      IF taskdone THEN
        LEAVE read_task_loop;
        CLOSE task_list;
      END IF;

      INSERT INTO task (type_id, status_id, name, description, lock_type, lock_time, heading, display_main, display_next, display_innav)
        VALUES (o_var_type_id, o_status_id, o_task_name, o_description, o_lock_type, o_lock_time, o_heading, o_display_main, o_display_next, o_display_innav);

      SET @taskId = LAST_INSERT_ID();

      SELECT
        @taskId;


      INSERT INTO lesson_task (lesson_id, task_id, _order, menu_display, section_marker)
        VALUES (@newLessonId, @taskId, o_order, o_menu_display, o_section_marker);


      BEGIN
        DECLARE taskgroupdone int DEFAULT FALSE;

        DECLARE o_task_group_id int(11);
        DECLARE o_task_type_attr_group_id int(5);
        DECLARE o_taskgroupOrder int(5);

        DECLARE task_group_list CURSOR FOR


        SELECT
          task_group_id,
          task_type_attr_group_id,
          _order
        FROM task_group
        WHERE task_id = o_task_id;

        DECLARE CONTINUE HANDLER FOR NOT FOUND SET taskgroupdone = TRUE;

        OPEN task_group_list;

      task_group_list_loop:

        LOOP
          FETCH task_group_list INTO o_task_group_id, o_task_type_attr_group_id, o_taskgroupOrder;

          SET
          @old_task_group_id = o_task_group_id;
          IF taskgroupdone THEN
            LEAVE task_group_list_loop;
            CLOSE task_group_list;
          END IF;

          INSERT INTO task_group (task_id, task_type_attr_group_id, _order)
            VALUES (@taskId, o_task_type_attr_group_id, o_taskgroupOrder);

          SET @task_group_id = LAST_INSERT_ID();

          SELECT
            @task_group_id;

          -- Delete duplicate content records
          DELETE c1
            FROM content c1, content c2
          WHERE c1.content_id > c2.content_id
            AND c1.content_item_id = c2.content_item_id;

          BEGIN
            DECLARE taskcontentdone int DEFAULT FALSE;
            DECLARE o_content_id int(11);
            DECLARE o_task_content_id int(11);
            DECLARE o_attr_id int(11);
            DECLARE o_value text;
            DECLARE o_version_id int(11);
            DECLARE o_task_group_id int(11);

            DECLARE task_content_list CURSOR FOR

            SELECT
              c.content_id,
              tc.task_content_id,
              tc.attr_id,
              tc.`value`,
              tc.version_id,
              tc.task_group_id
            FROM task_content tc
              INNER JOIN content c
                ON c.content_item_id = tc.task_content_id
            WHERE tc.task_group_id = @old_task_group_id
            AND c.content_type_id = 2
            AND c.content_id IS NOT NULL;

            DECLARE CONTINUE HANDLER FOR NOT FOUND SET taskcontentdone = TRUE;

            OPEN task_content_list;

          read_taskcontent_loop:

            LOOP
              FETCH task_content_list INTO o_content_id, o_task_content_id, o_attr_id, o_value, o_version_id, o_task_group_id;

              IF taskcontentdone THEN
                LEAVE read_taskcontent_loop;
                CLOSE task_content_list;
              END IF;

              INSERT INTO task_content (task_group_id, attr_id, `value`, version_id)
                VALUES (@task_group_id, o_attr_id, o_value, o_version_id);

              SET @task_content = LAST_INSERT_ID();

              INSERT INTO content (content_type_id, content_item_id)
                VALUES (2, @task_content);

              SET @content_id = LAST_INSERT_ID();

              BEGIN
                DECLARE translationdone int DEFAULT FALSE;
                DECLARE o_t_translation_id int(11);
                DECLARE o_t_type_id int(11);
                DECLARE o_t_content_id int(11);
                DECLARE o_t_value text;
                DECLARE o_t_language_code varchar(500);
                DECLARE o_t_country_code varchar(500);


                DECLARE translation_list CURSOR FOR

                SELECT
                  t.translation_id,
                  t.type_id,
                  t.content_id,
                  t.value,
                  t.language_code,
                  t.country_code
                FROM translation t
                WHERE t.content_id = o_content_id;

                DECLARE CONTINUE HANDLER FOR NOT FOUND SET translationdone = TRUE;

                OPEN translation_list;

              read_translation_loop:

                LOOP
                  FETCH translation_list INTO o_t_translation_id, o_t_type_id, o_t_content_id, o_t_value, o_t_language_code, o_t_country_code;

                  IF translationdone THEN
                    LEAVE read_translation_loop;
                    CLOSE translation_list;
                  END IF;
<<<<<<< HEAD
                  SELECT 'Content Translation'; 
                  SELECT o_t_type_id, @content_id, o_t_value, o_t_language_code, o_t_country_code;
=======

                  --  'Content Translation';
>>>>>>> feature/dams-be-v3-versionChanges

                  INSERT INTO translation (type_id, content_id, value, language_code, country_code)
                    VALUES (o_t_type_id, @content_id, o_t_value, o_t_language_code, o_t_country_code);

                END LOOP read_translation_loop;
<<<<<<< HEAD
=======
                COMMIT;
>>>>>>> feature/dams-be-v3-versionChanges
              END;
            END LOOP read_taskcontent_loop;
          END;

        END LOOP task_group_list_loop;
      END;
      BEGIN
        DECLARE dictionarydone int DEFAULT FALSE;
        DECLARE o_d_content_id int(11);
        DECLARE o_d_task_dictionary_id int(11);
        DECLARE o_d_content_id1 varchar(100);
        DECLARE o_d_task_id int(11);
        DECLARE o_d_dictionary_id int(11);

        DECLARE dictionary_list CURSOR FOR

        SELECT
          c.content_id,
          td.task_dictionary_id,
          td.content_id1,
          td.task_id,
          td.dictionary_id
        FROM task_dictionary td
          INNER JOIN content c
            ON c.content_item_id = td.task_dictionary_id
        WHERE td.task_id = o_task_id
        AND c.content_type_id = 3
        AND c.content_id IS NOT NULL;

        DECLARE CONTINUE HANDLER FOR NOT FOUND SET dictionarydone = TRUE;

        OPEN dictionary_list;

      read_dictionary_loop:

        LOOP
          FETCH dictionary_list INTO o_d_content_id, o_d_task_dictionary_id, o_d_content_id1, o_d_task_id, o_d_dictionary_id;

          IF dictionarydone THEN
            LEAVE read_dictionary_loop;
            CLOSE dictionary_list;
          END IF;

          INSERT INTO task_dictionary (content_id1, task_id, dictionary_id)
            VALUES (CONCAT(@taskId, '-', o_d_dictionary_id), @taskId, o_d_dictionary_id);

          SET @d_task_dictionary_id = LAST_INSERT_ID();

          INSERT INTO content (content_type_id, content_item_id)
            VALUES (3, @d_task_dictionary_id);

          SET @d_content_id = LAST_INSERT_ID();

          BEGIN
            DECLARE d_translationdone int DEFAULT FALSE;
            DECLARE o_d_t_translation_id int(11);
            DECLARE o_d_t_type_id int(11);
            DECLARE o_d_t_content_id int(11);
            DECLARE o_d_t_value text;
            DECLARE o_d_t_language_code varchar(500);
            DECLARE o_d_t_country_code varchar(500);


            DECLARE d_translation_list CURSOR FOR

            SELECT
              t.translation_id,
              t.type_id,
              t.content_id,
              t.value,
              t.language_code,
              t.country_code
            FROM translation t
            WHERE t.content_id = o_d_content_id;

            DECLARE CONTINUE HANDLER FOR NOT FOUND SET d_translationdone = TRUE;

            OPEN d_translation_list;

          read_d_translation_loop:

            LOOP
              FETCH d_translation_list INTO o_d_t_translation_id, o_d_t_type_id, o_d_t_content_id, o_d_t_value, o_d_t_language_code, o_d_t_country_code;

              IF d_translationdone THEN
                LEAVE read_d_translation_loop;
                CLOSE d_translation_list;
              END IF;
<<<<<<< HEAD
              
              SELECT 'Dictionary Translation'; 
              SELECT o_d_t_type_id, @d_content_id, o_d_t_value, o_d_t_language_code, o_d_t_country_code;
=======

              --  'Dictionary Translation';
>>>>>>> feature/dams-be-v3-versionChanges
              INSERT INTO translation (type_id, content_id, value, language_code, country_code)
                VALUES (o_d_t_type_id, @d_content_id, o_d_t_value, o_d_t_language_code, o_d_t_country_code);

            END LOOP read_d_translation_loop;
          END;
        END LOOP read_dictionary_loop;
      END;
    END LOOP read_task_loop;
  END;
END