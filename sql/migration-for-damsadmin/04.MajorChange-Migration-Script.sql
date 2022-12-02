USE dams_schema_int1xxxxxxxxxxxxxxxxxxxxxxx;

INSERT INTO content (content_type_id, content_item_id) SELECT 3, task_dictionary_id FROM task_dictionary td;

INSERT INTO content (content_type_id, content_item_id) SELECT 2, task_content_id FROM task_content tc;

-- Rename COLUMNS in task conten content_id to content_id1

-- Rename COLUMNS in translation item_id to item_id1

SELECT c.content_id, c.content_item_id, t.item_id, tc.content_id, tc.task_content_id FROM 
  translation t 
  INNER JOIN task_content tc
  ON t.item_id = tc.content_id
  INNER JOIN content c 
  ON c.content_item_id = tc.task_content_id AND c.content_type_id = 2;


--
-- Create column `content_id` on table `translation`
--
ALTER TABLE translation 
  ADD COLUMN content_id INT(11) DEFAULT NULL;


-- After verification remove the 2 columns which we renamed
-- Now run the migration script 
UPDATE translation t 
  INNER JOIN task_content tc
  ON t.item_id = tc.content_id
  INNER JOIN content c 
  ON c.content_item_id = tc.task_content_id AND c.content_type_id = 2
  SET t.content_id = c.content_id;


UPDATE translation t 
  INNER JOIN task_dictionary td
  ON t.item_id = td.content_id
  INNER JOIN content c 
  ON c.content_item_id = td.task_dictionary_id AND c.content_type_id = 3
  SET t.content_id = c.content_id;