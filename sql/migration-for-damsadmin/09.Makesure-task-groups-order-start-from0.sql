-- SQL to start the order from 0, if any

-- Correct data : Order starts from 0,1,2...
SELECT DISTINCT tg.task_id FROM task_group tg 
  WHERE tg._order = 0;

-- Incorrect data : Order not start with 0.
SELECT DISTINCT task_id FROM task_group WHERE task_id NOT IN (
SELECT DISTINCT tg.task_id FROM task_group tg 
  WHERE tg._order = 0 )
ORDER BY task_id, _order;

-- Run the update query if any reconds found in the below SELECT command. we may run the below query and update statement multiple times until no records found in the SELECT query
SELECT * FROM task_group
    WHERE task_id IN 
 ( 
    SELECT task_id FROM 
    (
        SELECT DISTINCT tg1.task_id FROM task_group tg1 
        WHERE tg1.task_id NOT IN 
        ( 
            SELECT DISTINCT tg2.task_id FROM task_group tg2 WHERE tg2._order = 0 
        )
    ) AS recordstoupdate
 );

-- UPDATE
UPDATE `task_group` 
  SET _order = _order-1  
  WHERE task_id IN 
 ( 
    SELECT task_id FROM 
    (
        SELECT DISTINCT tg1.task_id FROM task_group tg1 
        WHERE tg1.task_id NOT IN 
        ( 
            SELECT DISTINCT tg2.task_id FROM task_group tg2 WHERE tg2._order = 0 
        )
    ) AS recordstoupdate
 );

