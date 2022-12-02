SET NAMES 'utf8';

--
-- Set default database
--
USE USE dams_schema_int1xxxxxxxxxxxxxxxxxxxxxxx;

--
-- Create index `UK_translation` on table `translation`
--
ALTER TABLE translation 
  ADD UNIQUE INDEX UK_translation(content_id, type_id, language_code, country_code);