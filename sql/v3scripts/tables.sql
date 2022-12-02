--
-- Create table `version`
--
CREATE TABLE version (
  id int(11) NOT NULL AUTO_INCREMENT,
  name varchar(50) NOT NULL,
  code varchar(10) NOT NULL,
  PRIMARY KEY (id)
)
--
-- Create column `version_id` on table `lesson`
--
ALTER TABLE lesson 
  ADD COLUMN version_id INT(11) DEFAULT NULL;

INSERT INTO version(id, name, code) VALUES
(1, 'Essential', 'ES'),
(2, 'Express 1', 'ES1'),
(2, 'Express 2', 'ES2'),
(2, 'Express 3', 'ES3'),
(2, 'Express 4', 'ES4'),
(2, 'Express 5', 'ES5'),
(2, 'Express 6', 'ES6');