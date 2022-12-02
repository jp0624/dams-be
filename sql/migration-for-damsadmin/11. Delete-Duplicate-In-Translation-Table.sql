USE dams_schema_int1xxxxxxxxxxxxxxxxxxxxxxx;
-- Delete Duplicate records

DELETE FROM translation WHERE CONTENT_ID IS NULL; 

DELETE t1 FROM translation t1 INNER JOIN translation t2 
  WHERE t1.translation_id < t2.translation_id AND  t1.language_code = t2.language_code AND t1.country_code = t2.country_code AND t1.type_id= t2.type_id AND t1.content_id= t2.content_id;
