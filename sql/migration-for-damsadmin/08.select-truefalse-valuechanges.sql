-- Reset all 1 to 0 (false)
-- Reset all 2 to 1 (true)
UPDATE task_content tc
  INNER JOIN task_group tg ON tg.task_group_id = tc.task_group_id
  INNER JOIN task_attr ta ON ta.attr_id = tc.attr_id  
  SET value = '0' 
  WHERE ta.attr_type_id = 6 AND tc.value = '1';

UPDATE task_content tc
  INNER JOIN task_group tg ON tg.task_group_id = tc.task_group_id
  INNER JOIN task_attr ta ON ta.attr_id = tc.attr_id  
  SET value = '1' 
  WHERE ta.attr_type_id = 6 AND tc.value = '2';

UPDATE task_content tc
  INNER JOIN task_group tg ON tg.task_group_id = tc.task_group_id
  INNER JOIN task_attr ta ON ta.attr_id = tc.attr_id  
  SET value = '1' 
  WHERE ta.attr_type_id = 6 AND (tc.value = 'true' OR tc.value = 'True');

UPDATE task_content tc
  INNER JOIN task_group tg ON tg.task_group_id = tc.task_group_id
  INNER JOIN task_attr ta ON ta.attr_id = tc.attr_id  
  SET value = '0' 
  WHERE ta.attr_type_id = 6 AND (tc.value = 'false' OR tc.value = 'False');