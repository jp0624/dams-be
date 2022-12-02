-- Unique constraints
ALTER TABLE task_dictionary 
  ADD UNIQUE INDEX UK_task_dictionary(task_id, dictionary_id);