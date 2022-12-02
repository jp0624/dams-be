USE dams_schema_int1xxxxxxxxxxxxxxxxxxxxxxx;
--
-- Create table `content`
--
CREATE TABLE IF NOT EXISTS content (
  content_id INT(11) NOT NULL AUTO_INCREMENT,
  content_type_id TINYINT(3) DEFAULT NULL,
  content_item_id INT(11) NOT NULL,
  PRIMARY KEY (content_id)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_unicode_ci;
