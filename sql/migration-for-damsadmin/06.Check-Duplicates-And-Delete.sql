-- Check for duplicate records
SELECT task_id, dictionary_id, COUNT('*') 'counter' FROM task_dictionary GROUP BY task_id, dictionary_id HAVING counter>1;

SELECT * FROM task_dictionary WHERE task_id IN (SELECT task_id FROM task_dictionary GROUP BY task_id, dictionary_id HAVING COUNT('*')>1)
AND dictionary_id IN (SELECT dictionary_id FROM task_dictionary GROUP BY task_id, dictionary_id HAVING COUNT('*')>1) ORDER BY task_id, dictionary_id;

-- If any record found in the above 2 query then execute the below DELETE statement else skip the DELETE and run the last command
DELETE td1 FROM task_dictionary td1
        INNER JOIN
    task_dictionary td2 
WHERE
    td1.task_dictionary_id < td2.task_dictionary_id AND td1.task_id = td2.task_id AND td1.dictionary_id = td2.dictionary_id;