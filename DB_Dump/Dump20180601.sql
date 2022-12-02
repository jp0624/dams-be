-- MySQL dump 10.13  Distrib 8.0.11, for Win64 (x86_64)
--
-- Host: localhost    Database: dams_schema
-- ------------------------------------------------------
-- Server version	8.0.11

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `alert`
--

DROP TABLE IF EXISTS `alert`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `alert` (
  `alert_id` tinyint(3) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `class` varchar(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`alert_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alert`
--

LOCK TABLES `alert` WRITE;
INSERT INTO `alert` VALUES (1,'Normal','UUU','normal',0),(3,'demo2','desc2','',1);
UNLOCK TABLES;

--
-- Table structure for table `content_group`
--

DROP TABLE IF EXISTS `content_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `content_group` (
  `group_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `content_group`
--

LOCK TABLES `content_group` WRITE;
INSERT INTO `content_group` VALUES (1,'Measurement'),(2,'Device'),(3,'Side of Road');
UNLOCK TABLES;

--
-- Table structure for table `content_type`
--

DROP TABLE IF EXISTS `content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `content_type` (
  `type_id` tinyint(3) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `db_table` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `content_type`
--

LOCK TABLES `content_type` WRITE;
INSERT INTO `content_type` VALUES (1,'User Table','user'),(2,'Task Content','task_content'),(3,'Dictionary','dictionary');
UNLOCK TABLES;

--
-- Table structure for table `content_version`
--

DROP TABLE IF EXISTS `content_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `content_version` (
  `version_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `icon` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `priority` int(3) DEFAULT NULL,
  `device` int(3) DEFAULT NULL,
  PRIMARY KEY (`version_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `content_version`
--

LOCK TABLES `content_version` WRITE;
INSERT INTO `content_version` VALUES (1,'default','accessibility',1,1),(2,'metric','compare_arrows',2,1),(3,'imperial','compare_arrows',2,1),(4,'mixed [imperial/metric]','compare_arrows',2,1),(5,'left side of road','directions_car',3,1),(6,'right side of road','directions_car',3,1),(7,'mobile','important_devices',2,2),(8,'mobile - imperial','important_devices',2,2),(9,'mobile - metric','important_devices',2,2),(10,'moble - mixed [imperial/metric]','important_devices',2,2);
UNLOCK TABLES;

--
-- Table structure for table `content_version_category`
--

DROP TABLE IF EXISTS `content_version_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `content_version_category` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `content_version_category`
--

LOCK TABLES `content_version_category` WRITE;
INSERT INTO `content_version_category` VALUES (1,'Measurement'),(2,'Mobile'),(3,'Side of Road');
UNLOCK TABLES;

--
-- Table structure for table `content_version_group`
--

DROP TABLE IF EXISTS `content_version_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `content_version_group` (
  `group_id` int(11) NOT NULL AUTO_INCREMENT,
  `version_id` int(11) DEFAULT NULL,
  `property_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `content_version_group`
--

LOCK TABLES `content_version_group` WRITE;
INSERT INTO `content_version_group` VALUES (1,1,1),(2,2,6),(3,3,5),(4,4,5),(5,4,6),(6,5,4),(7,6,3),(8,7,2),(9,8,2),(10,8,5),(11,9,2),(12,9,6),(13,10,5),(14,10,6),(15,10,2);
UNLOCK TABLES;

--
-- Table structure for table `content_version_property`
--

DROP TABLE IF EXISTS `content_version_property`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `content_version_property` (
  `property_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `priority` int(2) DEFAULT '1',
  PRIMARY KEY (`property_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `content_version_property`
--

LOCK TABLES `content_version_property` WRITE;
INSERT INTO `content_version_property` VALUES (1,'Desktop',2,1),(2,'Mobile',2,1),(3,'Right Side',3,1),(4,'Left Side',3,1),(5,'Imperial',1,1),(6,'Metric',1,1);
UNLOCK TABLES;

--
-- Table structure for table `country`
--

DROP TABLE IF EXISTS `country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `country` (
  `country_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` char(52) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `code` char(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `code2` char(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `last_update` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `local_name` char(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `continent` char(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `region` char(26) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `surface_area` float(10,2) DEFAULT NULL,
  `indep_year` smallint(6) DEFAULT NULL,
  `population` int(11) DEFAULT NULL,
  `life_expectancy` float(3,1) DEFAULT NULL,
  `gnp` float(10,2) DEFAULT NULL,
  `gnp_old` float(10,2) DEFAULT NULL,
  `government_form` char(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `head_of_state` char(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`country_id`)
) ENGINE=InnoDB AUTO_INCREMENT=263 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `country`
--

LOCK TABLES `country` WRITE;
INSERT INTO `country` VALUES (1,'Aruba','AW','ABW',NULL,'Aruba','North America','Caribbean',193.00,NULL,103000,78.4,828.00,793.00,'Nonmetropolitan Territory of The Netherlands','Beatrix'),(2,'Afghanistan','AF','AFG',NULL,'Afganistan/Afqanestan','Asia','Southern and Central Asia',652090.00,1919,22720000,45.9,5976.00,NULL,'Islamic Emirate','Mohammad Omar'),(3,'Angola','AO','AGO',NULL,'Angola','Africa','Central Africa',1246700.00,1975,12878000,38.3,6648.00,7984.00,'Republic','JosÃ© Eduardo dos Santos'),(4,'Anguilla','AI','AIA',NULL,'Anguilla','North America','Caribbean',96.00,NULL,8000,76.1,63.20,NULL,'Dependent Territory of the UK','Elisabeth II'),(5,'Albania','AL','ALB',NULL,'ShqipÃ«ria','Europe','Southern Europe',28748.00,1912,3401200,71.6,3205.00,2500.00,'Republic','Rexhep Mejdani'),(6,'Andorra','AD','AND',NULL,'Andorra','Europe','Southern Europe',468.00,1278,78000,83.5,1630.00,NULL,'Parliamentary Coprincipality',''),(7,'Netherlands Antilles','AN','ANT',NULL,'Nederlandse Antillen','North America','Caribbean',800.00,NULL,217000,74.7,1941.00,NULL,'Nonmetropolitan Territory of The Netherlands','Beatrix'),(8,'United Arab Emirates','AE','ARE',NULL,'Al-Imarat al-Â´Arabiya al-Muttahida','Asia','Middle East',83600.00,1971,2441000,74.1,37966.00,36846.00,'Emirate Federation','Zayid bin Sultan al-Nahayan'),(9,'Argentina','AR','ARG',NULL,'Argentina','South America','South America',2780400.00,1816,37032000,75.1,340238.00,323310.00,'Federal Republic','Fernando de la RÃºa'),(10,'Armenia','AM','ARM',NULL,'Hajastan','Asia','Middle East',29800.00,1991,3520000,66.4,1813.00,1627.00,'Republic','Robert KotÂšarjan'),(11,'American Samoa','AS','ASM',NULL,'Amerika Samoa','Oceania','Polynesia',199.00,NULL,68000,75.1,334.00,NULL,'US Territory','George W. Bush'),(12,'Antarctica','AQ','ATA',NULL,'Â–','Antarctica','Antarctica',13120000.00,NULL,0,NULL,0.00,NULL,'Co-administrated',''),(13,'French Southern territories','TF','ATF',NULL,'Terres australes franÃ§aises','Antarctica','Antarctica',7780.00,NULL,0,NULL,0.00,NULL,'Nonmetropolitan Territory of France','Jacques Chirac'),(14,'Antigua and Barbuda','AG','ATG',NULL,'Antigua and Barbuda','North America','Caribbean',442.00,1981,68000,70.5,612.00,584.00,'Constitutional Monarchy','Elisabeth II'),(15,'Australia','AU','AUS',NULL,'Australia','Oceania','Australia and New Zealand',7741220.00,1901,18886000,79.8,351182.00,392911.00,'Constitutional Monarchy, Federation','Elisabeth II'),(16,'Austria','AT','AUT',NULL,'Ã–sterreich','Europe','Western Europe',83859.00,1918,8091800,77.7,211860.00,206025.00,'Federal Republic','Thomas Klestil'),(17,'Azerbaijan','AZ','AZE',NULL,'AzÃ¤rbaycan','Asia','Middle East',86600.00,1991,7734000,62.9,4127.00,4100.00,'Federal Republic','HeydÃ¤r Ã„liyev'),(18,'Burundi','BI','BDI',NULL,'Burundi/Uburundi','Africa','Eastern Africa',27834.00,1962,6695000,46.2,903.00,982.00,'Republic','Pierre Buyoya'),(19,'Belgium','BE','BEL',NULL,'BelgiÃ«/Belgique','Europe','Western Europe',30518.00,1830,10239000,77.8,249704.00,243948.00,'Constitutional Monarchy, Federation','Albert II'),(20,'Benin','BJ','BEN',NULL,'BÃ©nin','Africa','Western Africa',112622.00,1960,6097000,50.2,2357.00,2141.00,'Republic','Mathieu KÃ©rÃ©kou'),(21,'Burkina Faso','BF','BFA',NULL,'Burkina Faso','Africa','Western Africa',274000.00,1960,11937000,46.7,2425.00,2201.00,'Republic','Blaise CompaorÃ©'),(22,'Bangladesh','BD','BGD',NULL,'Bangladesh','Asia','Southern and Central Asia',143998.00,1971,129155000,60.2,32852.00,31966.00,'Republic','Shahabuddin Ahmad'),(23,'Bulgaria','BG','BGR',NULL,'Balgarija','Europe','Eastern Europe',110994.00,1908,8190900,70.9,12178.00,10169.00,'Republic','Petar Stojanov'),(24,'Bahrain','BH','BHR',NULL,'Al-Bahrayn','Asia','Middle East',694.00,1971,617000,73.0,6366.00,6097.00,'Monarchy (Emirate)','Hamad ibn Isa al-Khalifa'),(25,'Bahamas','BS','BHS',NULL,'The Bahamas','North America','Caribbean',13878.00,1973,307000,71.1,3527.00,3347.00,'Constitutional Monarchy','Elisabeth II'),(26,'Bosnia and Herzegovina','BA','BIH',NULL,'Bosna i Hercegovina','Europe','Southern Europe',51197.00,1992,3972000,71.5,2841.00,NULL,'Federal Republic','Ante Jelavic'),(27,'Belarus','BY','BLR',NULL,'Belarus','Europe','Eastern Europe',207600.00,1991,10236000,68.0,13714.00,NULL,'Republic','Aljaksandr LukaÂšenka'),(28,'Belize','BZ','BLZ',NULL,'Belize','North America','Central America',22696.00,1981,241000,70.9,630.00,616.00,'Constitutional Monarchy','Elisabeth II'),(29,'Bermuda','BM','BMU',NULL,'Bermuda','North America','North America',53.00,NULL,65000,76.9,2328.00,2190.00,'Dependent Territory of the UK','Elisabeth II'),(30,'Bolivia','BO','BOL',NULL,'Bolivia','South America','South America',1098581.00,1825,8329000,63.7,8571.00,7967.00,'Republic','Hugo BÃ¡nzer SuÃ¡rez'),(31,'Brazil','BR','BRA',NULL,'Brasil','South America','South America',8547403.00,1822,170115000,62.9,776739.00,804108.00,'Federal Republic','Fernando Henrique Cardoso'),(32,'Barbados','BB','BRB',NULL,'Barbados','North America','Caribbean',430.00,1966,270000,73.0,2223.00,2186.00,'Constitutional Monarchy','Elisabeth II'),(33,'Brunei','BN','BRN',NULL,'Brunei Darussalam','Asia','Southeast Asia',5765.00,1984,328000,73.6,11705.00,12460.00,'Monarchy (Sultanate)','Haji Hassan al-Bolkiah'),(34,'Bhutan','BT','BTN',NULL,'Druk-Yul','Asia','Southern and Central Asia',47000.00,1910,2124000,52.4,372.00,383.00,'Monarchy','Jigme Singye Wangchuk'),(35,'Bouvet Island','BV','BVT',NULL,'BouvetÃ¸ya','Antarctica','Antarctica',59.00,NULL,0,NULL,0.00,NULL,'Dependent Territory of Norway','Harald V'),(36,'Botswana','BW','BWA',NULL,'Botswana','Africa','Southern Africa',581730.00,1966,1622000,39.3,4834.00,4935.00,'Republic','Festus G. Mogae'),(37,'Central African Republic','CF','CAF',NULL,'Centrafrique/BÃª-AfrÃ®ka','Africa','Central Africa',622984.00,1960,3615000,44.0,1054.00,993.00,'Republic','Ange-FÃ©lix PatassÃ©'),(38,'Canada','CA','CAN',NULL,'Canada','North America','North America',9970610.00,1867,31147000,79.4,598862.00,625626.00,'Constitutional Monarchy, Federation','Elisabeth II'),(39,'Cocos (Keeling) Islands','CC','CCK',NULL,'Cocos (Keeling) Islands','Oceania','Australia and New Zealand',14.00,NULL,600,NULL,0.00,NULL,'Territory of Australia','Elisabeth II'),(40,'Switzerland','CH','CHE',NULL,'Schweiz/Suisse/Svizzera/Svizra','Europe','Western Europe',41284.00,1499,7160400,79.6,264478.00,256092.00,'Federation','Adolf Ogi'),(41,'Chile','CL','CHL',NULL,'Chile','South America','South America',756626.00,1810,15211000,75.7,72949.00,75780.00,'Republic','Ricardo Lagos Escobar'),(42,'China','CN','CHN',NULL,'Zhongquo','Asia','Eastern Asia',9572900.00,-1523,1277558000,71.4,982268.00,917719.00,'People\'sRepublic','Jiang Zemin'),(43,'CÃ´te dÂ’Ivoire','CI','CIV',NULL,'CÃ´te dÂ’Ivoire','Africa','Western Africa',322463.00,1960,14786000,45.2,11345.00,10285.00,'Republic','Laurent Gbagbo'),(44,'Cameroon','CM','CMR',NULL,'Cameroun/Cameroon','Africa','Central Africa',475442.00,1960,15085000,54.8,9174.00,8596.00,'Republic','Paul Biya'),(45,'Congo, The Democratic Republic of the','CD','COD',NULL,'RÃ©publique DÃ©mocratique du Congo','Africa','Central Africa',2344858.00,1960,51654000,48.8,6964.00,2474.00,'Republic','Joseph Kabila'),(46,'Congo','CG','COG',NULL,'Congo','Africa','Central Africa',342000.00,1960,2943000,47.4,2108.00,2287.00,'Republic','Denis Sassou-Nguesso'),(47,'Cook Islands','CK','COK',NULL,'The Cook Islands','Oceania','Polynesia',236.00,NULL,20000,71.1,100.00,NULL,'Nonmetropolitan Territory of New Zealand','Elisabeth II'),(48,'Colombia','CO','COL',NULL,'Colombia','South America','South America',1138914.00,1810,42321000,70.3,102896.00,105116.00,'Republic','AndrÃ©s Pastrana Arango'),(49,'Comoros','KM','COM',NULL,'Komori/Comores','Africa','Eastern Africa',1862.00,1975,578000,60.0,4401.00,4361.00,'Republic','Azali Assoumani'),(50,'Cape Verde','CV','CPV',NULL,'Cabo Verde','Africa','Western Africa',4033.00,1975,428000,68.9,435.00,420.00,'Republic','AntÃ³nio Mascarenhas Monteiro'),(51,'Costa Rica','CR','CRI',NULL,'Costa Rica','North America','Central America',51100.00,1821,4023000,75.8,10226.00,9757.00,'Republic','Miguel Ãngel RodrÃ­guez EcheverrÃ­a'),(52,'Cuba','CU','CUB',NULL,'Cuba','North America','Caribbean',110861.00,1902,11201000,76.2,17843.00,18862.00,'Socialistic Republic','Fidel Castro Ruz'),(53,'Christmas Island','CX','CXR',NULL,'Christmas Island','Oceania','Australia and New Zealand',135.00,NULL,2500,NULL,0.00,NULL,'Territory of Australia','Elisabeth II'),(54,'Cayman Islands','KY','CYM',NULL,'Cayman Islands','North America','Caribbean',264.00,NULL,38000,78.9,1263.00,1186.00,'Dependent Territory of the UK','Elisabeth II'),(55,'Cyprus','CY','CYP',NULL,'KÃ½pros/Kibris','Asia','Middle East',9251.00,1960,754700,76.7,9333.00,8246.00,'Republic','Glafkos Klerides'),(56,'Czech Republic','CZ','CZE',NULL,'Â¸esko','Europe','Eastern Europe',78866.00,1993,10278100,74.5,55017.00,52037.00,'Republic','VÃ¡clav Havel'),(57,'Germany','DE','DEU',NULL,'Deutschland','Europe','Western Europe',357022.00,1955,82164700,77.4,2133367.00,2102826.00,'Federal Republic','Johannes Rau'),(58,'Djibouti','DJ','DJI',NULL,'Djibouti/Jibuti','Africa','Eastern Africa',23200.00,1977,638000,50.8,382.00,373.00,'Republic','Ismail Omar Guelleh'),(59,'Dominica','DM','DMA',NULL,'Dominica','North America','Caribbean',751.00,1978,71000,73.4,256.00,243.00,'Republic','Vernon Shaw'),(60,'Denmark','DK','DNK',NULL,'Danmark','Europe','Nordic Countries',43094.00,800,5330000,76.5,174099.00,169264.00,'Constitutional Monarchy','Margrethe II'),(61,'Dominican Republic','DO','DOM',NULL,'RepÃºblica Dominicana','North America','Caribbean',48511.00,1844,8495000,73.2,15846.00,15076.00,'Republic','HipÃ³lito MejÃ­a DomÃ­nguez'),(62,'Algeria','DZ','DZA',NULL,'Al-JazaÂ’ir/AlgÃ©rie','Africa','Northern Africa',2381741.00,1962,31471000,69.7,49982.00,46966.00,'Republic','Abdelaziz Bouteflika'),(63,'Ecuador','EC','ECU',NULL,'Ecuador','South America','South America',283561.00,1822,12646000,71.1,19770.00,19769.00,'Republic','Gustavo Noboa Bejarano'),(64,'Egypt','EG','EGY',NULL,'Misr','Africa','Northern Africa',1001449.00,1922,68470000,63.3,82710.00,75617.00,'Republic','Hosni Mubarak'),(65,'Eritrea','ER','ERI',NULL,'Ertra','Africa','Eastern Africa',117600.00,1993,3850000,55.8,650.00,755.00,'Republic','Isayas Afewerki [Isaias Afwerki]'),(66,'Western Sahara','EH','ESH',NULL,'As-Sahrawiya','Africa','Northern Africa',266000.00,NULL,293000,49.8,60.00,NULL,'Occupied by Marocco','Mohammed Abdel Aziz'),(67,'Spain','ES','ESP',NULL,'EspaÃ±a','Europe','Southern Europe',505992.00,1492,39441700,78.8,553233.00,532031.00,'Constitutional Monarchy','Juan Carlos I'),(68,'Estonia','EE','EST',NULL,'Eesti','Europe','Baltic Countries',45227.00,1991,1439200,69.5,5328.00,3371.00,'Republic','Lennart Meri'),(69,'Ethiopia','ET','ETH',NULL,'YeItyopÂ´iya','Africa','Eastern Africa',1104300.00,-1000,62565000,45.2,6353.00,6180.00,'Republic','Negasso Gidada'),(70,'Finland','FI','FIN',NULL,'Suomi','Europe','Nordic Countries',338145.00,1917,5171300,77.4,121914.00,119833.00,'Republic','Tarja Halonen'),(71,'Fiji Islands','FJ','FJI',NULL,'Fiji Islands','Oceania','Melanesia',18274.00,1970,817000,67.9,1536.00,2149.00,'Republic','Josefa Iloilo'),(72,'Falkland Islands','FK','FLK',NULL,'Falkland Islands','South America','South America',12173.00,NULL,2000,NULL,0.00,NULL,'Dependent Territory of the UK','Elisabeth II'),(73,'France','FR','FRA',NULL,'France','Europe','Western Europe',551500.00,843,59225700,78.8,1424285.00,1392448.00,'Republic','Jacques Chirac'),(74,'Faroe Islands','FO','FRO',NULL,'FÃ¸royar','Europe','Nordic Countries',1399.00,NULL,43000,78.4,0.00,NULL,'Part of Denmark','Margrethe II'),(75,'Micronesia, Federated States of','FM','FSM',NULL,'Micronesia','Oceania','Micronesia',702.00,1990,119000,68.6,212.00,NULL,'Federal Republic','Leo A. Falcam'),(76,'Gabon','GA','GAB',NULL,'Le Gabon','Africa','Central Africa',267668.00,1960,1226000,50.1,5493.00,5279.00,'Republic','Omar Bongo'),(77,'United Kingdom','GB','GBR',NULL,'United Kingdom','Europe','British Islands',242900.00,1066,59623400,77.7,1378330.00,1296830.00,'Constitutional Monarchy','Elisabeth II'),(78,'Georgia','GE','GEO',NULL,'Sakartvelo','Asia','Middle East',69700.00,1991,4968000,64.5,6064.00,5924.00,'Republic','Eduard ÂŠevardnadze'),(79,'Ghana','GH','GHA',NULL,'Ghana','Africa','Western Africa',238533.00,1957,20212000,57.4,7137.00,6884.00,'Republic','John Kufuor'),(80,'Gibraltar','GI','GIB',NULL,'Gibraltar','Europe','Southern Europe',6.00,NULL,25000,79.0,258.00,NULL,'Dependent Territory of the UK','Elisabeth II'),(81,'Guinea','GN','GIN',NULL,'GuinÃ©e','Africa','Western Africa',245857.00,1958,7430000,45.6,2352.00,2383.00,'Republic','Lansana ContÃ©'),(82,'Guadeloupe','GP','GLP',NULL,'Guadeloupe','North America','Caribbean',1705.00,NULL,456000,77.0,3501.00,NULL,'Overseas Department of France','Jacques Chirac'),(83,'Gambia','GM','GMB',NULL,'The Gambia','Africa','Western Africa',11295.00,1965,1305000,53.2,320.00,325.00,'Republic','Yahya Jammeh'),(84,'Guinea-Bissau','GW','GNB',NULL,'GuinÃ©-Bissau','Africa','Western Africa',36125.00,1974,1213000,49.0,293.00,272.00,'Republic','Kumba IalÃ¡'),(85,'Equatorial Guinea','GQ','GNQ',NULL,'Guinea Ecuatorial','Africa','Central Africa',28051.00,1968,453000,53.6,283.00,542.00,'Republic','Teodoro Obiang Nguema Mbasogo'),(86,'Greece','GR','GRC',NULL,'EllÃ¡da','Europe','Southern Europe',131626.00,1830,10545700,78.4,120724.00,119946.00,'Republic','Kostis Stefanopoulos'),(87,'Grenada','GD','GRD',NULL,'Grenada','North America','Caribbean',344.00,1974,94000,64.5,318.00,NULL,'Constitutional Monarchy','Elisabeth II'),(88,'Greenland','GL','GRL',NULL,'Kalaallit Nunaat/GrÃ¸nland','North America','North America',2166090.00,NULL,56000,68.1,0.00,NULL,'Part of Denmark','Margrethe II'),(89,'Guatemala','GT','GTM',NULL,'Guatemala','North America','Central America',108889.00,1821,11385000,66.2,19008.00,17797.00,'Republic','Alfonso Portillo Cabrera'),(90,'French Guiana','GF','GUF',NULL,'Guyane franÃ§aise','South America','South America',90000.00,NULL,181000,76.1,681.00,NULL,'Overseas Department of France','Jacques Chirac'),(91,'Guam','GU','GUM',NULL,'Guam','Oceania','Micronesia',549.00,NULL,168000,77.8,1197.00,1136.00,'US Territory','George W. Bush'),(92,'Guyana','GY','GUY',NULL,'Guyana','South America','South America',214969.00,1966,861000,64.0,722.00,743.00,'Republic','Bharrat Jagdeo'),(93,'Hong Kong','HK','HKG',NULL,'Xianggang/Hong Kong','Asia','Eastern Asia',1075.00,NULL,6782000,79.5,166448.00,173610.00,'Special Administrative Region of China','Jiang Zemin'),(94,'Heard Island and McDonald Islands','HM','HMD',NULL,'Heard and McDonald Islands','Antarctica','Antarctica',359.00,NULL,0,NULL,0.00,NULL,'Territory of Australia','Elisabeth II'),(95,'Honduras','HN','HND',NULL,'Honduras','North America','Central America',112088.00,1838,6485000,69.9,5333.00,4697.00,'Republic','Carlos Roberto Flores FacussÃ©'),(96,'Croatia','HR','HRV',NULL,'Hrvatska','Europe','Southern Europe',56538.00,1991,4473000,73.7,20208.00,19300.00,'Republic','ÂŠtipe Mesic'),(97,'Haiti','HT','HTI',NULL,'HaÃ¯ti/Dayti','North America','Caribbean',27750.00,1804,8222000,49.2,3459.00,3107.00,'Republic','Jean-Bertrand Aristide'),(98,'Hungary','HU','HUN',NULL,'MagyarorszÃ¡g','Europe','Eastern Europe',93030.00,1918,10043200,71.4,48267.00,45914.00,'Republic','Ferenc MÃ¡dl'),(99,'Indonesia','ID','IDN',NULL,'Indonesia','Asia','Southeast Asia',1904569.00,1945,212107000,68.0,84982.00,215002.00,'Republic','Abdurrahman Wahid'),(100,'India','IN','IND',NULL,'Bharat/India','Asia','Southern and Central Asia',3287263.00,1947,1013662000,62.5,447114.00,430572.00,'Federal Republic','Kocheril Raman Narayanan'),(101,'British Indian Ocean Territory','IO','IOT',NULL,'British Indian Ocean Territory','Africa','Eastern Africa',78.00,NULL,0,NULL,0.00,NULL,'Dependent Territory of the UK','Elisabeth II'),(102,'Ireland','IE','IRL',NULL,'Ireland/Ã‰ire','Europe','British Islands',70273.00,1921,3775100,76.8,75921.00,73132.00,'Republic','Mary McAleese'),(103,'Iran','IR','IRN',NULL,'Iran','Asia','Southern and Central Asia',1648195.00,1906,67702000,69.7,195746.00,160151.00,'Islamic Republic','Ali Mohammad Khatami-Ardakani'),(104,'Iraq','IQ','IRQ',NULL,'Al-Â´Iraq','Asia','Middle East',438317.00,1932,23115000,66.5,11500.00,NULL,'Republic','Saddam Hussein al-Takriti'),(105,'Iceland','IS','ISL',NULL,'Ãsland','Europe','Nordic Countries',103000.00,1944,279000,79.4,8255.00,7474.00,'Republic','Ã“lafur Ragnar GrÃ­msson'),(106,'Israel','IL','ISR',NULL,'YisraÂ’el/IsraÂ’il','Asia','Middle East',21056.00,1948,6217000,78.6,97477.00,98577.00,'Republic','Moshe Katzav'),(107,'Italy','IT','ITA',NULL,'Italia','Europe','Southern Europe',301316.00,1861,57680000,79.0,1161755.00,1145372.00,'Republic','Carlo Azeglio Ciampi'),(108,'Jamaica','JM','JAM',NULL,'Jamaica','North America','Caribbean',10990.00,1962,2583000,75.2,6871.00,6722.00,'Constitutional Monarchy','Elisabeth II'),(109,'Jordan','JO','JOR',NULL,'Al-Urdunn','Asia','Middle East',88946.00,1946,5083000,77.4,7526.00,7051.00,'Constitutional Monarchy','Abdullah II'),(110,'Japan','JP','JPN',NULL,'Nihon/Nippon','Asia','Eastern Asia',377829.00,-660,126714000,80.7,3787042.00,4192638.00,'Constitutional Monarchy','Akihito'),(111,'Kazakstan','KZ','KAZ',NULL,'Qazaqstan','Asia','Southern and Central Asia',2724900.00,1991,16223000,63.2,24375.00,23383.00,'Republic','Nursultan Nazarbajev'),(112,'Kenya','KE','KEN',NULL,'Kenya','Africa','Eastern Africa',580367.00,1963,30080000,48.0,9217.00,10241.00,'Republic','Daniel arap Moi'),(113,'Kyrgyzstan','KG','KGZ',NULL,'Kyrgyzstan','Asia','Southern and Central Asia',199900.00,1991,4699000,63.4,1626.00,1767.00,'Republic','Askar Akajev'),(114,'Cambodia','KH','KHM',NULL,'KÃ¢mpuchÃ©a','Asia','Southeast Asia',181035.00,1953,11168000,56.5,5121.00,5670.00,'Constitutional Monarchy','Norodom Sihanouk'),(115,'Kiribati','KI','KIR',NULL,'Kiribati','Oceania','Micronesia',726.00,1979,83000,59.8,40.70,NULL,'Republic','Teburoro Tito'),(116,'Saint Kitts and Nevis','KN','KNA',NULL,'Saint Kitts and Nevis','North America','Caribbean',261.00,1983,38000,70.7,299.00,NULL,'Constitutional Monarchy','Elisabeth II'),(117,'South Korea','KR','KOR',NULL,'Taehan MinÂ’guk (Namhan)','Asia','Eastern Asia',99434.00,1948,46844000,74.4,320749.00,442544.00,'Republic','Kim Dae-jung'),(118,'Kuwait','KW','KWT',NULL,'Al-Kuwayt','Asia','Middle East',17818.00,1961,1972000,76.1,27037.00,30373.00,'Constitutional Monarchy (Emirate)','Jabir al-Ahmad al-Jabir al-Sabah'),(119,'Laos','LA','LAO',NULL,'Lao','Asia','Southeast Asia',236800.00,1953,5433000,53.1,1292.00,1746.00,'Republic','Khamtay Siphandone'),(120,'Lebanon','LB','LBN',NULL,'Lubnan','Asia','Middle East',10400.00,1941,3282000,71.3,17121.00,15129.00,'Republic','Ã‰mile Lahoud'),(121,'Liberia','LR','LBR',NULL,'Liberia','Africa','Western Africa',111369.00,1847,3154000,51.0,2012.00,NULL,'Republic','Charles Taylor'),(122,'Libyan Arab Jamahiriya','LY','LBY',NULL,'Libiya','Africa','Northern Africa',1759540.00,1951,5605000,75.5,44806.00,40562.00,'Socialistic State','Muammar al-Qadhafi'),(123,'Saint Lucia','LC','LCA',NULL,'Saint Lucia','North America','Caribbean',622.00,1979,154000,72.3,571.00,NULL,'Constitutional Monarchy','Elisabeth II'),(124,'Liechtenstein','LI','LIE',NULL,'Liechtenstein','Europe','Western Europe',160.00,1806,32300,78.8,1119.00,1084.00,'Constitutional Monarchy','Hans-Adam II'),(125,'Sri Lanka','LK','LKA',NULL,'Sri Lanka/Ilankai','Asia','Southern and Central Asia',65610.00,1948,18827000,71.8,15706.00,15091.00,'Republic','Chandrika Kumaratunga'),(126,'Lesotho','LS','LSO',NULL,'Lesotho','Africa','Southern Africa',30355.00,1966,2153000,50.8,1061.00,1161.00,'Constitutional Monarchy','Letsie III'),(127,'Lithuania','LT','LTU',NULL,'Lietuva','Europe','Baltic Countries',65301.00,1991,3698500,69.1,10692.00,9585.00,'Republic','Valdas Adamkus'),(128,'Luxembourg','LU','LUX',NULL,'Luxembourg/LÃ«tzebuerg','Europe','Western Europe',2586.00,1867,435700,77.1,16321.00,15519.00,'Constitutional Monarchy','Henri'),(129,'Latvia','LV','LVA',NULL,'Latvija','Europe','Baltic Countries',64589.00,1991,2424200,68.4,6398.00,5639.00,'Republic','Vaira Vike-Freiberga'),(130,'Macao','MO','MAC',NULL,'Macau/Aomen','Asia','Eastern Asia',18.00,NULL,473000,81.6,5749.00,5940.00,'Special Administrative Region of China','Jiang Zemin'),(131,'Morocco','MA','MAR',NULL,'Al-Maghrib','Africa','Northern Africa',446550.00,1956,28351000,69.1,36124.00,33514.00,'Constitutional Monarchy','Mohammed VI'),(132,'Monaco','MC','MCO',NULL,'Monaco','Europe','Western Europe',1.50,1861,34000,78.8,776.00,NULL,'Constitutional Monarchy','Rainier III'),(133,'Moldova','MD','MDA',NULL,'Moldova','Europe','Eastern Europe',33851.00,1991,4380000,64.5,1579.00,1872.00,'Republic','Vladimir Voronin'),(134,'Madagascar','MG','MDG',NULL,'Madagasikara/Madagascar','Africa','Eastern Africa',587041.00,1960,15942000,55.0,3750.00,3545.00,'Federal Republic','Didier Ratsiraka'),(135,'Maldives','MV','MDV',NULL,'Dhivehi Raajje/Maldives','Asia','Southern and Central Asia',298.00,1965,286000,62.2,199.00,NULL,'Republic','Maumoon Abdul Gayoom'),(136,'Mexico','MX','MEX',NULL,'MÃ©xico','North America','Central America',1958201.00,1810,98881000,71.5,414972.00,401461.00,'Federal Republic','Vicente Fox Quesada'),(137,'Marshall Islands','MH','MHL',NULL,'Marshall Islands/Majol','Oceania','Micronesia',181.00,1990,64000,65.5,97.00,NULL,'Republic','Kessai Note'),(138,'Macedonia','MK','MKD',NULL,'Makedonija','Europe','Southern Europe',25713.00,1991,2024000,73.8,1694.00,1915.00,'Republic','Boris Trajkovski'),(139,'Mali','ML','MLI',NULL,'Mali','Africa','Western Africa',1240192.00,1960,11234000,46.7,2642.00,2453.00,'Republic','Alpha Oumar KonarÃ©'),(140,'Malta','MT','MLT',NULL,'Malta','Europe','Southern Europe',316.00,1964,380200,77.9,3512.00,3338.00,'Republic','Guido de Marco'),(141,'Myanmar','MM','MMR',NULL,'Myanma Pye','Asia','Southeast Asia',676578.00,1948,45611000,54.9,180375.00,171028.00,'Republic','kenraali Than Shwe'),(142,'Mongolia','MN','MNG',NULL,'Mongol Uls','Asia','Eastern Asia',1566500.00,1921,2662000,67.3,1043.00,933.00,'Republic','Natsagiin Bagabandi'),(143,'Northern Mariana Islands','MP','MNP',NULL,'Northern Mariana Islands','Oceania','Micronesia',464.00,NULL,78000,75.5,0.00,NULL,'Commonwealth of the US','George W. Bush'),(144,'Mozambique','MZ','MOZ',NULL,'MoÃ§ambique','Africa','Eastern Africa',801590.00,1975,19680000,37.5,2891.00,2711.00,'Republic','JoaquÃ­m A. Chissano'),(145,'Mauritania','MR','MRT',NULL,'Muritaniya/Mauritanie','Africa','Western Africa',1025520.00,1960,2670000,50.8,998.00,1081.00,'Republic','Maaouiya Ould SidÂ´Ahmad Taya'),(146,'Montserrat','MS','MSR',NULL,'Montserrat','North America','Caribbean',102.00,NULL,11000,78.0,109.00,NULL,'Dependent Territory of the UK','Elisabeth II'),(147,'Martinique','MQ','MTQ',NULL,'Martinique','North America','Caribbean',1102.00,NULL,395000,78.3,2731.00,2559.00,'Overseas Department of France','Jacques Chirac'),(148,'Mauritius','MU','MUS',NULL,'Mauritius','Africa','Eastern Africa',2040.00,1968,1158000,71.0,4251.00,4186.00,'Republic','Cassam Uteem'),(149,'Malawi','MW','MWI',NULL,'Malawi','Africa','Eastern Africa',118484.00,1964,10925000,37.6,1687.00,2527.00,'Republic','Bakili Muluzi'),(150,'Malaysia','MY','MYS',NULL,'Malaysia','Asia','Southeast Asia',329758.00,1957,22244000,70.8,69213.00,97884.00,'Constitutional Monarchy, Federation','Salahuddin Abdul Aziz Shah Alhaj'),(151,'Mayotte','YT','MYT',NULL,'Mayotte','Africa','Eastern Africa',373.00,NULL,149000,59.5,0.00,NULL,'Territorial Collectivity of France','Jacques Chirac'),(152,'Namibia','NA','NAM',NULL,'Namibia','Africa','Southern Africa',824292.00,1990,1726000,42.5,3101.00,3384.00,'Republic','Sam Nujoma'),(153,'New Caledonia','NC','NCL',NULL,'Nouvelle-CalÃ©donie','Oceania','Melanesia',18575.00,NULL,214000,72.8,3563.00,NULL,'Nonmetropolitan Territory of France','Jacques Chirac'),(154,'Niger','NE','NER',NULL,'Niger','Africa','Western Africa',1267000.00,1960,10730000,41.3,1706.00,1580.00,'Republic','Mamadou Tandja'),(155,'Norfolk Island','NF','NFK',NULL,'Norfolk Island','Oceania','Australia and New Zealand',36.00,NULL,2000,NULL,0.00,NULL,'Territory of Australia','Elisabeth II'),(156,'Nigeria','NG','NGA',NULL,'Nigeria','Africa','Western Africa',923768.00,1960,111506000,51.6,65707.00,58623.00,'Federal Republic','Olusegun Obasanjo'),(157,'Nicaragua','NI','NIC',NULL,'Nicaragua','North America','Central America',130000.00,1838,5074000,68.7,1988.00,2023.00,'Republic','Arnoldo AlemÃ¡n Lacayo'),(158,'Niue','NU','NIU',NULL,'Niue','Oceania','Polynesia',260.00,NULL,2000,NULL,0.00,NULL,'Nonmetropolitan Territory of New Zealand','Elisabeth II'),(159,'Netherlands','NL','NLD',NULL,'Nederland','Europe','Western Europe',41526.00,1581,15864000,78.3,371362.00,360478.00,'Constitutional Monarchy','Beatrix'),(160,'Norway','NO','NOR',NULL,'Norge','Europe','Nordic Countries',323877.00,1905,4478500,78.7,145895.00,153370.00,'Constitutional Monarchy','Harald V'),(161,'Nepal','NP','NPL',NULL,'Nepal','Asia','Southern and Central Asia',147181.00,1769,23930000,57.8,4768.00,4837.00,'Constitutional Monarchy','Gyanendra Bir Bikram'),(162,'Nauru','NR','NRU',NULL,'Naoero/Nauru','Oceania','Micronesia',21.00,1968,12000,60.8,197.00,NULL,'Republic','Bernard Dowiyogo'),(163,'New Zealand','NZ','NZL',NULL,'New Zealand/Aotearoa','Oceania','Australia and New Zealand',270534.00,1907,3862000,77.8,54669.00,64960.00,'Constitutional Monarchy','Elisabeth II'),(164,'Oman','OM','OMN',NULL,'Â´Uman','Asia','Middle East',309500.00,1951,2542000,71.8,16904.00,16153.00,'Monarchy (Sultanate)','Qabus ibn SaÂ´id'),(165,'Pakistan','PK','PAK',NULL,'Pakistan','Asia','Southern and Central Asia',796095.00,1947,156483000,61.1,61289.00,58549.00,'Republic','Mohammad Rafiq Tarar'),(166,'Panama','PA','PAN',NULL,'PanamÃ¡','North America','Central America',75517.00,1903,2856000,75.5,9131.00,8700.00,'Republic','Mireya Elisa Moscoso RodrÃ­guez'),(167,'Pitcairn','PN','PCN',NULL,'Pitcairn','Oceania','Polynesia',49.00,NULL,50,NULL,0.00,NULL,'Dependent Territory of the UK','Elisabeth II'),(168,'Peru','PE','PER',NULL,'PerÃº/Piruw','South America','South America',1285216.00,1821,25662000,70.0,64140.00,65186.00,'Republic','Valentin Paniagua Corazao'),(169,'Philippines','PH','PHL',NULL,'Pilipinas','Asia','Southeast Asia',300000.00,1946,75967000,67.5,65107.00,82239.00,'Republic','Gloria Macapagal-Arroyo'),(170,'Palau','PW','PLW',NULL,'Belau/Palau','Oceania','Micronesia',459.00,1994,19000,68.6,105.00,NULL,'Republic','Kuniwo Nakamura'),(171,'Papua New Guinea','PG','PNG',NULL,'Papua New Guinea/Papua Niugini','Oceania','Melanesia',462840.00,1975,4807000,63.1,4988.00,6328.00,'Constitutional Monarchy','Elisabeth II'),(172,'Poland','PL','POL',NULL,'Polska','Europe','Eastern Europe',323250.00,1918,38653600,73.2,151697.00,135636.00,'Republic','Aleksander Kwasniewski'),(173,'Puerto Rico','PR','PRI',NULL,'Puerto Rico','North America','Caribbean',8875.00,NULL,3869000,75.6,34100.00,32100.00,'Commonwealth of the US','George W. Bush'),(174,'North Korea','KP','PRK',NULL,'Choson Minjujuui InÂ´min Konghwaguk (Bukhan)','Asia','Eastern Asia',120538.00,1948,24039000,70.7,5332.00,NULL,'Socialistic Republic','Kim Jong-il'),(175,'Portugal','PT','PRT',NULL,'Portugal','Europe','Southern Europe',91982.00,1143,9997600,75.8,105954.00,102133.00,'Republic','Jorge SampÃ£io'),(176,'Paraguay','PY','PRY',NULL,'Paraguay','South America','South America',406752.00,1811,5496000,73.7,8444.00,9555.00,'Republic','Luis Ãngel GonzÃ¡lez Macchi'),(177,'Palestine','PS','PSE',NULL,'Filastin','Asia','Middle East',6257.00,NULL,3101000,71.4,4173.00,NULL,'Autonomous Area','Yasser (Yasir) Arafat'),(178,'French Polynesia','PF','PYF',NULL,'PolynÃ©sie franÃ§aise','Oceania','Polynesia',4000.00,NULL,235000,74.8,818.00,781.00,'Nonmetropolitan Territory of France','Jacques Chirac'),(179,'Qatar','QA','QAT',NULL,'Qatar','Asia','Middle East',11000.00,1971,599000,72.4,9472.00,8920.00,'Monarchy','Hamad ibn Khalifa al-Thani'),(180,'RÃ©union','RE','REU',NULL,'RÃ©union','Africa','Eastern Africa',2510.00,NULL,699000,72.7,8287.00,7988.00,'Overseas Department of France','Jacques Chirac'),(181,'Romania','RO','ROM',NULL,'RomÃ¢nia','Europe','Eastern Europe',238391.00,1878,22455500,69.9,38158.00,34843.00,'Republic','Ion Iliescu'),(182,'Russian Federation','RU','RUS',NULL,'Rossija','Europe','Eastern Europe',17075400.00,1991,146934000,67.2,276608.00,442989.00,'Federal Republic','Vladimir Putin'),(183,'Rwanda','RW','RWA',NULL,'Rwanda/Urwanda','Africa','Eastern Africa',26338.00,1962,7733000,39.3,2036.00,1863.00,'Republic','Paul Kagame'),(184,'Saudi Arabia','SA','SAU',NULL,'Al-Â´Arabiya as-SaÂ´udiya','Asia','Middle East',2149690.00,1932,21607000,67.8,137635.00,146171.00,'Monarchy','Fahd ibn Abdul-Aziz al-SaÂ´ud'),(185,'Sudan','SD','SDN',NULL,'As-Sudan','Africa','Northern Africa',2505813.00,1956,29490000,56.6,10162.00,NULL,'Islamic Republic','Omar Hassan Ahmad al-Bashir'),(186,'Senegal','SN','SEN',NULL,'SÃ©nÃ©gal/Sounougal','Africa','Western Africa',196722.00,1960,9481000,62.2,4787.00,4542.00,'Republic','Abdoulaye Wade'),(187,'Singapore','SG','SGP',NULL,'Singapore/Singapura/Xinjiapo/Singapur','Asia','Southeast Asia',618.00,1965,3567000,80.1,86503.00,96318.00,'Republic','Sellapan Rama Nathan'),(188,'South Georgia and the South Sandwich Islands','GS','SGS',NULL,'South Georgia and the South Sandwich Islands','Antarctica','Antarctica',3903.00,NULL,0,NULL,0.00,NULL,'Dependent Territory of the UK','Elisabeth II'),(189,'Saint Helena','SH','SHN',NULL,'Saint Helena','Africa','Western Africa',314.00,NULL,6000,76.8,0.00,NULL,'Dependent Territory of the UK','Elisabeth II'),(190,'Svalbard and Jan Mayen','SJ','SJM',NULL,'Svalbard og Jan Mayen','Europe','Nordic Countries',62422.00,NULL,3200,NULL,0.00,NULL,'Dependent Territory of Norway','Harald V'),(191,'Solomon Islands','SB','SLB',NULL,'Solomon Islands','Oceania','Melanesia',28896.00,1978,444000,71.3,182.00,220.00,'Constitutional Monarchy','Elisabeth II'),(192,'Sierra Leone','SL','SLE',NULL,'Sierra Leone','Africa','Western Africa',71740.00,1961,4854000,45.3,746.00,858.00,'Republic','Ahmed Tejan Kabbah'),(193,'El Salvador','SV','SLV',NULL,'El Salvador','North America','Central America',21041.00,1841,6276000,69.7,11863.00,11203.00,'Republic','Francisco Guillermo Flores PÃ©rez'),(194,'San Marino','SM','SMR',NULL,'San Marino','Europe','Southern Europe',61.00,885,27000,81.1,510.00,NULL,'Republic',NULL),(195,'Somalia','SO','SOM',NULL,'Soomaaliya','Africa','Eastern Africa',637657.00,1960,10097000,46.2,935.00,NULL,'Republic','Abdiqassim Salad Hassan'),(196,'Saint Pierre and Miquelon','PM','SPM',NULL,'Saint-Pierre-et-Miquelon','North America','North America',242.00,NULL,7000,77.6,0.00,NULL,'Territorial Collectivity of France','Jacques Chirac'),(197,'Sao Tome and Principe','ST','STP',NULL,'SÃ£o TomÃ© e PrÃ­ncipe','Africa','Central Africa',964.00,1975,147000,65.3,6.00,NULL,'Republic','Miguel Trovoada'),(198,'Suriname','SR','SUR',NULL,'Suriname','South America','South America',163265.00,1975,417000,71.4,870.00,706.00,'Republic','Ronald Venetiaan'),(199,'Slovakia','SK','SVK',NULL,'Slovensko','Europe','Eastern Europe',49012.00,1993,5398700,73.7,20594.00,19452.00,'Republic','Rudolf Schuster'),(200,'Slovenia','SI','SVN',NULL,'Slovenija','Europe','Southern Europe',20256.00,1991,1987800,74.9,19756.00,18202.00,'Republic','Milan Kucan'),(201,'Sweden','SE','SWE',NULL,'Sverige','Europe','Nordic Countries',449964.00,836,8861400,79.6,226492.00,227757.00,'Constitutional Monarchy','Carl XVI Gustaf'),(202,'Swaziland','SZ','SWZ',NULL,'kaNgwane','Africa','Southern Africa',17364.00,1968,1008000,40.4,1206.00,1312.00,'Monarchy','Mswati III'),(203,'Seychelles','SC','SYC',NULL,'Sesel/Seychelles','Africa','Eastern Africa',455.00,1976,77000,70.4,536.00,539.00,'Republic','France-Albert RenÃ©'),(204,'Syria','SY','SYR',NULL,'Suriya','Asia','Middle East',185180.00,1941,16125000,68.5,65984.00,64926.00,'Republic','Bashar al-Assad'),(205,'Turks and Caicos Islands','TC','TCA',NULL,'The Turks and Caicos Islands','North America','Caribbean',430.00,NULL,17000,73.3,96.00,NULL,'Dependent Territory of the UK','Elisabeth II'),(206,'Chad','TD','TCD',NULL,'Tchad/Tshad','Africa','Central Africa',1284000.00,1960,7651000,50.5,1208.00,1102.00,'Republic','Idriss DÃ©by'),(207,'Togo','TG','TGO',NULL,'Togo','Africa','Western Africa',56785.00,1960,4629000,54.7,1449.00,1400.00,'Republic','GnassingbÃ© EyadÃ©ma'),(208,'Thailand','TH','THA',NULL,'Prathet Thai','Asia','Southeast Asia',513115.00,1350,61399000,68.6,116416.00,153907.00,'Constitutional Monarchy','Bhumibol Adulyadej'),(209,'Tajikistan','TJ','TJK',NULL,'ToÃ§ikiston','Asia','Southern and Central Asia',143100.00,1991,6188000,64.1,1990.00,1056.00,'Republic','Emomali Rahmonov'),(210,'Tokelau','TK','TKL',NULL,'Tokelau','Oceania','Polynesia',12.00,NULL,2000,NULL,0.00,NULL,'Nonmetropolitan Territory of New Zealand','Elisabeth II'),(211,'Turkmenistan','TM','TKM',NULL,'TÃ¼rkmenostan','Asia','Southern and Central Asia',488100.00,1991,4459000,60.9,4397.00,2000.00,'Republic','Saparmurad Nijazov'),(212,'East Timor','TP','TMP',NULL,'Timor Timur','Asia','Southeast Asia',14874.00,NULL,885000,46.0,0.00,NULL,'Administrated by the UN','JosÃ© Alexandre GusmÃ£o'),(213,'Tonga','TO','TON',NULL,'Tonga','Oceania','Polynesia',650.00,1970,99000,67.9,146.00,170.00,'Monarchy','Taufa\'ahau Tupou IV'),(214,'Trinidad and Tobago','TT','TTO',NULL,'Trinidad and Tobago','North America','Caribbean',5130.00,1962,1295000,68.0,6232.00,5867.00,'Republic','Arthur N. R. Robinson'),(215,'Tunisia','TN','TUN',NULL,'Tunis/Tunisie','Africa','Northern Africa',163610.00,1956,9586000,73.7,20026.00,18898.00,'Republic','Zine al-Abidine Ben Ali'),(216,'Turkey','TR','TUR',NULL,'TÃ¼rkiye','Asia','Middle East',774815.00,1923,66591000,71.0,210721.00,189122.00,'Republic','Ahmet Necdet Sezer'),(217,'Tuvalu','TV','TUV',NULL,'Tuvalu','Oceania','Polynesia',26.00,1978,12000,66.3,6.00,NULL,'Constitutional Monarchy','Elisabeth II'),(218,'Taiwan','TW','TWN',NULL,'TÂ’ai-wan','Asia','Eastern Asia',36188.00,1945,22256000,76.4,256254.00,263451.00,'Republic','Chen Shui-bian'),(219,'Tanzania','TZ','TZA',NULL,'Tanzania','Africa','Eastern Africa',883749.00,1961,33517000,52.3,8005.00,7388.00,'Republic','Benjamin William Mkapa'),(220,'Uganda','UG','UGA',NULL,'Uganda','Africa','Eastern Africa',241038.00,1962,21778000,42.9,6313.00,6887.00,'Republic','Yoweri Museveni'),(221,'Ukraine','UA','UKR',NULL,'Ukrajina','Europe','Eastern Europe',603700.00,1991,50456000,66.0,42168.00,49677.00,'Republic','Leonid KutÂšma'),(222,'United States Minor Outlying Islands','UM','UMI',NULL,'United States Minor Outlying Islands','Oceania','Micronesia/Caribbean',16.00,NULL,0,NULL,0.00,NULL,'Dependent Territory of the US','George W. Bush'),(223,'Uruguay','UY','URY',NULL,'Uruguay','South America','South America',175016.00,1828,3337000,75.2,20831.00,19967.00,'Republic','Jorge Batlle IbÃ¡Ã±ez'),(224,'United States','US','USA',NULL,'United States','North America','North America',9363520.00,1776,278357000,77.1,8510700.00,8110900.00,'Federal Republic','George W. Bush'),(225,'Uzbekistan','UZ','UZB',NULL,'Uzbekiston','Asia','Southern and Central Asia',447400.00,1991,24318000,63.7,14194.00,21300.00,'Republic','Islam Karimov'),(226,'Holy See (Vatican City State)','VA','VAT',NULL,'Santa Sede/CittÃ  del Vaticano','Europe','Southern Europe',0.40,1929,1000,NULL,9.00,NULL,'Independent Church State','Johannes Paavali II'),(227,'Saint Vincent and the Grenadines','VC','VCT',NULL,'Saint Vincent and the Grenadines','North America','Caribbean',388.00,1979,114000,72.3,285.00,NULL,'Constitutional Monarchy','Elisabeth II'),(228,'Venezuela','VE','VEN',NULL,'Venezuela','South America','South America',912050.00,1811,24170000,73.1,95023.00,88434.00,'Federal Republic','Hugo ChÃ¡vez FrÃ­as'),(229,'Virgin Islands, British','VG','VGB',NULL,'British Virgin Islands','North America','Caribbean',151.00,NULL,21000,75.4,612.00,573.00,'Dependent Territory of the UK','Elisabeth II'),(230,'Virgin Islands, U.S.','VI','VIR',NULL,'Virgin Islands of the United States','North America','Caribbean',347.00,NULL,93000,78.1,0.00,NULL,'US Territory','George W. Bush'),(231,'Vietnam','VN','VNM',NULL,'ViÃªt Nam','Asia','Southeast Asia',331689.00,1945,79832000,69.3,21929.00,22834.00,'Socialistic Republic','TrÃ¢n Duc Luong'),(232,'Vanuatu','VU','VUT',NULL,'Vanuatu','Oceania','Melanesia',12189.00,1980,190000,60.6,261.00,246.00,'Republic','John Bani'),(233,'Wallis and Futuna','WF','WLF',NULL,'Wallis-et-Futuna','Oceania','Polynesia',200.00,NULL,15000,NULL,0.00,NULL,'Nonmetropolitan Territory of France','Jacques Chirac'),(234,'Samoa','WS','WSM',NULL,'Samoa','Oceania','Polynesia',2831.00,1962,180000,69.2,141.00,157.00,'Parlementary Monarchy','Malietoa Tanumafili II'),(235,'Yemen','YE','YEM',NULL,'Al-Yaman','Asia','Middle East',527968.00,1918,18112000,59.8,6041.00,5729.00,'Republic','Ali Abdallah Salih'),(236,'Yugoslavia','YU','YUG',NULL,'Jugoslavija','Europe','Southern Europe',102173.00,1918,10640000,72.4,17000.00,NULL,'Federal Republic','Vojislav KoÂštunica'),(237,'South Africa','ZA','ZAF',NULL,'South Africa','Africa','Southern Africa',1221037.00,1910,40377000,51.1,116729.00,129092.00,'Republic','Thabo Mbeki'),(238,'Zambia','ZM','ZMB',NULL,'Zambia','Africa','Eastern Africa',752618.00,1964,9169000,37.2,3377.00,3922.00,'Republic','Frederick Chiluba'),(239,'Zimbabwe','ZW','ZWE',NULL,'Zimbabwe','Africa','Eastern Africa',390757.00,1980,11669000,37.8,5951.00,8670.00,'Republic','Robert G. Mugabe'),(240,'_Global','GLB','GLB','2017-11-14 21:28:46',NULL,'null',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(243,'General Asia Left','GAAL',NULL,'2018-03-09 21:04:39',NULL,'Asia',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(246,'General Asia Right','GAAR',NULL,'2018-03-09 21:06:05',NULL,'Asia',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(249,'General Africa Left','GAFL',NULL,'2018-03-09 21:06:51',NULL,'Africa',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(252,'General Africa Right','GAFR',NULL,'2018-03-09 21:07:23',NULL,'Africa',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(255,'General Europe','GEU',NULL,'2018-03-09 21:08:16',NULL,'Europe',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(258,'General Latin America','GLA',NULL,'2018-03-09 21:08:57',NULL,'South America',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(261,'General Middle East','GME',NULL,'2018-03-09 21:09:34',NULL,'Asia',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(262,'cccc111','ccc',NULL,'2018-05-29 19:48:07',NULL,'ccc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
UNLOCK TABLES;

--
-- Table structure for table `country_language`
--

DROP TABLE IF EXISTS `country_language`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `country_language` (
  `country_language_id` int(11) NOT NULL AUTO_INCREMENT,
  `country_code` char(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `language_code` char(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`country_language_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1001 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `country_language`
--

LOCK TABLES `country_language` WRITE;
INSERT INTO `country_language` VALUES (1,'AR','es'),(2,'AM','hy'),(3,'AU','en'),(4,'AT','en'),(5,'AT','de'),(6,'BY','by'),(7,'BE','en'),(8,'BE','fr'),(9,'BE','nl'),(10,'BA','bs'),(11,'BA','hr'),(12,'BR','en'),(14,'BG','bg'),(15,'CA','en'),(17,'CN','en'),(18,'CN','zh'),(19,'HR','hr'),(20,'CY','en'),(21,'CY','el'),(22,'CZ','en'),(23,'CZ','cs'),(24,'DK','en'),(25,'DK','da'),(26,'EG','en'),(27,'EG','ar'),(28,'EE','et'),(29,'ET','am'),(30,'FI','fi'),(31,'FR','en'),(32,'FR','fr'),(33,'DE','de'),(34,'GR','en'),(35,'GR','el'),(36,'HK','en'),(37,'HK','zh'),(38,'HU','hu'),(39,'IN','en'),(40,'IN','hi'),(41,'ID','en'),(42,'ID','id'),(43,'IE','en'),(44,'IT','en'),(45,'IT','it'),(46,'JP','en'),(47,'JP','ja'),(48,'KZ','kk'),(49,'KZ','ru'),(50,'LV','lv'),(51,'LT','lt'),(52,'MW','en'),(53,'MY','en'),(54,'MY','ms'),(55,'MX','en'),(56,'MX','es'),(57,'MD','ro'),(58,'MA','en'),(59,'MA','fr'),(60,'MA','ar'),(61,'MZ','pt'),(62,'NL','en'),(63,'NL','nl'),(64,'NZ','en'),(65,'NO','no'),(66,'PH','en'),(67,'PH','tl'),(68,'PL','en'),(69,'PL','pl'),(70,'PT','en'),(71,'PT','pt'),(72,'RO','en'),(73,'RO','ro'),(74,'RU','en'),(75,'RU','ru'),(76,'CS','sr'),(77,'SG','en'),(78,'SK','sk'),(79,'SI','sl'),(80,'ZA','en'),(81,'KR','ko'),(82,'ES','en'),(83,'ES','es'),(84,'SE','en'),(85,'SE','sv'),(86,'CH','en'),(87,'CH','fr'),(88,'CH','de'),(89,'TW','zh'),(90,'TZ','en'),(91,'TZ','sw'),(92,'TH','th'),(93,'TR','en'),(94,'TR','tr'),(95,'UA','uk'),(96,'AE','en'),(97,'AE','ar'),(98,'AE','hi'),(99,'AE','ur'),(100,'GB','en'),(101,'US','en'),(102,'US','es'),(103,'VN','vi'),(104,'GLB','en'),(105,'GLB','fr'),(107,'CN','zh_cn'),(108,'BR','pt_br'),(111,'CA','fr_ca'),(114,'DE','en'),(117,'FI','en'),(120,'GAAR','en'),(123,'GAAL','en'),(126,'GAFL','en'),(129,'GAFL','fr'),(132,'GAFR','en'),(135,'GAFR','fr'),(138,'GEU','en'),(141,'GLA','en'),(144,'GLA','es'),(147,'BR','pt'),(150,'CA','fr'),(153,'GME','ar'),(156,'GME','en'),(159,'HK','zh_tw'),(162,'HU','en'),(165,'KR','en'),(168,'NO','en'),(171,'TH','en'),(174,'TW','zh_tw'),(177,'TW','en'),(178,'EH','an'),(179,'EH','ast'),(1000,'AR1','es');
UNLOCK TABLES;

--
-- Table structure for table `country_property`
--

DROP TABLE IF EXISTS `country_property`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `country_property` (
  `property_id` int(11) NOT NULL AUTO_INCREMENT,
  `country_id` int(11) DEFAULT NULL,
  `content_version_property_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`property_id`)
) ENGINE=InnoDB AUTO_INCREMENT=374 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `country_property`
--

LOCK TABLES `country_property` WRITE;
INSERT INTO `country_property` VALUES (8,231,4),(10,231,6),(12,228,4),(69,8,3),(72,8,6),(78,15,4),(81,15,6),(84,16,3),(87,16,6),(90,19,3),(93,19,6),(96,31,3),(99,31,6),(102,38,3),(105,38,6),(108,40,3),(111,40,6),(114,42,3),(117,42,6),(120,56,3),(123,56,6),(126,57,3),(129,57,6),(132,60,3),(135,60,6),(138,67,3),(141,67,6),(144,70,3),(147,70,6),(150,73,3),(153,73,6),(156,86,3),(159,86,6),(162,246,3),(165,246,6),(168,243,4),(171,243,6),(174,249,4),(177,249,6),(180,252,3),(183,252,6),(186,77,4),(189,77,6),(192,77,5),(195,255,3),(198,255,6),(201,258,3),(204,258,6),(207,261,3),(210,261,6),(213,93,4),(216,93,6),(219,98,3),(222,98,6),(225,99,4),(228,99,6),(231,100,4),(234,100,6),(237,102,4),(240,102,6),(243,107,3),(246,107,6),(249,110,4),(252,110,6),(255,117,3),(258,117,6),(261,131,3),(264,131,6),(267,136,3),(270,136,6),(273,150,4),(276,150,6),(279,159,3),(282,159,6),(285,160,3),(288,160,6),(291,163,4),(294,163,6),(297,169,3),(300,169,6),(303,172,3),(306,172,6),(309,175,3),(312,175,6),(315,181,3),(318,181,6),(321,182,3),(324,182,6),(327,187,4),(330,187,6),(333,201,3),(336,201,6),(339,208,4),(342,208,6),(345,216,3),(348,216,6),(351,218,3),(354,218,6),(360,224,5),(363,237,4),(366,237,6),(371,224,3),(372,66,3),(373,66,5);
UNLOCK TABLES;

--
-- Table structure for table `course`
--

DROP TABLE IF EXISTS `course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `course` (
  `course_id` int(15) NOT NULL AUTO_INCREMENT,
  `status_id` tinyint(3) NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `name` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `code` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`course_id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course`
--

LOCK TABLES `course` WRITE;
INSERT INTO `course` VALUES (21,1,'2017-11-16 16:36:38','Motor Mind','','MM'),(22,1,'2018-05-09 20:22:35','new course','new course desc','CS1'),(23,2,'2018-05-09 20:29:16','new course 1','new course desc','ncc'),(24,1,'2018-05-09 20:32:18','dfgd','gdfgdfg','dfgdfg'),(25,2,'2018-05-09 20:36:01','new course 2','2','NC2'),(26,1,'2018-05-09 20:37:01','NEW CO3','NEW CO3','NC3'),(27,1,'2018-05-22 18:03:34','sdfasdf','sadfasdf','asdfsdf'),(28,1,'2018-05-29 19:54:24','course134f','course1','c1');
UNLOCK TABLES;

--
-- Table structure for table `course_lesson`
--

DROP TABLE IF EXISTS `course_lesson`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `course_lesson` (
  `course_lesson_id` int(7) NOT NULL AUTO_INCREMENT,
  `course_id` int(7) NOT NULL,
  `lesson_id` int(7) NOT NULL,
  `_order` int(3) DEFAULT NULL,
  PRIMARY KEY (`course_lesson_id`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_lesson`
--

LOCK TABLES `course_lesson` WRITE;
INSERT INTO `course_lesson` VALUES (52,21,37,0),(53,22,44,0),(54,22,44,1),(55,22,37,2),(56,23,43,0),(57,23,37,1),(58,23,44,2),(59,24,37,NULL),(60,25,37,NULL),(61,25,43,NULL),(62,26,37,NULL);
UNLOCK TABLES;

--
-- Table structure for table `dictionary`
--

DROP TABLE IF EXISTS `dictionary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `dictionary` (
  `term_id` smallint(5) NOT NULL AUTO_INCREMENT,
  `term` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `selector` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`term_id`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dictionary`
--

LOCK TABLES `dictionary` WRITE;
INSERT INTO `dictionary` VALUES (1,'Cancel','{$dt-cancel}'),(2,'Start','{$dt-start}'),(3,'Left','{$dt-left}'),(4,'Right','{$dt-right}'),(5,'mph','{$dt-mph}'),(6,'km/h','{$dt-kmh}'),(7,'Meters','{$dt-meters}'),(8,'Feet','{$dt-feet}'),(9,'Person A','{$dt-person_a}'),(10,'Person B','{$dt-person_b}'),(11,'Task 1','{$dt-task_1}'),(12,'Task 2','{$dt-task_2}'),(13,'Task Switch','{$dt-task_switch}'),(14,'True','{$dt-true}'),(15,'False','{$dt-false}'),(16,'Continue','{$dt-continue}'),(17,'Look','{$dt-look}'),(18,'Drive','{$dt-drive}'),(19,'Phone','{$dt-phone}'),(20,'Speedometer','{$dt-speedometer}'),(21,'Spacebar','{$dt-spacebar}'),(22,'Who','{$dt-who}'),(23,'What','{$dt-what}'),(24,'Where','{$dt-where}'),(25,'Why','{$dt-why}'),(61,'',''),(62,'test1','testttt');
UNLOCK TABLES;

--
-- Table structure for table `language`
--

DROP TABLE IF EXISTS `language`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `language` (
  `language_id` int(5) NOT NULL AUTO_INCREMENT,
  `code` char(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `name` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `text_dir` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'ltr',
  PRIMARY KEY (`language_id`)
) ENGINE=InnoDB AUTO_INCREMENT=150 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `language`
--

LOCK TABLES `language` WRITE;
INSERT INTO `language` VALUES (1,'af','Afrikaans (af)','ltr'),(2,'am',' አማርኛ (am)','ltr'),(3,'an','Aragonés (an)','ltr'),(4,'ar','عربي (ar)','rtl'),(5,'ast','Asturianu (ast)','ltr'),(6,'az','Azərbaycanca (az)','ltr'),(7,'ba','Башҡорт теле (ba)','ltr'),(8,'be','Беларуская (be)','ltr'),(9,'bg','Български (bg)','ltr'),(10,'bn','বাংলা (bn)','ltr'),(11,'br','Breizh (br)','ltr'),(12,'bs','Bosanski (bs)','ltr'),(13,'ca','Català (ca)','ltr'),(15,'ckb','سۆرانی (ckb)','ltr'),(16,'cs','Čeština (cs)','ltr'),(17,'cy','Cymraeg (cy)','ltr'),(18,'da','Dansk (da)','ltr'),(21,'de','Deutsch (de)','ltr'),(25,'dv','ދިވެހި (dv)','ltr'),(26,'dz','རྫོང་ཁ (dz)','ltr'),(27,'ee','Èʋegbe (ee)','ltr'),(28,'el','Ελληνικά (el)','ltr'),(33,'eo','Esperanto (eo)','ltr'),(34,'es','Español (es)','ltr'),(39,'et','eesti (et)','ltr'),(40,'eu','Euskara (eu)','ltr'),(41,'fa','فارسی (fa)','rtl'),(42,'fi','Suomi (fi)','ltr'),(44,'fil','Filipino (fil)','ltr'),(45,'fj','VakaViti (fj)','ltr'),(46,'fo','Føroyskt (fo)','ltr'),(47,'fr','Français (fr)','ltr'),(49,'ga','Gaeilge (ga)','ltr'),(50,'gd','Gàidhlig (gd)','ltr'),(51,'gl','Galego (gl)','ltr'),(52,'gu','ગુજરાતી (gu)','ltr'),(53,'ha','Hausa (ha)','ltr'),(54,'hat','Kreyòl Ayisyen (hat)','ltr'),(55,'haw','ʻŌlelo Hawaiʻi (haw)','ltr'),(56,'he','עברית (he)','rtl'),(58,'hi','हिंदी (hi)','ltr'),(59,'hr','Hrvatski (hr)','ltr'),(60,'hu','magyar (hu)','ltr'),(61,'hy','Հայերեն (hy)','ltr'),(62,'id','Indonesian (id)','ltr'),(63,'is','Íslenska (is)','ltr'),(64,'it','Italiano (it)','ltr'),(65,'ja','日本語 (ja)','ltr'),(67,'ka','ქართული (ka)','ltr'),(68,'kab','Taqbaylit (kab)','ltr'),(69,'kk','Қазақша (kk)','ltr'),(70,'kl','Kalaallisut (kl)','ltr'),(71,'km','ខ្មែរ (km)','ltr'),(72,'kmr','Kurmanji (kmr)','ltr'),(73,'kn','ಕನ್ನಡ (kn)','ltr'),(74,'ko','한국어 (ko)','ltr'),(75,'ky','Кыргызча (ky)','ltr'),(76,'la','Latin (la)','ltr'),(77,'lb','Lëtzebuergesch (lb)','ltr'),(78,'lo','Laotian (lo)','ltr'),(79,'lt','Lietuvių (lt)','ltr'),(81,'lv','Latviešu (lv)','ltr'),(82,'mg','Malagasy (mg)','ltr'),(83,'mh','Ebon (mh)','ltr'),(84,'mi_tn','Māori - Tainui (mi_tn)','ltr'),(85,'mi_wwow','Māori - Waikato (mi_wwow)','ltr'),(86,'mis','Crnogorski (mis)','ltr'),(87,'mk','Македонски (mk)','ltr'),(88,'ml','മലയാളം (ml)','ltr'),(89,'mn','Монгол (mn)','ltr'),(91,'mr','मराठी (mr)','ltr'),(92,'ms','Bahasa Melayu (ms)','ltr'),(93,'my','myanma bhasa (my)','ltr'),(94,'ne','नेपाली (ne)','ltr'),(95,'nl','Nederlands (nl)','ltr'),(96,'nn','Norsk - nynorsk (nn)','ltr'),(97,'no','Norsk - bokmål (no)','ltr'),(102,'or','ଓଡ଼ିଆ (or)','ltr'),(103,'pan','ਪੰਜਾਬੀ (pan)','ltr'),(104,'pl','Polski (pl)','ltr'),(105,'ps','پښتو (ps)','ltr'),(106,'pt','Português (pt)','ltr'),(108,'rm_surs','Romansh Sursilvan (rm_surs)','ltr'),(109,'ro','Română (ro)','ltr'),(110,'ru','Русский (ru)','ltr'),(111,'se','Davvisámegiella (se)','ltr'),(112,'si','සිංහල (si)','ltr'),(113,'sk','Slovenčina (sk)','ltr'),(114,'sl','Sloven&#353;&#269;ina (sl)','ltr'),(115,'sm','Samoan (sm)','ltr'),(116,'sma','Sørsamisk (sma)','ltr'),(117,'smj','Lulesamisk (smj)','ltr'),(118,'so','Soomaali (so)','ltr'),(119,'sq','Shqip (sq)','ltr'),(122,'sv','Svenska (sv)','ltr'),(124,'sw','Kiswahili (sw)','ltr'),(125,'ta','Tamil (ta)','ltr'),(127,'te','తెలుగు  (te)','ltr'),(128,'tg','Тоҷикӣ (tg)','ltr'),(129,'th','Thai (th)','ltr'),(130,'ti','ትግርኛ (ti)','ltr'),(131,'tk','Turkmen (tk)','ltr'),(132,'tl','Tagalog (tl)','ltr'),(133,'tn','Setswana (tn)','ltr'),(134,'to','Tongan (to)','ltr'),(135,'tr','Türkçe (tr)','ltr'),(136,'tt','татар теле (tt)','ltr'),(137,'uk','Українська (uk)','ltr'),(138,'ur','اردو (ur)','rtl'),(139,'uz','Ozbekcha (uz)','ltr'),(140,'vi','Vietnamese (vi)','ltr'),(141,'wo','Wolof (wo)','ltr'),(142,'xct','བོད་ཡིག (xct)','ltr'),(143,'zgh','ⵜⴰⵎⴰⵣⵉⵖⵜ (zgh)','ltr'),(144,'zh_cn','简体中文 (zh_cn)','ltr'),(145,'zh_tw','正體中文 (zh_tw)','ltr'),(146,'zu','isiZulu (zu)','ltr'),(147,'en','English','ltr'),(148,'gfgfg','fgfgf','ltr'),(149,'ttt','tttt','ltr');
UNLOCK TABLES;

--
-- Table structure for table `lesson`
--

DROP TABLE IF EXISTS `lesson`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `lesson` (
  `lesson_id` smallint(7) NOT NULL AUTO_INCREMENT,
  `status_id` tinyint(3) NOT NULL,
  `vehicle_id` tinyint(3) NOT NULL,
  `name` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `code` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `url_private` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `order` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `type_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`lesson_id`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lesson`
--

LOCK TABLES `lesson` WRITE;
INSERT INTO `lesson` VALUES (37,1,1,'Multi-Tasking','TMM','','','2018-05-22 16:57:37',NULL,2),(43,1,1,'Test','TST','','','2018-03-09 02:45:01',NULL,NULL),(44,1,1,'lesson edit ','TD113','lesson edit desc','http://google.com','2018-05-08 21:07:50',NULL,NULL),(45,1,1,'dsfdf','sdfdf','sdfdsf','sdfsdfdsf','2018-05-14 19:15:42',NULL,NULL),(46,8,1,'DSFF','SDFSDF','SDFDF','SDFF','2018-05-22 15:20:29',NULL,NULL),(47,8,1,'DSFF','SDFSDF','SDFDF','SDFF','2018-05-22 15:20:42',NULL,NULL),(48,8,1,'DSFF','SDFSDF','SDFDF','SDFF','2018-05-22 15:20:50',NULL,NULL),(49,8,1,'DSFF1','SDFSDF','SDFDF','SDFF','2018-05-22 15:20:58',NULL,NULL),(50,8,2,'testttt4446667','L11','dESC','ASDASD','2018-05-22 15:56:05',NULL,NULL),(51,1,1,'dsfsdff','sdfdsf','sdfsdfdsf','sdfdsf','2018-05-22 16:00:19',NULL,NULL),(52,1,1,'fffffffff','fff','fffff','fff','2018-05-29 20:33:35',NULL,1),(53,1,1,'sadfsdf','sdfsdf','dfsadfsdf','dfdfdf','2018-05-22 17:23:28',NULL,1),(54,1,3,'Test new','T11','desc','HJSDHFKJSDFH','2018-05-22 17:24:22',NULL,1),(55,1,1,'Test 3','sdfsd','fsdfdsf','fsdfsdf','2018-05-22 20:24:24',NULL,1),(56,2,2,'new lesson','LCODE','test','JLKJKL','2018-05-23 14:21:13',NULL,1),(57,3,1,'new lesson2','new lesson2','new lesson2','','2018-05-23 14:21:47',NULL,2),(58,1,1,'test','tee1','test','','2018-05-29 20:34:44',NULL,1);
UNLOCK TABLES;

--
-- Table structure for table `lesson_task`
--

DROP TABLE IF EXISTS `lesson_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `lesson_task` (
  `lesson_task_id` smallint(7) NOT NULL AUTO_INCREMENT,
  `lesson_id` smallint(7) NOT NULL,
  `task_id` smallint(7) NOT NULL,
  `_order` int(3) NOT NULL DEFAULT '0',
  `menu_display` int(1) NOT NULL DEFAULT '1',
  `section_marker` int(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`lesson_task_id`),
  KEY `le_ta_lesson_id_idx` (`lesson_id`),
  CONSTRAINT `le_ta_lesson_id` FOREIGN KEY (`lesson_id`) REFERENCES `lesson` (`lesson_id`)
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lesson_task`
--

LOCK TABLES `lesson_task` WRITE;
INSERT INTO `lesson_task` VALUES (50,37,31,0,1,1),(51,37,32,1,1,1),(52,37,33,2,1,1),(53,37,34,3,1,1),(54,37,35,4,1,1),(55,37,36,5,1,1),(56,37,37,6,1,1),(57,37,38,7,1,1),(58,37,39,8,1,1),(59,37,40,9,1,1),(60,37,41,10,1,1),(61,37,42,11,1,1),(62,37,43,12,1,1),(63,37,44,13,1,1),(65,43,40,0,1,1),(68,44,45,0,1,1),(69,43,34,1,1,1),(70,44,39,1,1,1),(71,44,47,0,1,1),(72,44,46,2,1,1),(73,44,48,3,1,1);
UNLOCK TABLES;

--
-- Table structure for table `lesson_type`
--

DROP TABLE IF EXISTS `lesson_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `lesson_type` (
  `type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lesson_type`
--

LOCK TABLES `lesson_type` WRITE;
INSERT INTO `lesson_type` VALUES (1,'Standard',NULL),(2,'demo22','desc22');
UNLOCK TABLES;

--
-- Table structure for table `lesson_version`
--

DROP TABLE IF EXISTS `lesson_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `lesson_version` (
  `version_id` int(11) NOT NULL AUTO_INCREMENT,
  `lesson_id` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `name` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `default` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `code` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `country_id` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `language_id` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `update_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`version_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lesson_version`
--

LOCK TABLES `lesson_version` WRITE;
INSERT INTO `lesson_version` VALUES (1,1,1,'Default Version','1','DefVer','1','1','2017-10-02 19:18:18'),(2,1,1,'AnotherVersion','0','AnVer','1','2','2017-10-02 20:29:13');
UNLOCK TABLES;

--
-- Table structure for table `lock_type`
--

DROP TABLE IF EXISTS `lock_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `lock_type` (
  `lock_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `value` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`lock_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lock_type`
--

LOCK TABLES `lock_type` WRITE;
INSERT INTO `lock_type` VALUES (1,'None','none'),(2,'Time / Page','time-page'),(3,'Time / Character','time-char'),(4,'Interactive Function','func-int'),(5,'Video Complete','video-complete');
UNLOCK TABLES;

--
-- Table structure for table `status`
--

DROP TABLE IF EXISTS `status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `status` (
  `status_id` int(3) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `hexcode` varchar(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`status_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `status`
--

LOCK TABLES `status` WRITE;
INSERT INTO `status` VALUES (1,'active','active description','#000000'),(2,'pending','pending approval','#eeeeee'),(3,'archived','archived','#cccccc'),(8,'delete','delete','#ff0000'),(9,'st','st','st');
UNLOCK TABLES;

--
-- Table structure for table `task`
--

DROP TABLE IF EXISTS `task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `task` (
  `task_id` int(11) NOT NULL AUTO_INCREMENT,
  `type_id` int(3) NOT NULL,
  `status_id` int(3) NOT NULL,
  `name` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `lock_type` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `lock_time` int(25) DEFAULT NULL,
  `heading` varchar(145) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `display_main` tinyint(1) DEFAULT NULL,
  `display_next` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`task_id`),
  KEY `ta_type_id_idx` (`type_id`),
  KEY `ta_status_id_idx` (`status_id`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task`
--

LOCK TABLES `task` WRITE;
INSERT INTO `task` VALUES (31,4,1,'intro','','1',1000,'undefined',0,0),(32,10,1,'question-1','','1',1000,'undefined',0,0),(33,5,1,'Fact','','3',50,'undefined',1,1),(34,11,1,'Interactive 1','','4',50,'undefined',1,1),(35,10,1,'question-2','dfsgdfg','1',1000,'undefined',0,0),(36,12,1,'interactive-2','','3',50,'undefined',1,1),(37,10,1,'question-3','','1',0,'undefined',0,0),(38,12,1,'interactive-3','','3',50,'undefined',1,1),(39,10,1,'question-4','','1',1000,'undefined',0,0),(40,5,1,'Statistical Proof','','3',50,'undefined',1,1),(41,2,1,'Video','','5',0,'undefined',1,1),(42,10,1,'question-5','','1',0,'undefined',0,0),(43,10,1,'question-6','','1',0,'undefined',0,0),(44,13,1,'Congratulations','','1',0,'undefined',1,1),(45,9,1,'task 1','task desc 1','4',1000,'undefined',NULL,NULL),(46,11,1,'task new1','task new ','1',1000,'undefined',NULL,NULL),(47,11,0,'Task new 1','Task new 1','1',1000,'undefined',NULL,NULL),(48,11,1,'new task 2','new task 2','1',1000,'undefined',0,0),(49,9,1,'sdfsdf','sdfsdf','4',1000,'undefined',NULL,NULL),(50,9,2,'fgdfgfdg','dfgdfg','4',1000,'undefined',NULL,NULL),(51,1,1,'terte','rtertert','4',1000,'undefined',1,NULL),(52,13,2,'test new bala','test new bala','4',1002,'undefined',1,1),(54,9,1,'dsd','fsdfsdf','4',10002,'undefined',NULL,NULL),(55,9,1,'DSDSD','SDSD','4',1009,'undefined',1,1),(56,13,1,'test new','sdfsf','1',1044,'undefined',1,1),(57,0,0,'','sdfdsf','Time',1000,'undefined',0,0),(58,0,0,'sdfsf','','Time',1000,'undefined',0,0),(59,0,0,'','','Time',1000,'undefined',0,0);
UNLOCK TABLES;

--
-- Table structure for table `task_attr`
--

DROP TABLE IF EXISTS `task_attr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `task_attr` (
  `attr_id` smallint(7) NOT NULL AUTO_INCREMENT,
  `attr_type_id` tinyint(3) NOT NULL,
  `group_id` smallint(7) NOT NULL,
  `name` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `placeholder` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `default_value` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `label` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `_order` int(11) DEFAULT NULL,
  `type` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `group` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`attr_id`),
  KEY `ta_attr_type_id_idx` (`attr_type_id`),
  KEY `ta_attr_group_id_idx` (`group_id`),
  CONSTRAINT `ta_attr_group_id` FOREIGN KEY (`group_id`) REFERENCES `task_attr_group` (`group_id`),
  CONSTRAINT `ta_attr_type_id` FOREIGN KEY (`attr_type_id`) REFERENCES `task_attr_type` (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_attr`
--

LOCK TABLES `task_attr` WRITE;
INSERT INTO `task_attr` VALUES (1,9,1,'Image','Image Url','Image Url','Image Url',0,NULL,NULL),(2,1,1,'Content Heading','Type Heading ','Type Heading Here','Content Heading',1,NULL,NULL),(3,2,1,'Paragraph','Paragraph Content Here','Default value for paragraph','Content',2,NULL,NULL),(6,11,2,'Video','Video Url','Video Url','Video Url',0,'src','video'),(7,1,2,'Content Heading','Type Heading','Type Heading Here','Content Heading',2,'heading','headings'),(8,2,2,'Paragraph','Paragraph Content Here','Default value for paragraph','Content',3,'text','figcaption'),(10,1,3,'Sub-Heading','Type Heading','Type Heading','Sub-Heading',1,'subheading','headings'),(11,9,3,'Full-Screen Image','Image Url','Image Url','Full-Screen Image',2,'src','figure'),(12,1,4,'Content Heading','Type Heading','Type Heading','Main Heading',0,'heading','headings'),(13,9,4,'Image','Image URL','Image Url','Image Url',2,'src','figure'),(14,2,4,'Paragraph','Paragraph Content','Paragraph Content','Content',1,'text','figcaption'),(15,1,5,'Main Heading','Type Heading','Type Heading','Main Heading',1,NULL,NULL),(16,8,5,'HTML Markup','HTML Markup','HTML Markup','HTML Markup',0,NULL,NULL),(17,2,5,'Paragraph','Paragraph Content','Paragraph Content','Content',2,NULL,NULL),(19,1,6,'Content Heading','Content heading','Content Heading','Content Heading',0,NULL,NULL),(20,2,6,'Content','Content','Content','Content',1,NULL,NULL),(21,1,6,'Button Identifier','Button Identifier','Button Identifier','Button Identifier',2,NULL,NULL),(22,8,7,'HTML Markup','HTML Markup','HTML Markup','HTML Markup',0,NULL,NULL),(23,2,7,'Intitial Content','Content','Content','Content',2,NULL,NULL),(24,1,7,'Initial Content Heading','Content Heading','Content Heading','Content Heading',1,NULL,NULL),(25,1,8,'Content Heading','Content Heading','Content Heading','Content Heading',0,NULL,NULL),(26,2,8,'Content','Content','Content','Content',1,NULL,NULL),(27,4,8,'Timestamp','Timestamp','Timestamp','Timestamp',2,NULL,NULL),(28,9,2,'Video Poster','Video Poster','Video Poster','Video Poster',1,'poster','video'),(29,1,3,'Main Heading','Main Heading','Main Heading','Main Heading',0,'heading','headings'),(30,14,3,'Full-Screen Image Alt','Full-Screen Image Alt','Full-Screen Image Alt','Full-Screen Image Alt',3,'alt','figure'),(31,2,9,'Question Text','Question Text','Question Text','Question Text',0,'text','question'),(32,6,9,'Randomize Answers','Randomize Answers','Randomize Answers','Randomize Answers',1,'random','question'),(33,1,10,'Answer','Answer','Answer','Answer',0,'text','answer'),(34,4,10,'Answer Value','Answer Value','Answer Value','Answer Value',1,'score','answer'),(35,14,4,'Image Alt','Image Alt','Image Alt','Image Alt',3,'alt','figure'),(36,1,11,'Heading','Heading','Heading','Heading',1,'heading','headings'),(37,6,11,'Show Speedometer','Show Speedometer','Show Speedometer','Show Speedometer',2,'speedometer','settings'),(38,6,11,'Show Phone','Show Phone','Show Phone','Show Phone',3,'phone','settings'),(39,2,11,'Content','Content','Content','Content',5,'text','figcaption'),(40,6,11,'Show Video','Show Video','Show Video','Show Video',4,'video','settings'),(41,1,12,'Heading','Heading','Heading','Heading',1,'heading','headings'),(42,13,12,'Result 1','Result 1','Result 1','Result 1',2,'heading','result1'),(43,2,12,'Result 1 - Content','Result 1 - Content','Result 1 - Content','Result 1 - Content',3,'text','result1'),(44,13,12,'Result 2','Result 2','Result 2','Result 2',4,'heading','result2'),(45,2,12,'Result 2 - Content','Result 2 - Content','Result 2 - Content','Result 2 - Content',5,'text','result2'),(46,13,12,'Result 3','Result 3','Result 3','Result 3',6,'heading','result3'),(47,2,12,'Result 3 - Content','Result 3 - Content','Result 3 - Content','Result 3 - Content',7,'text','result3'),(48,11,11,'Video URL','Video URL','Video URL','Video URL',5,'src','video'),(49,9,11,'Video Poster image URL','Video Poster image URL','Video Poster image URL','Video Poster image URL',6,'poster','video'),(50,8,13,'Custom HTML','Custom HTML','Custom HTML','Custom HTML',0,'html','stage'),(51,7,13,'Custom CSS','Custom CSS','Custom CSS','Custom CSS',1,'css','stage'),(52,1,14,'Heading','Heading','Heading','Heading',0,'heading','scene'),(53,2,14,'Content','Content','Content','Content',1,'text','scene'),(54,12,14,'Scene Class','Scene Class','Scene Class','Scene Class',2,'activeClass','scene'),(55,7,14,'Scene CSS','Scene CSS','Scene CSS','Scene CSS',3,'activeCss','scene'),(56,1,15,'Heading','Heading','Heading','Heading',0,'heading','headings'),(57,1,15,'Sub-Heading','Sub-Heading','Sub-Heading','Sub-Heading',1,'subheading','headings'),(58,2,15,'Content','Content','Content','Content',2,'text','headings'),(59,15,11,'Lock Type','Lock Type',NULL,'Lock Type',6,'type','lock');
UNLOCK TABLES;

--
-- Table structure for table `task_attr_group`
--

DROP TABLE IF EXISTS `task_attr_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `task_attr_group` (
  `group_id` smallint(7) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `icon` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_attr_group`
--

LOCK TABLES `task_attr_group` WRITE;
INSERT INTO `task_attr_group` VALUES (1,'Image with Heading and Paragraph','panorama'),(2,'Video with Heading and Paragraph','movie'),(3,'Fullscreen Image and Sub-Heading','settings_overscan'),(4,'Static Image with Heading and Paragraph','panorama'),(5,'Static HTML with Heading and Paragraph','settings_ethernet'),(6,'Button Identifier with Heading and Paragraph','touch_app'),(7,'HTML Block','code'),(8,'Timestamp with Heading and Paragraph','alarm_add'),(9,'Question','event_note'),(10,'Answer','event_available'),(11,'Step','filter_none'),(12,'Results','thumb_up'),(13,'Stage','video_label'),(14,'Scene','movie'),(15,'Headings with Content','remove_from_queue');
UNLOCK TABLES;

--
-- Table structure for table `task_attr_type`
--

DROP TABLE IF EXISTS `task_attr_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `task_attr_type` (
  `type_id` tinyint(3) NOT NULL AUTO_INCREMENT,
  `element` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `type` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `versioning` int(5) DEFAULT '1',
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_attr_type`
--

LOCK TABLES `task_attr_type` WRITE;
INSERT INTO `task_attr_type` VALUES (1,'input','text',1),(2,'textarea','textarea',1),(3,'video','video',1),(4,'input','number',1),(5,'input','hidden',1),(6,'select','truefalse',0),(7,'textarea','css',1),(8,'textarea','html',1),(9,'input','image',1),(10,'input','file',1),(11,'input','video',1),(12,'input','class',1),(13,'input','code',1),(14,'input','alt',1),(15,'select','locktype',0);
UNLOCK TABLES;

--
-- Table structure for table `task_attr_type_option`
--

DROP TABLE IF EXISTS `task_attr_type_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `task_attr_type_option` (
  `type_option_id` int(11) NOT NULL AUTO_INCREMENT,
  `type_id` int(11) NOT NULL,
  `value` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `name` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`type_option_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_attr_type_option`
--

LOCK TABLES `task_attr_type_option` WRITE;
INSERT INTO `task_attr_type_option` VALUES (1,6,'true',NULL),(2,6,'false',NULL),(3,15,'int-func',NULL);
UNLOCK TABLES;

--
-- Table structure for table `task_content`
--

DROP TABLE IF EXISTS `task_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `task_content` (
  `task_content_id` int(11) NOT NULL AUTO_INCREMENT,
  `content_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `task_group_id` int(11) NOT NULL,
  `attr_id` int(11) NOT NULL,
  `value` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `version_id` int(11) DEFAULT '1',
  PRIMARY KEY (`task_content_id`),
  UNIQUE KEY `content_id_UNIQUE` (`content_id`)
) ENGINE=InnoDB AUTO_INCREMENT=461 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_content`
--

LOCK TABLES `task_content` WRITE;
INSERT INTO `task_content` VALUES (1,'29-222-1',222,29,'Main Heading',1),(2,'10-222-1',222,10,'Type Heading',1),(3,'11-222-1',222,11,'/media/dst/intro/image01-right.jpg',1),(4,'30-222-1',222,30,'Full-Screen Image Alt',1),(6,'29-222-2',222,29,'Main Heading (METRIC)',2),(7,'29-222-3',222,29,'Main Heading (IMPERIAL)',3),(8,'29-223-1',223,29,'Multitasking',1),(9,'10-223-1',223,10,'Driver Attitude',1),(10,'11-223-1',223,11,'/media/lessons/dst/intro/image01-right.jpg',1),(11,'30-223-1',223,30,'Multitasking - Driver Attitude',1),(12,'36-224-2',224,36,NULL,2),(13,'36-224-4',224,36,NULL,4),(14,'36-224-7',224,36,NULL,7),(15,'48-224-2',224,48,NULL,2),(16,'48-224-4',224,48,NULL,4),(17,'48-224-5',224,48,NULL,5),(18,'48-224-6',224,48,NULL,6),(19,'48-224-7',224,48,NULL,7),(20,'36-225-1',225,36,'Heading',1),(21,'37-225-1',225,37,'0',1),(22,'38-225-1',225,38,'0',1),(23,'40-225-1',225,40,'0',1),(24,'39-225-1',225,39,'Content',1),(25,'48-225-1',225,48,'Video URL',1),(26,'49-225-1',225,49,'Video Poster image URL',1),(29,'6-226-1',226,6,'Video Urlv',1),(30,'28-226-1',226,28,'Video Poster',1),(31,'7-226-1',226,7,'Type Heading Here',1),(32,'8-226-1',226,8,'Default value for paragraph',1),(34,'28-226-3',226,28,'',3),(35,'28-226-7',226,28,'',7),(36,'29-227-1',227,29,'JSON EXPORT',1),(37,'10-227-1',227,10,'First Test Works!',1),(38,'11-227-1',227,11,'assets/temp/test-splash.jpg',1),(39,'30-227-1',227,30,'Full-Screen Image Alt',1),(40,'12-229-1',229,12,'Type Heading',1),(41,'14-229-1',229,14,'Paragraph Content',1),(42,'13-229-1',229,13,'Image Url',1),(43,'35-229-1',229,35,'Image Alt',1),(44,'31-228-1',228,31,'Welcome to the Multitasking exercise. Before we begin, please select the statement that best describes your current view on the subject.',1),(45,'32-228-1',228,32,'2',1),(46,'33-230-1',230,33,'multitasking is a skill that requires training to master',1),(47,'34-230-1',230,34,'3',1),(48,'33-231-1',231,33,'multitasking is impossible',1),(49,'34-231-1',231,34,'5',1),(50,'33-232-1',232,33,'driving while talking on the phone is not considered true multitasking',1),(51,'34-232-1',232,34,'2',1),(52,'33-233-1',233,33,'the human brain can process multiple tasks simultaneously',1),(53,'34-233-1',233,34,'4',1),(54,'33-234-1',234,33,'multitasking is twice as efficient as doing one task at a time',1),(55,'34-234-1',234,34,'2',1),(56,'12-235-1',235,12,'Did you know?',1),(57,'14-235-1',235,14,'It is physically impossible for your brain to focus on more than one complex task at a time.',1),(58,'13-235-1',235,13,'/media/lessons/dst/fact/image01.svg',1),(59,'35-235-1',235,35,'Did you know - Brain Focus',1),(60,'51-236-1',236,51,'<style>@keyframes pulse1 {0% {opacity: 1;} 50% {opacity: 0;} 100% {opacity: 1;}}@keyframes pulse2 {0% {opacity: 0;} 50% {opacity: 1;} 100% {opacity: 0;}}</style>',1),(61,'50-236-1',236,50,'<img src=\'{$dt-mediaUrl}/media/lessons/dst/int2/brain-left.png\' class=\'brain-img brainLeft\'><img src=\'{$dt-mediaUrl}/media/lessons/dst/int2/brain-right.png\' class=\'brain-img brainRight\'><img src=\'{$dt-mediaUrl}/media/lessons/dst/int2/brain-speedometer.png\' class=\'brain-img brainSpeedometer\'><img src=\'{$dt-mediaUrl}/media/lessons/dst/int2/brain-phone.png\' class=\'brain-img brainPhone\'>',1),(62,'52-237-1',237,52,'Why is multitasking impossible?',1),(63,'53-237-1',237,53,'Multitasking cannot be done because your brain is not designed to efficiently juggle two or more tasks at a time. In fact, the term multitasking is not accurate. A more accurate phrase is task switching.',1),(64,'54-237-1',237,54,'scene-0',1),(65,'55-237-1',237,55,'<style>.brainLeft, .brainRight {display: block;}.brainSpeedometer, .brainPhone {display: none;}</style>',1),(66,'52-238-1',238,52,'Single task focus',1),(67,'53-238-1',238,53,'As a person pursues a single goal, both sides of the brain focus on the task at hand.',1),(68,'54-238-1',238,54,'scene-1',1),(69,'55-238-1',238,55,'<style>.brainLeft, .brainRight, .brainSpeedometer {display: block;} .brainPhone {display: none;}</style>',1),(70,'52-239-1',239,52,'Adding activities',1),(71,'53-239-1',239,53,'Many people assume that the brain is able to divide its attention to focus on multiple tasks simultaneously.',1),(72,'54-239-1',239,54,'scene-2',1),(73,'55-239-1',239,55,'<style>.brainLeft, .brainRight, .brainPhone {display: block;} .brainSpeedometer {display: none;}</style>',1),(74,'52-240-1',240,52,'Task switching',1),(75,'53-240-1',240,53,'Instead, the brain rapidly switches focus between the two tasks, with one task being suspended while the other is being focused on.',1),(76,'54-240-1',240,54,'scene-3',1),(77,'55-240-1',240,55,'<style>.brainLeft, .brainRight {display: block;} .brainSpeedometer {opacity: 0; animation-name: pulse1;} .brainPhone {opacity: 0; animation-name: pulse2;}',1),(78,'31-241-1',241,31,'Which statement best represents the main point of the exercise you just completed?',1),(79,'32-241-1',241,32,'0',1),(80,'33-242-1',242,33,'it is difficult to maintain concentration while multitasking',1),(81,'34-242-1',242,34,'1',1),(82,'33-243-1',243,33,'it is difficult to dial a phone number while driving',1),(83,'34-243-1',243,34,'1',1),(84,'33-244-1',244,33,'it is more difficult to drive a car than it is to dial a phone number',1),(85,'34-244-1',244,34,'0',1),(86,'33-245-1',245,33,'it is difficult to maintain a consistent speed while multitasking',1),(87,'34-245-1',245,34,'1',1),(88,'33-246-1',246,33,'it is difficult to multitask without impacting performance',1),(89,'34-246-1',246,34,'2',1),(90,'31-247-1',247,31,'When your brain tries to multitask, it divides its attention to focus on each task simultaneously.',1),(91,'32-247-1',247,32,'0',1),(92,'33-248-1',248,33,'True',1),(93,'34-248-1',248,34,'0',1),(94,'33-249-1',249,33,'False',1),(95,'34-249-1',249,34,'2',1),(96,'51-250-1',250,51,'<style>dl { white-space: nowrap; width: 20%; text-align: right; position: absolute; height: 100%;} dt { font-weight: 600; margin-top: 43%; margin-bottom: 17%; height: 5%; float: right; clear: both;} dd ~ dt {margin-top: 17%;} dd { height: 6%; font-size: 0.75em; float: right; clear: both;} img {width: 80%; right: 0; left: auto;} .graph-mask {transition: all 250ms ease-in-out; position: absolute; width: 0%; height: 100%; overflow: hidden; left: 20%; top: 0;} .graph-mask img { position: relative; width: auto; height: 100%;}</style>',1),(97,'50-250-1',250,50,'<dl><dt>{$dt-person_a} </dt><dd>{$dt-task_1} </dd><dd>{$dt-task_switch} </dd><dd>{$dt-task_2} </dd><dt>{$dt-person_b} </dt><dd>{$dt-task_1} </dd><dd>{$dt-task_switch} </dd><dd>{$dt-task_2} </dd></dl><img src=\'{$dt-mediaUrl}/media/lessons/dst/int3/graph-lines.gif\' class=\'graph graph-lines\'><div class=\'graph-mask\'><img src=\'{$dt-mediaUrl}/media/lessons/dst/int3/graph-bars.gif\' class=\'graph graph-bars\'></div><img src=\'{$dt-mediaUrl}/media/lessons/dst/int3/graph-checks.png\' class=\'graph graph-checks\'>',1),(98,'52-251-1',251,52,'How does multitasking affect performance?',1),(99,'53-251-1',251,53,'When you try to multitask, each task takes longer to complete, and more errors are made, than if you focused on a single task at a time.',1),(100,'54-251-1',251,54,'scene-0',1),(101,'55-251-1',251,55,'<style> .graph, dl, .graph-checks {opacity: 0;} .content-wrapper.scene-0 {top: 50%; position: absolute; transform: translate(0, -50%);}</style>',1),(102,'52-252-1',252,52,'Multitasking in action',1),(103,'53-252-1',252,53,'In this example, watch as 2 people complete 2 tasks. Person A will focus on a single task at a time, and Person B will attempt to multitask.',1),(104,'54-252-1',252,54,'scene-1',1),(105,'55-252-1',252,55,'<style> .graph-mask {width: 0%;} .graph-checks {opacity: 0;}</style>',1),(106,'52-253-1',253,52,'Multitasking in action',1),(107,'53-253-1',253,53,'Both participants start Task 1 at the same time.',1),(108,'54-253-1',253,54,'scene-2',1),(109,'55-253-1',253,55,'<style> .graph-mask {width: 8%;} .graph-checks {opacity: 0;}</style>',1),(110,'52-254-1',254,52,'Goal shifting',1),(111,'53-254-1',254,53,'Person B decides to move from one task to another. This is called goal shifting, and it is the first step the brain must take in order to switch tasks.',1),(112,'54-254-1',254,54,'scene-3',1),(113,'55-254-1',254,55,'<style> .graph-mask {width: 9.75%;} .graph-checks {opacity: 0;}</style>',1),(114,'52-255-1',255,52,'Rule activation',1),(115,'53-255-1',255,53,'Next, the brain turns off the rules for the first task, and turns on the rules it needs to complete the next one. This is called rule activation.',1),(116,'54-255-1',255,54,'scene-4',1),(117,'55-255-1',255,55,'<style> .graph-mask {width: 11.75%;} .graph-checks {opacity: 0;}</style>',1),(118,'52-256-1',256,52,'The task switches',1),(119,'53-256-1',256,53,'After shifting goals and activating new rules, Person B now begins Task 2. Meanwhile, Person A has not needed these processes.',1),(120,'54-256-1',256,54,'scene-5',1),(121,'55-256-1',256,55,'<style> .graph-mask {width: 22%;} .graph-checks {opacity: 0;}</style>',1),(122,'52-257-1',257,52,'Look at what happened',1),(123,'53-257-1',257,53,'Shifting goals and activating new rules does not take long. If done frequently though, that time adds up, and Person B falls behind.',1),(124,'54-257-1',257,54,'scene-6',1),(125,'55-257-1',257,55,'<style> .graph-mask {width: 100%;} .graph-checks {opacity: 1;}</style>',1),(126,'31-258-1',258,31,'What is important to remember about goal switching and rule activation??',1),(127,'32-258-1',258,32,'1',1),(128,'33-259-1',259,33,'they only occur when you focus on a single task',1),(129,'34-259-1',259,34,'0',1),(130,'33-260-1',260,33,'they are instantaneous and require no time to complete?',1),(131,'34-260-1',260,34,'033',1),(132,'33-261-1',261,33,'they occur each time you switch tasks, and take time for the brain to complete',1),(133,'34-261-1',261,34,'2',1),(134,'33-262-1',262,33,'they only actually occur in computers and other technology',1),(135,'34-262-1',262,34,'0',1),(136,'33-263-1',263,33,'they are a myth, and never occur',1),(137,'34-263-1',263,34,'0',1),(138,'12-264-1',264,12,'What are you missing?',1),(139,'14-264-1',264,14,'Drivers may think they can safely multitask by talking on a cellphone while driving, but studies show that those drivers miss about 50% of the visual information around them.',1),(140,'13-264-1',264,13,'/media/lessons/dst/stat/image01.gif',1),(141,'35-264-1',264,35,'Statistical Proof Study',1),(142,'6-265-1',265,6,'/media/lessons/dst/video/video.mp4',1),(143,'28-265-1',265,28,'',1),(144,'7-265-1',265,7,'The dangers of multitasking',1),(145,'8-265-1',265,8,'',1),(146,'31-266-1',266,31,'What is true of drivers who attempt to multitask?',1),(147,'32-266-1',266,32,'0',1),(148,'33-267-1',267,33,'they can still give driving their full attention',1),(149,'34-267-1',267,34,'0',1),(150,'33-268-1',268,33,'they can concentrate on all tasks simultaneously',1),(151,'34-268-1',268,34,'0',1),(152,'33-269-1',269,33,'they are less likely to be involved in a collision than other drivers',1),(153,'34-269-1',269,34,'0',1),(154,'33-270-1',270,33,'they may not process unexpected actions even if they are in plain sight',1),(155,'34-270-1',270,34,'2',1),(156,'33-271-1',271,33,'they do not need to refocus each time they switch between tasks',1),(157,'34-271-1',271,34,'0',1),(158,'31-272-1',272,31,'Now that you have completed the exercise, which statement about multitasking do you most agree with?',1),(159,'32-272-1',272,32,'0',1),(160,'33-273-1',273,33,'multitasking allows anyone to complete several activities simultaneously',1),(161,'34-273-1',273,34,'2',1),(162,'33-274-1',274,33,'switching between two different tasks does not result in any decrease in performance',1),(163,'34-274-1',274,34,'1',1),(164,'33-275-1',275,33,'a person can only concentrate on one complex task at a time',1),(165,'34-275-1',275,34,'5',1),(166,'33-276-1',276,33,'multitasking challenges are only ever a concern while driving',1),(167,'34-276-1',276,34,'4',1),(168,'33-277-1',277,33,'being good at multitasking is just a matter of practice',1),(169,'34-277-1',277,34,'3',1),(170,'56-278-1',278,56,'Congratulations',1),(171,'57-278-1',278,57,'Remember, safe driving requires your full attention.',1),(172,'58-278-1',278,58,'You have successfully completed the Multitasking exercise.',1),(173,'33-279-1',279,33,'TEST ANSWER',1),(174,'34-279-1',279,34,'0',1),(175,'33-280-1',280,33,'Answersdgfsdhgffg',1),(176,'34-280-1',280,34,'Answer Value',1),(185,'29-281-1',281,29,'Hemis-Lesson',1),(186,'10-281-1',281,10,'New lesson sub heading',1),(187,'11-281-1',281,11,'assets/temp/test-splash.jpg',1),(188,'30-281-1',281,30,'Full-Screen Image Alt',1),(189,'33-282-1',282,33,'Answer New One',1),(190,'34-282-1',282,34,'Answer Value',1),(197,'29-227-7',227,29,'Mobile heading',7),(198,'56-283-1',283,56,'Invalid Lesson Code',1),(199,'57-283-1',283,57,'Sub-Heading',1),(200,'58-283-1',283,58,'Content',1),(204,'28-226-5',226,28,NULL,5),(209,'29-284-1',284,29,'Main Heading',1),(210,'10-284-1',284,10,'Test Type Heading',1),(211,'11-284-1',284,11,'/media/2721928484_7db0d78f54_o.jpg',1),(212,'30-284-1',284,30,'Test Full-Screen Image Alt',1),(213,'31-285-1',285,31,'What is the correct answer?',1),(214,'32-285-1',285,32,'0',1),(215,'33-286-1',286,33,'Answer 1',1),(216,'34-286-1',286,34,'2',1),(217,'33-287-1',287,33,'Answer 2',1),(218,'34-287-1',287,34,'0',1),(225,'29-288-1',288,29,'Lesson',1),(226,'11-288-1',288,11,'/media/dst/30145162273_7bf1049041_o.jpg',1),(227,'30-288-1',288,30,'Full-Screen Image Alt',1),(228,'10-288-1',288,10,'Our First',1),(244,'31-289-1',289,31,' How many fingers do you have?',1),(245,'32-289-1',289,32,'0',1),(246,'33-290-1',290,33,'Five',1),(247,'34-290-1',290,34,'2',1),(248,'33-291-1',291,33,'Ten',1),(249,'34-291-1',291,34,'2',1),(254,'10-281-7',281,10,NULL,7),(269,'29-294-1',294,29,'Main Heading',1),(270,'10-294-1',294,10,'Type Heading',1),(271,'11-294-1',294,11,'/media/dst/30145162273_7bf1049041_o.jpg',1),(272,'30-294-1',294,30,'Full-Screen Image Alt',1),(274,'11-227-7',227,11,NULL,7),(282,'17-295-8',295,17,'',8),(283,'15-295-1',295,15,'Type Heading',1),(284,'16-295-1',295,16,'HTML Markupf',1),(288,'36-292-1',292,36,'Try it yourself',1),(289,'37-292-1',292,37,'2',1),(290,'38-292-1',292,38,'2',1),(291,'40-292-1',292,40,'1',1),(292,'39-292-1',292,39,'The following example simulates the experience of attempting to multitask while driving.',1),(293,'48-292-1',292,48,'',1),(294,'49-292-1',292,49,'',1),(295,'41-293-1',293,41,'Look at what happened',1),(296,'42-293-1',293,42,'{$percentageTimeSpeedMaintained}',1),(297,'43-293-1',293,43,'You only maintained the target speed {$percentageTimeSpeedMaintained}% of the time.',1),(298,'44-293-1',293,44,'{$speedDeviationImperial} {$dt-mph}',1),(299,'45-293-1',293,45,'',1),(300,'46-293-1',293,46,'{$distanceTravelledImperial} {$dt-feet}',1),(301,'47-293-1',293,47,'',1),(302,'19-296-1',296,19,'Content Headingy',1),(303,'20-296-1',296,20,'Content',1),(304,'21-296-1',296,21,'Button Identifier',1),(313,'36-297-1',297,36,'',1),(314,'37-297-1',297,37,'0',1),(315,'38-297-1',297,38,'0',1),(316,'40-297-1',297,40,'0',1),(317,'39-297-1',297,39,'',1),(318,'48-297-1',297,48,'',1),(319,'49-297-1',297,49,'',1),(320,'36-298-1',298,36,'',1),(321,'37-298-1',298,37,'0',1),(322,'38-298-1',298,38,'0',1),(323,'40-298-1',298,40,'0',1),(324,'39-298-1',298,39,'',1),(325,'48-298-1',298,48,'',1),(326,'49-298-1',298,49,'',1),(327,'36-299-1',299,36,'',1),(328,'37-299-1',299,37,'0',1),(329,'38-299-1',299,38,'0',1),(330,'40-299-1',299,40,'0',1),(331,'39-299-1',299,39,'',1),(332,'48-299-1',299,48,'',1),(333,'49-299-1',299,49,'',1),(334,'36-300-1',300,36,'',1),(335,'37-300-1',300,37,'0',1),(336,'38-300-1',300,38,'0',1),(337,'40-300-1',300,40,'0',1),(338,'39-300-1',300,39,'Now try to do both at the same time',1),(339,'48-300-1',300,48,'',1),(340,'49-300-1',300,49,'',1),(342,'45-293-2',293,45,'While attempting to multitask, your speed deviated from the target speed by {$speedDeviationMetric} {$dt-kmh}.\n',2),(343,'45-293-3',293,45,'While attempting to multitask, your speed deviated from the target speed by {$speedDeviationImperial} {$dt-mph}.',3),(344,'45-293-4',293,45,'While attempting to multitask, your speed deviated from the target speed by {$speedDeviationImperial} {$dt-mph} ({$speedDeviationMetricEquivalent} {$dt-kmh}).',4),(346,'47-293-2',293,47,'You drove distracted for the {$timeToDial} seconds it took you the dial the phone, and in this time you traveled {$distanceTravelledMetric} {$dt-meters}.',2),(347,'47-293-3',293,47,'You drove distracted for the {$timeToDial} seconds it took you the dial the phone, and in this time you traveled {$distanceTravelledImperial} {$dt-feet}.',3),(348,'47-293-4',293,47,'You drove distracted for the {$timeToDial} seconds it took you the dial the phone, and in this time you traveled {$distanceTravelledMetric} {$dt-meters}({$distanceTravelledImperialEquivalent} {$dt-feet}).',4),(350,'39-297-2',297,39,'1. Press the spacebar until you reach 60 km/h',2),(351,'39-297-3',297,39,'1. Press the spacebar until you reach 40 mph',3),(352,'39-297-4',297,39,'1. Press the spacebar until you reach 40 mph (64 km/h)',4),(353,'39-297-8',297,39,'1. Press the speedometer until you reach 40 mph',8),(354,'39-297-9',297,39,'1. Press the speedometer until you reach 60 km/h',9),(355,'39-297-10',297,39,'1. Press the speedometer until you reach 40 mph (64 km/h)',10),(357,'39-298-2',298,39,'2. Tap the spacebar to maintain 60 km/h',2),(358,'39-298-3',298,39,'2. Tap the spacebar to maintain 40 mph',3),(359,'39-298-4',298,39,'2. Tap the spacebar to maintain 40 mph (64 km/h)',4),(360,'39-298-8',298,39,'2. Tap the speedometer to maintain 40 mph',8),(361,'39-298-9',298,39,'2. Tap the speedometer to maintain 60 km/h',9),(362,'39-298-10',298,39,'2. Tap the speedometer to maintain 40 mph (64 km/h)',10),(364,'39-299-7',299,39,'3. Type the number on the phone',7),(366,'48-300-5',300,48,'/media/lessons/dst/int1/crash01-left.mp4',5),(367,'48-300-6',300,48,'/media/lessons/dst/int1/crash01-right.mp4',6),(369,'49-300-5',300,49,'/media/lessons/dst/int1/crash01-left-poster.jpg',5),(370,'49-300-6',300,49,'/media/lessons/dst/int1/crash01-right-poster.jpg',6),(375,'28-265-5',265,28,'/media/lessons/dst/intro/image01-left.jpg',5),(376,'28-265-6',265,28,'/media/lessons/dst/intro/image01-right.jpg',6),(378,'11-223-5',223,11,'/media/lessons/dst/intro/image01-left.jpg',5),(379,'11-223-6',223,11,'/media/lessons/dst/intro/image01-right.jpg',6),(384,'16-302-1',302,16,'<div>sfgsdg</div>',1),(385,'15-302-1',302,15,'Type Heading',1),(386,'17-302-1',302,17,'Paragraph Content',1),(405,'59-297-1',297,59,'0',1),(406,'59-298-1',298,59,'0',1),(407,'59-299-1',299,59,'0',1),(408,'59-292-1',292,59,'0',1),(409,'59-300-1',300,59,'0',1),(410,'48-301-5',301,48,'/media/lessons/dst/int1/crash01-left.mp4',5),(411,'48-301-6',301,48,'/media/lessons/dst/int1/crash01-right.mp4',6),(412,'36-301-1',301,36,'',1),(413,'37-301-1',301,37,'0',1),(414,'38-301-1',301,38,'0',1),(415,'40-301-1',301,40,'0',1),(416,'39-301-1',301,39,'',1),(417,'49-301-1',301,49,'',1),(418,'59-301-1',301,59,'0',1),(420,'49-301-5',301,49,'/media/lessons/dst/int1/crash01-left-poster.jpg',5),(421,'49-301-6',301,49,'/media/lessons/dst/int1/crash01-right-poster.jpg',6),(422,'44-293-2',293,44,'{$speedDeviationMetric} {$dt-kmh}',2),(423,'44-293-3',293,44,'{$speedDeviationImperial} {$dt-mph}',3),(424,'44-293-4',293,44,'{$speedDeviationImperial} {$dt-mph} ({$speedDeviationMetricEquivalent} {$dt-kmh})',4),(425,'46-293-2',293,46,'{$distanceTravelledMetric} {$dt-meters}',2),(426,'46-293-3',293,46,'{$distanceTravelledImperial} {$dt-feet}',3),(427,'46-293-4',293,46,'{$distanceTravelledMetric} {$dt-meters}({$distanceTravelledImperialEquivalent} {$dt-feet})',4),(429,'36-303-1',303,36,'Heading',1),(430,'49-303-1',303,49,'Video Poster image URL',1),(431,'38-303-1',303,38,'2',1),(432,'37-303-1',303,37,'0',1),(433,'40-303-1',303,40,'2',1),(434,'59-303-1',303,59,'0',1),(435,'48-303-1',303,48,'Video URL',1),(436,'39-303-1',303,39,'Content new',1),(437,'36-304-1',304,36,'Heading',1),(438,'37-304-1',304,37,'2',1),(439,'38-304-1',304,38,'2',1),(440,'40-304-1',304,40,'1',1),(441,'39-304-1',304,39,'Content',1),(442,'48-304-1',304,48,'Video URL',1),(443,'49-304-1',304,49,'Video Poster image URL',1),(444,'59-304-1',304,59,'0',1),(445,'36-306-1',306,36,'Heading',1),(446,'37-306-1',306,37,'0',1),(447,'38-306-1',306,38,'2',1),(448,'39-306-1',306,39,'Content',1),(449,'40-306-1',306,40,'0',1),(450,'48-306-1',306,48,'Video URL',1),(451,'49-306-1',306,49,'Video Poster image URL',1),(452,'59-306-1',306,59,'0',1),(453,'29-307-1',307,29,'Main Heading',1),(454,'10-307-1',307,10,'Type Heading',1),(455,'11-307-1',307,11,'Image Url',1),(456,'30-307-1',307,30,'Full-Screen Image Alt',1),(457,'29-308-1',308,29,'Main Heading',1),(458,'10-308-1',308,10,'Type Heading',1),(459,'11-308-1',308,11,'Image Url',1),(460,'30-308-1',308,30,'Full-Screen Image Alt',1);
UNLOCK TABLES;

--
-- Table structure for table `task_dictionary`
--

DROP TABLE IF EXISTS `task_dictionary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `task_dictionary` (
  `task_dictionary_id` int(11) NOT NULL AUTO_INCREMENT,
  `content_id` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `task_id` int(11) DEFAULT NULL,
  `dictionary_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`task_dictionary_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_dictionary`
--

LOCK TABLES `task_dictionary` WRITE;
INSERT INTO `task_dictionary` VALUES (1,'24-9',24,9),(2,'24-15',24,15),(3,'28-13',28,13),(4,'28-4',28,4),(11,'31-16',31,16),(12,'38-9',38,9),(13,'38-10',38,10),(14,'38-11',38,11),(15,'38-12',38,12),(16,'38-13',38,13),(17,'34-5',34,5),(18,'34-6',34,6),(19,'34-8',34,8),(20,'34-7',34,7);
UNLOCK TABLES;

--
-- Table structure for table `task_group`
--

DROP TABLE IF EXISTS `task_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `task_group` (
  `task_group_id` int(11) NOT NULL AUTO_INCREMENT,
  `task_type_attr_group_id` int(11) NOT NULL,
  `task_id` int(11) NOT NULL,
  `_order` int(11) DEFAULT '0',
  PRIMARY KEY (`task_group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=309 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_group`
--

LOCK TABLES `task_group` WRITE;
INSERT INTO `task_group` VALUES (223,3,31,0),(228,11,32,0),(230,12,32,4),(231,12,32,2),(232,12,32,1),(233,12,32,5),(234,12,32,3),(235,4,33,0),(236,15,36,0),(237,16,36,1),(238,16,36,2),(239,16,36,3),(240,16,36,4),(241,11,35,0),(242,12,35,4),(243,12,35,1),(244,12,35,2),(245,12,35,3),(246,12,35,5),(247,11,37,0),(248,12,37,2),(249,12,37,1),(250,15,38,1),(251,16,38,2),(252,16,38,3),(253,16,38,4),(254,16,38,5),(255,16,38,6),(256,16,38,7),(257,16,38,8),(258,11,39,0),(259,12,39,4),(260,12,39,1),(261,12,39,2),(262,12,39,3),(263,12,39,5),(264,4,40,0),(265,10,41,0),(266,11,42,0),(267,12,42,4),(268,12,42,1),(269,12,42,2),(270,12,42,3),(271,12,42,5),(272,11,43,0),(273,12,43,4),(274,12,43,1),(275,12,43,2),(276,12,43,3),(277,12,43,5),(278,17,44,0),(292,13,34,0),(293,14,34,6),(297,13,34,1),(298,13,34,2),(299,13,34,3),(300,13,34,4),(301,13,34,5),(302,4,40,0),(303,13,46,0),(304,13,48,0),(305,13,48,0),(306,13,46,0),(307,3,31,2),(308,3,31,1);
UNLOCK TABLES;

--
-- Table structure for table `task_type`
--

DROP TABLE IF EXISTS `task_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `task_type` (
  `type_id` int(5) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `code_angular` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `child` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `status_id` int(3) DEFAULT '1',
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_type`
--

LOCK TABLES `task_type` WRITE;
INSERT INTO `task_type` VALUES (1,'Slideshow','displays a set of images','slideshow','slide',1),(2,'Video','displays a video','VideoComponent','detail',1),(3,'Interactive Buttons','Custom interactive buttons','custom-buttons','markup',1),(4,'Splash Page','Landing page of lesson','TitlescreenComponent','content',1),(5,'Image with Content','Static image with headings and paragraph','FigurefigcaptionComponent','content',1),(6,'Static HTML with Headings and Paragraph','Static HTML with Headings and Paragraph','statichtml','content',1),(7,'Interactive with HTML and Buttons','Interactive with HTML and Buttons','inthtml','content',1),(8,'Video with Play / Pause Timestamps','Video with Play / Pause Timestamps','videoplaypaus','timestamp',1),(9,'Assessment','Assessment','assessment','Item',1),(10,'Question','Question','QuestionComponent','Question/Answer',1),(11,'DST Interactive','DST Interactive - Speedometer with phone and video','DST_Int1Component','step',1),(12,'Theatre','Theatre','TheatreComponent','scene',1),(13,'Centered Text Only','Centered Text Only','CentertextComponent','content',1),(42,'dsdfsdf','sdff','sdfsdf','sdfsfdf',1),(43,'sadfsdfsdf','sdfsadfsdf','sdfsdaff','sadfsdf',1),(44,'sdfdsfd','sdfsdf','sdfsdf','sdfsdfsdf',1),(45,'aaa33333','aaa','aaa','aaa',0),(46,'ttttt','tttt','ttt','ttt1',0),(47,'djshfsjkad','xzzx zxcnzxcbnm','asdasdsd','sadasdasd',1),(48,'ASDADA','ASDASDSADA','ASDASD','ASDASDS',1);
UNLOCK TABLES;

--
-- Table structure for table `task_type_attr_group`
--

DROP TABLE IF EXISTS `task_type_attr_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `task_type_attr_group` (
  `group_id` int(11) NOT NULL AUTO_INCREMENT,
  `attr_group_id` smallint(7) NOT NULL,
  `task_type_id` int(5) NOT NULL,
  `_order` int(5) NOT NULL,
  PRIMARY KEY (`group_id`),
  KEY `ta_ty_gr_attr_group_id_idx` (`attr_group_id`),
  KEY `ta_ty_gr_task_type_id_idx` (`task_type_id`),
  CONSTRAINT `ta_ty_gr_attr_group_id` FOREIGN KEY (`attr_group_id`) REFERENCES `task_attr_group` (`group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_type_attr_group`
--

LOCK TABLES `task_type_attr_group` WRITE;
INSERT INTO `task_type_attr_group` VALUES (3,3,4,0),(4,4,5,0),(5,5,6,0),(6,6,7,0),(7,7,7,0),(8,2,8,0),(9,8,8,0),(11,9,10,0),(12,10,10,1),(13,11,11,0),(14,12,11,1),(15,13,12,0),(16,14,12,1),(17,15,13,0),(61,10,2,1),(62,6,2,11),(63,3,2,21),(64,15,2,31),(65,7,2,41),(66,2,2,141),(68,1,1,51),(69,2,1,141),(72,10,9,1);
UNLOCK TABLES;

--
-- Table structure for table `translation`
--

DROP TABLE IF EXISTS `translation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `translation` (
  `translation_id` int(11) NOT NULL AUTO_INCREMENT,
  `type_id` tinyint(3) DEFAULT NULL,
  `item_id` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `value` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `language_code` char(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `parent_type_id` int(11) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `country_code` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `version_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`translation_id`),
  KEY `tra_type_id_idx` (`type_id`),
  CONSTRAINT `tra_type_id` FOREIGN KEY (`type_id`) REFERENCES `content_type` (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=28439 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `translation`
--

LOCK TABLES `translation` WRITE;
INSERT INTO `translation` VALUES (26735,2,'53-240-1','Instead, the brain rapidly switches focus between the two tasks, with one task being suspended while the other is being focused on.','en',NULL,NULL,'NL',NULL),(26738,2,'52-239-1','Adding activities','en',NULL,NULL,'NL',NULL),(26741,2,'53-239-1','Many people assume that the brain is able to divide its attention to focus on multiple tasks simultaneously.','en',NULL,NULL,'NL',NULL),(26744,2,'6-265-1','/media/lessons/dst/video/videos/NLD_EN_TMM.mp4','en',NULL,NULL,'NL',NULL),(26747,2,'52-240-1','Task switching','en',NULL,NULL,'NL',NULL),(26750,2,'7-265-1','The dangers of multitasking','en',NULL,NULL,'NL',NULL),(26753,2,'12-264-1','What are you missing?','en',NULL,NULL,'NL',NULL),(26756,2,'14-264-1','Drivers may think they can safely multitask by talking on a cell phone while driving, but studies show that those drivers miss about 50% of the visual information around them.','en',NULL,NULL,'NL',NULL),(26759,2,'31-258-1','What is important to remember about goal switching and rule activation?','en',NULL,NULL,'NL',NULL),(26762,2,'33-259-1','they only occur when you focus on a single task','en',NULL,NULL,'NL',NULL),(26765,2,'33-260-1','they are instantaneous and require no time to complete','en',NULL,NULL,'NL',NULL),(26768,2,'33-261-1','they occur each time you switch tasks, and take time for the brain to complete','en',NULL,NULL,'NL',NULL),(26771,2,'33-263-1','they are a myth, and never occur','en',NULL,NULL,'NL',NULL),(26774,2,'33-262-1','they only actually occur in computers and other technology','en',NULL,NULL,'NL',NULL),(26777,2,'31-272-1','Now that you have completed the exercise, which statement about multitasking do you most agree with?','en',NULL,NULL,'NL',NULL),(26780,2,'33-273-1','multitasking allows anyone to complete several activities simultaneously','en',NULL,NULL,'NL',NULL),(26783,2,'33-274-1','switching between two different tasks does not result in any decrease in performance','en',NULL,NULL,'NL',NULL),(26786,2,'33-275-1','a person can only concentrate on one complex task at a time','en',NULL,NULL,'NL',NULL),(26789,2,'33-277-1','being good at multitasking is just a matter of practice','en',NULL,NULL,'NL',NULL),(26792,2,'33-276-1','multitasking challenges are only ever a concern while driving','en',NULL,NULL,'NL',NULL),(26795,2,'31-266-1','What is true of drivers who attempt to multitask?','en',NULL,NULL,'NL',NULL),(26798,2,'33-267-1','they can still give driving their full attention','en',NULL,NULL,'NL',NULL),(26801,2,'33-268-1','they can concentrate on all tasks simultaneously','en',NULL,NULL,'NL',NULL),(26804,2,'33-270-1','they may not process unexpected actions even if they are in plain sight','en',NULL,NULL,'NL',NULL),(26807,2,'33-271-1','they do not need to refocus each time they switch between tasks','en',NULL,NULL,'NL',NULL),(26810,2,'33-269-1','they are less likely to be involved in a collision than other drivers','en',NULL,NULL,'NL',NULL),(26813,2,'57-278-1','You have successfully completed the Multitasking exercise.','en',NULL,NULL,'NL',NULL),(26816,2,'56-278-1','Congratulations','en',NULL,NULL,'NL',NULL),(26819,2,'31-228-1','Welcome to the Multitasking exercise. Before we begin, please select the statement that best describes your current view on the subject.','en',NULL,NULL,'NL',NULL),(26822,2,'58-278-1','Remember, safe driving requires your full attention.','en',NULL,NULL,'NL',NULL),(26825,2,'33-230-1','multitasking is a skill that requires training to master','en',NULL,NULL,'NL',NULL),(26828,2,'33-233-1','the human brain can process multiple tasks simultaneously','en',NULL,NULL,'NL',NULL),(26831,2,'33-231-1','multitasking is impossible','en',NULL,NULL,'NL',NULL),(26834,2,'33-232-1','driving while talking on the phone is not considered true multitasking','en',NULL,NULL,'NL',NULL),(26837,2,'31-247-1','When your brain tries to multitask, it divides its attention to focus on each task simultaneously.','en',NULL,NULL,'NL',NULL),(26840,2,'33-234-1','multitasking is twice as efficient as doing one task at a time','en',NULL,NULL,'NL',NULL),(26843,2,'33-248-1','TRUE','en',NULL,NULL,'NL',NULL),(26846,2,'33-249-1','FALSE','en',NULL,NULL,'NL',NULL),(26849,2,'52-251-1','How does multitasking affect performance?','en',NULL,NULL,'NL',NULL),(26852,2,'53-251-1','When you try to multitask, each task takes longer to complete, and more errors are made, than if you focused on a single task at a time.','en',NULL,NULL,'NL',NULL),(26855,2,'53-252-1','In this example, watch as 2 people complete 2 tasks. Person A will focus on a single task at a time, and Person B will attempt to multitask.','en',NULL,NULL,'NL',NULL),(26858,2,'52-252-1','Multitasking in action','en',NULL,NULL,'NL',NULL),(26861,2,'52-253-1','Multitasking in action','en',NULL,NULL,'NL',NULL),(26864,2,'53-253-1','Both participants start Task 1 at the same time.','en',NULL,NULL,'NL',NULL),(26867,2,'52-255-1','Rule activation','en',NULL,NULL,'NL',NULL),(26870,2,'52-254-1','Goal shifting','en',NULL,NULL,'NL',NULL),(26873,2,'53-254-1','Person B decides to move from one task to another. This is called goal shifting, and it is the first step the brain must take in order to switch tasks.','en',NULL,NULL,'NL',NULL),(26876,2,'53-255-1','Next, the brain turns off the rules for the first task, and turns on the rules it needs to complete the next one. This is called rule activation.','en',NULL,NULL,'NL',NULL),(26879,2,'52-257-1','Look at what happened','en',NULL,NULL,'NL',NULL),(26882,2,'53-256-1','After shifting goals and activating new rules, Person B now begins Task 2. Meanwhile, Person A has not needed these processes.','en',NULL,NULL,'NL',NULL),(26885,2,'52-256-1','The task switches','en',NULL,NULL,'NL',NULL),(26888,2,'38-12','Task 2','en',NULL,NULL,'NL',NULL),(26891,2,'53-257-1','Shifting goals and activating new rules does not take long. If done frequently though, that time adds up, and Person B falls behind.','en',NULL,NULL,'NL',NULL),(26894,2,'38-9','Person A','en',NULL,NULL,'NL',NULL),(26897,2,'38-10','Person B','en',NULL,NULL,'NL',NULL),(26900,2,'38-13','Task Switch','en',NULL,NULL,'NL',NULL),(26903,2,'38-11','Task 1','en',NULL,NULL,'NL',NULL),(26906,2,'33-242-1','it is difficult to maintain concentration while multitasking','en',NULL,NULL,'NL',NULL),(26909,2,'33-244-1','it is more difficult to drive a car than it is to dial a phone number','en',NULL,NULL,'NL',NULL),(26912,2,'31-241-1','Which statement best represents the main point of the exercise you just completed?','en',NULL,NULL,'NL',NULL),(26915,2,'33-243-1','it is difficult to dial a phone number while driving','en',NULL,NULL,'NL',NULL),(26918,2,'33-245-1','it is difficult to maintain a consistent speed while multitasking','en',NULL,NULL,'NL',NULL),(26921,2,'10-223-1','Driver Attitude','en',NULL,NULL,'PL',NULL),(26924,2,'12-235-1','Did you know?','en',NULL,NULL,'PL',NULL),(26927,2,'31-16','continue','en',NULL,NULL,'PL',NULL),(26930,2,'29-223-1','Multitasking','en',NULL,NULL,'PL',NULL),(26933,2,'14-235-1','It is physically impossible for your brain to focus on more than one complex task at a time.','en',NULL,NULL,'PL',NULL),(26936,2,'36-292-1','Try it for yourself','en',NULL,NULL,'PL',NULL),(26939,2,'39-292-1','The following example simulates the experience of attempting to multitask while driving.','en',NULL,NULL,'PL',NULL),(26942,2,'45-293-4','While attempting to multitask, your speed deviated from the target speed by {$speedDeviationImperial} mph ({$speedDeviationMetricEquivalent} km/h).','en',NULL,NULL,'PL',NULL),(26945,2,'47-293-3','You drove distracted for the {$timeToDial} seconds it took you to dial the phone, and in this time you traveled {$distanceTravelledImperial} feet.','en',NULL,NULL,'PL',NULL),(26948,2,'47-293-2','You drove distracted for the {$timeToDial} seconds it took you to dial the phone, and in this time you traveled {$distanceTravelledMetric} meters.','en',NULL,NULL,'PL',NULL),(26951,2,'45-293-3','While attempting to multitask, your speed deviated from the target speed by {$speedDeviationImperial} mph.','en',NULL,NULL,'PL',NULL),(26954,2,'47-293-4','You drove distracted for the {$timeToDial} seconds it took you to dial the phone, and in this time you traveled {$distanceTravelledMetric} meters ({$distanceTravelledImperialEquivalent} feet).','en',NULL,NULL,'PL',NULL),(26957,2,'43-293-1','You only maintained the target speed {$percentageTimeSpeedMaintained}% of the time.','en',NULL,NULL,'PL',NULL),(26960,2,'45-293-2','While attempting to multitask, your speed deviated from the target speed by {$speedDeviationMetric} km/h.','en',NULL,NULL,'PL',NULL),(26963,2,'41-293-1','Look at what happened','en',NULL,NULL,'PL',NULL),(26966,2,'39-297-9','1. Press the speedometer until you reach 60 km/h','en',NULL,NULL,'PL',NULL),(26969,2,'39-297-2','1. Press the spacebar until you reach 60 km/h','en',NULL,NULL,'PL',NULL),(26972,2,'39-297-10','1. Press the speedometer until you reach 40 mph (64 km/h)','en',NULL,NULL,'PL',NULL),(26975,2,'39-297-3','1. Press the spacebar until you reach 40 mph','en',NULL,NULL,'PL',NULL),(26978,2,'39-297-4','1. Press the spacebar until you reach 40 mph (64 km/h)','en',NULL,NULL,'PL',NULL),(26981,2,'39-298-8','2. Tap the speedometer to maintain 40 mph','en',NULL,NULL,'PL',NULL),(26984,2,'39-297-8','1. Press the speedometer until you reach 40 mph','en',NULL,NULL,'PL',NULL),(26987,2,'39-298-10','2. Tap the speedometer to maintain 40 mph (64 km/h)','en',NULL,NULL,'PL',NULL),(26990,2,'39-298-3','2. Tap the spacebar to maintain 40 mph','en',NULL,NULL,'PL',NULL),(26993,2,'33-246-1','it is difficult to multitask without impacting performance','en',NULL,NULL,'PL',NULL),(26996,2,'33-245-1','it is difficult to maintain a consistent speed while multitasking','en',NULL,NULL,'PL',NULL),(26999,2,'39-298-2','2. Tap the spacebar to maintain 60 km/h','en',NULL,NULL,'PL',NULL),(27002,2,'39-298-4','2. Tap the spacebar to maintain 40 mph (64 km/h)','en',NULL,NULL,'PL',NULL),(27005,2,'39-298-9','2. Tap the speedometer to maintain 60 km/h','en',NULL,NULL,'PL',NULL),(27008,2,'39-299-1','3. Type the number on the phone using your mouse','en',NULL,NULL,'PL',NULL),(27011,2,'39-299-7','3. Type the number on the phone','en',NULL,NULL,'PL',NULL),(27014,2,'39-300-1','Now try to do both at the same time','en',NULL,NULL,'PL',NULL),(27017,2,'34-8','feet','en',NULL,NULL,'PL',NULL),(27020,2,'34-6','km/h','en',NULL,NULL,'PL',NULL),(27023,2,'34-5','mph','en',NULL,NULL,'PL',NULL),(27026,2,'34-7','meters','en',NULL,NULL,'PL',NULL),(27029,2,'53-237-1','Multitasking cannot be done because your brain is not designed to efficiently juggle two or more tasks at a time. In fact, the term multitasking is not accurate. A more accurate phrase is task switching.','en',NULL,NULL,'PL',NULL),(27032,2,'52-238-1','Single task focus','en',NULL,NULL,'PL',NULL),(27035,2,'52-237-1','Why is multitasking impossible?','en',NULL,NULL,'PL',NULL),(27038,2,'53-239-1','Many people assume that the brain is able to divide its attention to focus on multiple tasks simultaneously.','en',NULL,NULL,'PL',NULL),(27041,2,'53-238-1','As a person pursues a single goal, both sides of the brain focus on the task at hand.','en',NULL,NULL,'PL',NULL),(27044,2,'53-240-1','Instead, the brain rapidly switches focus between the two tasks, with one task being suspended while the other is being focused on.','en',NULL,NULL,'PL',NULL),(27047,2,'6-265-1','/media/lessons/dst/video/videos/POL_EN_TMM.mp4','en',NULL,NULL,'PL',NULL),(27050,2,'52-240-1','Task switching','en',NULL,NULL,'PL',NULL),(27053,2,'52-239-1','Adding activities','en',NULL,NULL,'PL',NULL),(27056,2,'7-265-1','The dangers of multitasking','en',NULL,NULL,'PL',NULL),(27059,2,'12-264-1','What are you missing?','en',NULL,NULL,'PL',NULL),(27062,2,'14-264-1','Drivers may think they can safely multitask by talking on a cell phone while driving, but studies show that those drivers miss about 50% of the visual information around them.','en',NULL,NULL,'PL',NULL),(27065,2,'33-259-1','they only occur when you focus on a single task','en',NULL,NULL,'PL',NULL),(27068,2,'31-258-1','What is important to remember about goal switching and rule activation?','en',NULL,NULL,'PL',NULL),(27071,2,'33-262-1','they only actually occur in computers and other technology','en',NULL,NULL,'PL',NULL),(27074,2,'33-273-1','multitasking allows anyone to complete several activities simultaneously','en',NULL,NULL,'PL',NULL),(27077,2,'33-260-1','they are instantaneous and require no time to complete','en',NULL,NULL,'PL',NULL),(27080,2,'33-261-1','they occur each time you switch tasks, and take time for the brain to complete','en',NULL,NULL,'PL',NULL),(27083,2,'31-272-1','Now that you have completed the exercise, which statement about multitasking do you most agree with?','en',NULL,NULL,'PL',NULL),(27086,2,'33-263-1','they are a myth, and never occur','en',NULL,NULL,'PL',NULL),(27089,2,'33-274-1','switching between two different tasks does not result in any decrease in performance','en',NULL,NULL,'PL',NULL),(27092,2,'33-276-1','multitasking challenges are only ever a concern while driving','en',NULL,NULL,'PL',NULL),(27095,2,'33-275-1','a person can only concentrate on one complex task at a time','en',NULL,NULL,'PL',NULL),(27098,2,'31-266-1','What is true of drivers who attempt to multitask?','en',NULL,NULL,'PL',NULL),(27101,2,'33-277-1','being good at multitasking is just a matter of practice','en',NULL,NULL,'PL',NULL),(27104,2,'33-268-1','they can concentrate on all tasks simultaneously','en',NULL,NULL,'PL',NULL),(27107,2,'33-270-1','they may not process unexpected actions even if they are in plain sight','en',NULL,NULL,'PL',NULL),(27110,2,'33-267-1','they can still give driving their full attention','en',NULL,NULL,'PL',NULL),(27113,2,'33-269-1','they are less likely to be involved in a collision than other drivers','en',NULL,NULL,'PL',NULL),(27116,2,'33-271-1','they do not need to refocus each time they switch between tasks','en',NULL,NULL,'PL',NULL),(27119,2,'58-278-1','Remember, safe driving requires your full attention.','en',NULL,NULL,'PL',NULL),(27122,2,'57-278-1','You have successfully completed the Multitasking exercise.','en',NULL,NULL,'PL',NULL),(27125,2,'56-278-1','Congratulations','en',NULL,NULL,'PL',NULL),(27128,2,'31-228-1','Welcome to the Multitasking exercise. Before we begin, please select the statement that best describes your current view on the subject.','en',NULL,NULL,'PL',NULL),(27131,2,'33-230-1','multitasking is a skill that requires training to master','en',NULL,NULL,'PL',NULL),(27134,2,'33-231-1','multitasking is impossible','en',NULL,NULL,'PL',NULL),(27137,2,'33-233-1','the human brain can process multiple tasks simultaneously','en',NULL,NULL,'PL',NULL),(27140,2,'33-234-1','multitasking is twice as efficient as doing one task at a time','en',NULL,NULL,'PL',NULL),(27143,2,'33-232-1','driving while talking on the phone is not considered true multitasking','en',NULL,NULL,'PL',NULL),(27146,2,'33-249-1','FALSE','en',NULL,NULL,'PL',NULL),(27149,2,'33-248-1','TRUE','en',NULL,NULL,'PL',NULL),(27152,2,'31-247-1','When your brain tries to multitask, it divides its attention to focus on each task simultaneously.','en',NULL,NULL,'PL',NULL),(27155,2,'52-251-1','How does multitasking affect performance?','en',NULL,NULL,'PL',NULL),(27158,2,'53-251-1','When you try to multitask, each task takes longer to complete, and more errors are made, than if you focused on a single task at a time.','en',NULL,NULL,'PL',NULL),(27161,2,'52-252-1','Multitasking in action','en',NULL,NULL,'PL',NULL),(27164,2,'53-253-1','Both participants start Task 1 at the same time.','en',NULL,NULL,'PL',NULL),(27167,2,'53-252-1','In this example, watch as 2 people complete 2 tasks. Person A will focus on a single task at a time, and Person B will attempt to multitask.','en',NULL,NULL,'PL',NULL),(27170,2,'52-253-1','Multitasking in action','en',NULL,NULL,'PL',NULL),(27173,2,'53-254-1','Person B decides to move from one task to another. This is called goal shifting, and it is the first step the brain must take in order to switch tasks.','en',NULL,NULL,'PL',NULL),(27176,2,'52-254-1','Goal shifting','en',NULL,NULL,'PL',NULL),(27179,2,'52-255-1','Rule activation','en',NULL,NULL,'PL',NULL),(27182,2,'52-256-1','The task switches','en',NULL,NULL,'PL',NULL),(27185,2,'53-255-1','Next, the brain turns off the rules for the first task, and turns on the rules it needs to complete the next one. This is called rule activation.','en',NULL,NULL,'PL',NULL),(27188,2,'53-256-1','After shifting goals and activating new rules, Person B now begins Task 2. Meanwhile, Person A has not needed these processes.','en',NULL,NULL,'PL',NULL),(27191,2,'52-257-1','Look at what happened','en',NULL,NULL,'PL',NULL),(27194,2,'53-257-1','Shifting goals and activating new rules does not take long. If done frequently though, that time adds up, and Person B falls behind.','en',NULL,NULL,'PL',NULL),(27197,2,'31-241-1','Which statement best represents the main point of the exercise you just completed?','en',NULL,NULL,'PL',NULL),(27200,2,'38-9','Person A','en',NULL,NULL,'PL',NULL),(27203,2,'38-11','Task 1','en',NULL,NULL,'PL',NULL),(27206,2,'38-13','Task Switch','en',NULL,NULL,'PL',NULL),(27209,2,'38-12','Task 2','en',NULL,NULL,'PL',NULL),(27212,2,'38-10','Person B','en',NULL,NULL,'PL',NULL),(27215,2,'33-242-1','it is difficult to maintain concentration while multitasking','en',NULL,NULL,'PL',NULL),(27218,2,'33-244-1','it is more difficult to drive a car than it is to dial a phone number','en',NULL,NULL,'PL',NULL),(27221,2,'33-243-1','it is difficult to dial a phone number while driving','en',NULL,NULL,'PL',NULL),(27224,2,'31-16','continue','en',NULL,NULL,'PT',NULL),(27227,2,'12-235-1','Did you know?','en',NULL,NULL,'PT',NULL),(27230,2,'36-292-1','Try it for yourself','en',NULL,NULL,'PT',NULL),(27233,2,'29-223-1','Multitasking','en',NULL,NULL,'PT',NULL),(27236,2,'10-223-1','Driver Attitude','en',NULL,NULL,'PT',NULL),(27239,2,'14-235-1','It is physically impossible for your brain to focus on more than one complex task at a time.','en',NULL,NULL,'PT',NULL),(27242,2,'39-292-1','The following example simulates the experience of attempting to multitask while driving.','en',NULL,NULL,'PT',NULL),(27245,2,'47-293-3','You drove distracted for the {$timeToDial} seconds it took you to dial the phone, and in this time you traveled {$distanceTravelledImperial} feet.','en',NULL,NULL,'PT',NULL),(27248,2,'47-293-2','You drove distracted for the {$timeToDial} seconds it took you to dial the phone, and in this time you traveled {$distanceTravelledMetric} meters.','en',NULL,NULL,'PT',NULL),(27251,2,'45-293-4','While attempting to multitask, your speed deviated from the target speed by {$speedDeviationImperial} mph ({$speedDeviationMetricEquivalent} km/h).','en',NULL,NULL,'PT',NULL),(27254,2,'45-293-3','While attempting to multitask, your speed deviated from the target speed by {$speedDeviationImperial} mph.','en',NULL,NULL,'PT',NULL),(27257,2,'47-293-4','You drove distracted for the {$timeToDial} seconds it took you to dial the phone, and in this time you traveled {$distanceTravelledMetric} meters ({$distanceTravelledImperialEquivalent} feet).','en',NULL,NULL,'PT',NULL),(27260,2,'45-293-2','While attempting to multitask, your speed deviated from the target speed by {$speedDeviationMetric} km/h.','en',NULL,NULL,'PT',NULL),(27263,2,'41-293-1','Look at what happened','en',NULL,NULL,'PT',NULL),(27266,2,'43-293-1','You only maintained the target speed {$percentageTimeSpeedMaintained}% of the time.','en',NULL,NULL,'PT',NULL),(27269,2,'39-297-2','1. Press the spacebar until you reach 60 km/h','en',NULL,NULL,'PT',NULL),(27272,2,'39-297-3','1. Press the spacebar until you reach 40 mph','en',NULL,NULL,'PT',NULL),(27275,2,'39-297-10','1. Press the speedometer until you reach 40 mph (64 km/h)','en',NULL,NULL,'PT',NULL),(27278,2,'39-297-9','1. Press the speedometer until you reach 60 km/h','en',NULL,NULL,'PT',NULL),(27281,2,'39-297-4','1. Press the spacebar until you reach 40 mph (64 km/h)','en',NULL,NULL,'PT',NULL),(27284,2,'39-297-8','1. Press the speedometer until you reach 40 mph','en',NULL,NULL,'PT',NULL),(27287,2,'39-298-8','2. Tap the speedometer to maintain 40 mph','en',NULL,NULL,'PT',NULL),(27290,2,'39-298-2','2. Tap the spacebar to maintain 60 km/h','en',NULL,NULL,'PT',NULL),(27293,2,'39-298-10','2. Tap the speedometer to maintain 40 mph (64 km/h)','en',NULL,NULL,'PT',NULL),(27296,2,'39-298-4','2. Tap the spacebar to maintain 40 mph (64 km/h)','en',NULL,NULL,'PT',NULL),(27299,2,'39-298-3','2. Tap the spacebar to maintain 40 mph','en',NULL,NULL,'PT',NULL),(27302,2,'39-298-9','2. Tap the speedometer to maintain 60 km/h','en',NULL,NULL,'PT',NULL),(27305,2,'39-299-1','3. Type the number on the phone using your mouse','en',NULL,NULL,'PT',NULL),(27308,2,'39-299-7','3. Type the number on the phone','en',NULL,NULL,'PT',NULL),(27311,2,'39-300-1','Now try to do both at the same time','en',NULL,NULL,'PT',NULL),(27314,2,'33-245-1','it is difficult to maintain a consistent speed while multitasking','en',NULL,NULL,'PT',NULL),(27317,2,'33-246-1','it is difficult to multitask without impacting performance','en',NULL,NULL,'PT',NULL),(27320,2,'34-7','meters','en',NULL,NULL,'PT',NULL),(27323,2,'34-6','km/h','en',NULL,NULL,'PT',NULL),(27326,2,'34-5','mph','en',NULL,NULL,'PT',NULL),(27329,2,'53-237-1','Multitasking cannot be done because your brain is not designed to efficiently juggle two or more tasks at a time. In fact, the term multitasking is not accurate. A more accurate phrase is task switching.','en',NULL,NULL,'PT',NULL),(27332,2,'34-8','feet','en',NULL,NULL,'PT',NULL),(27335,2,'52-237-1','Why is multitasking impossible?','en',NULL,NULL,'PT',NULL),(27338,2,'52-238-1','Single task focus','en',NULL,NULL,'PT',NULL),(27341,2,'53-238-1','As a person pursues a single goal, both sides of the brain focus on the task at hand.','en',NULL,NULL,'PT',NULL),(27344,2,'52-239-1','Adding activities','en',NULL,NULL,'PT',NULL),(27347,2,'53-239-1','Many people assume that the brain is able to divide its attention to focus on multiple tasks simultaneously.','en',NULL,NULL,'PT',NULL),(27350,2,'53-240-1','Instead, the brain rapidly switches focus between the two tasks, with one task being suspended while the other is being focused on.','en',NULL,NULL,'PT',NULL),(27353,2,'52-240-1','Task switching','en',NULL,NULL,'PT',NULL),(27356,2,'6-265-1','/media/lessons/dst/video/videos/PRT_EN_TMM.mp4','en',NULL,NULL,'PT',NULL),(27359,2,'7-265-1','The dangers of multitasking','en',NULL,NULL,'PT',NULL),(27362,2,'14-264-1','Drivers may think they can safely multitask by talking on a cell phone while driving, but studies show that those drivers miss about 50% of the visual information around them.','en',NULL,NULL,'PT',NULL),(27365,2,'12-264-1','What are you missing?','en',NULL,NULL,'PT',NULL),(27368,2,'33-259-1','they only occur when you focus on a single task','en',NULL,NULL,'PT',NULL),(27371,2,'31-258-1','What is important to remember about goal switching and rule activation?','en',NULL,NULL,'PT',NULL),(27374,2,'33-260-1','they are instantaneous and require no time to complete','en',NULL,NULL,'PT',NULL),(27377,2,'33-261-1','they occur each time you switch tasks, and take time for the brain to complete','en',NULL,NULL,'PT',NULL),(27380,2,'33-262-1','they only actually occur in computers and other technology','en',NULL,NULL,'PT',NULL),(27383,2,'31-272-1','Now that you have completed the exercise, which statement about multitasking do you most agree with?','en',NULL,NULL,'PT',NULL),(27386,2,'33-263-1','they are a myth, and never occur','en',NULL,NULL,'PT',NULL),(27389,2,'33-274-1','switching between two different tasks does not result in any decrease in performance','en',NULL,NULL,'PT',NULL),(27392,2,'33-273-1','multitasking allows anyone to complete several activities simultaneously','en',NULL,NULL,'PT',NULL),(27395,2,'33-276-1','multitasking challenges are only ever a concern while driving','en',NULL,NULL,'PT',NULL),(27398,2,'33-277-1','being good at multitasking is just a matter of practice','en',NULL,NULL,'PT',NULL),(27401,2,'33-275-1','a person can only concentrate on one complex task at a time','en',NULL,NULL,'PT',NULL),(27404,2,'33-268-1','they can concentrate on all tasks simultaneously','en',NULL,NULL,'PT',NULL),(27407,2,'31-266-1','What is true of drivers who attempt to multitask?','en',NULL,NULL,'PT',NULL),(27410,2,'33-267-1','they can still give driving their full attention','en',NULL,NULL,'PT',NULL),(27413,2,'33-270-1','they may not process unexpected actions even if they are in plain sight','en',NULL,NULL,'PT',NULL),(27416,2,'33-269-1','they are less likely to be involved in a collision than other drivers','en',NULL,NULL,'PT',NULL),(27419,2,'33-271-1','they do not need to refocus each time they switch between tasks','en',NULL,NULL,'PT',NULL),(27422,2,'57-278-1','You have successfully completed the Multitasking exercise.','en',NULL,NULL,'PT',NULL),(27425,2,'31-228-1','Welcome to the Multitasking exercise. Before we begin, please select the statement that best describes your current view on the subject.','en',NULL,NULL,'PT',NULL),(27428,2,'58-278-1','Remember, safe driving requires your full attention.','en',NULL,NULL,'PT',NULL),(27431,2,'56-278-1','Congratulations','en',NULL,NULL,'PT',NULL),(27434,2,'33-230-1','multitasking is a skill that requires training to master','en',NULL,NULL,'PT',NULL),(27437,2,'33-231-1','multitasking is impossible','en',NULL,NULL,'PT',NULL),(27440,2,'33-232-1','driving while talking on the phone is not considered true multitasking','en',NULL,NULL,'PT',NULL),(27443,2,'33-234-1','multitasking is twice as efficient as doing one task at a time','en',NULL,NULL,'PT',NULL),(27446,2,'33-233-1','the human brain can process multiple tasks simultaneously','en',NULL,NULL,'PT',NULL),(27449,2,'31-247-1','When your brain tries to multitask, it divides its attention to focus on each task simultaneously.','en',NULL,NULL,'PT',NULL),(27452,2,'33-248-1','TRUE','en',NULL,NULL,'PT',NULL),(27455,2,'33-249-1','FALSE','en',NULL,NULL,'PT',NULL),(27458,2,'53-251-1','When you try to multitask, each task takes longer to complete, and more errors are made, than if you focused on a single task at a time.','en',NULL,NULL,'PT',NULL),(27461,2,'52-251-1','How does multitasking affect performance?','en',NULL,NULL,'PT',NULL),(27464,2,'52-252-1','Multitasking in action','en',NULL,NULL,'PT',NULL),(27467,2,'52-253-1','Multitasking in action','en',NULL,NULL,'PT',NULL),(27470,2,'53-252-1','In this example, watch as 2 people complete 2 tasks. Person A will focus on a single task at a time, and Person B will attempt to multitask.','en',NULL,NULL,'PT',NULL),(27473,2,'53-253-1','Both participants start Task 1 at the same time.','en',NULL,NULL,'PT',NULL),(27476,2,'53-254-1','Person B decides to move from one task to another. This is called goal shifting, and it is the first step the brain must take in order to switch tasks.','en',NULL,NULL,'PT',NULL),(27479,2,'53-255-1','Next, the brain turns off the rules for the first task, and turns on the rules it needs to complete the next one. This is called rule activation.','en',NULL,NULL,'PT',NULL),(27482,2,'52-254-1','Goal shifting','en',NULL,NULL,'PT',NULL),(27485,2,'52-255-1','Rule activation','en',NULL,NULL,'PT',NULL),(27488,2,'53-256-1','After shifting goals and activating new rules, Person B now begins Task 2. Meanwhile, Person A has not needed these processes.','en',NULL,NULL,'PT',NULL),(27491,2,'52-256-1','The task switches','en',NULL,NULL,'PT',NULL),(27494,2,'53-257-1','Shifting goals and activating new rules does not take long. If done frequently though, that time adds up, and Person B falls behind.','en',NULL,NULL,'PT',NULL),(27497,2,'38-9','Person A','en',NULL,NULL,'PT',NULL),(27500,2,'38-12','Task 2','en',NULL,NULL,'PT',NULL),(27503,2,'52-257-1','Look at what happened','en',NULL,NULL,'PT',NULL),(27506,2,'31-241-1','Which statement best represents the main point of the exercise you just completed?','en',NULL,NULL,'PT',NULL),(27509,2,'38-11','Task 1','en',NULL,NULL,'PT',NULL),(27512,2,'38-10','Person B','en',NULL,NULL,'PT',NULL),(27515,2,'33-243-1','it is difficult to dial a phone number while driving','en',NULL,NULL,'PT',NULL),(27518,2,'38-13','Task Switch','en',NULL,NULL,'PT',NULL),(27521,2,'33-242-1','it is difficult to maintain concentration while multitasking','en',NULL,NULL,'PT',NULL),(27524,2,'33-244-1','it is more difficult to drive a car than it is to dial a phone number','en',NULL,NULL,'PT',NULL),(27527,2,'29-223-1','Multitasking','en',NULL,NULL,'RO',NULL),(27530,2,'12-235-1','Did you know?','en',NULL,NULL,'RO',NULL),(27533,2,'10-223-1','Driver Attitude','en',NULL,NULL,'RO',NULL),(27536,2,'31-16','continue','en',NULL,NULL,'RO',NULL),(27539,2,'14-235-1','It is physically impossible for your brain to focus on more than one complex task at a time.','en',NULL,NULL,'RO',NULL),(27542,2,'36-292-1','Try it for yourself','en',NULL,NULL,'RO',NULL),(27545,2,'39-292-1','The following example simulates the experience of attempting to multitask while driving.','en',NULL,NULL,'RO',NULL),(27548,2,'47-293-3','You drove distracted for the {$timeToDial} seconds it took you to dial the phone, and in this time you traveled {$distanceTravelledImperial} feet.','en',NULL,NULL,'RO',NULL),(27551,2,'47-293-2','You drove distracted for the {$timeToDial} seconds it took you to dial the phone, and in this time you traveled {$distanceTravelledMetric} meters.','en',NULL,NULL,'RO',NULL),(27554,2,'43-293-1','You only maintained the target speed {$percentageTimeSpeedMaintained}% of the time.','en',NULL,NULL,'RO',NULL),(27557,2,'45-293-4','While attempting to multitask, your speed deviated from the target speed by {$speedDeviationImperial} mph ({$speedDeviationMetricEquivalent} km/h).','en',NULL,NULL,'RO',NULL),(27560,2,'45-293-3','While attempting to multitask, your speed deviated from the target speed by {$speedDeviationImperial} mph.','en',NULL,NULL,'RO',NULL),(27563,2,'47-293-4','You drove distracted for the {$timeToDial} seconds it took you to dial the phone, and in this time you traveled {$distanceTravelledMetric} meters ({$distanceTravelledImperialEquivalent} feet).','en',NULL,NULL,'RO',NULL),(27566,2,'41-293-1','Look at what happened','en',NULL,NULL,'RO',NULL),(27569,2,'45-293-2','While attempting to multitask, your speed deviated from the target speed by {$speedDeviationMetric} km/h.','en',NULL,NULL,'RO',NULL),(27572,2,'39-297-3','1. Press the spacebar until you reach 40 mph','en',NULL,NULL,'RO',NULL),(27575,2,'39-297-9','1. Press the speedometer until you reach 60 km/h','en',NULL,NULL,'RO',NULL),(27578,2,'39-297-10','1. Press the speedometer until you reach 40 mph (64 km/h)','en',NULL,NULL,'RO',NULL),(27581,2,'39-297-2','1. Press the spacebar until you reach 60 km/h','en',NULL,NULL,'RO',NULL),(27584,2,'39-297-4','1. Press the spacebar until you reach 40 mph (64 km/h)','en',NULL,NULL,'RO',NULL),(27587,2,'39-297-8','1. Press the speedometer until you reach 40 mph','en',NULL,NULL,'RO',NULL),(27590,2,'39-298-8','2. Tap the speedometer to maintain 40 mph','en',NULL,NULL,'RO',NULL),(27593,2,'39-298-10','2. Tap the speedometer to maintain 40 mph (64 km/h)','en',NULL,NULL,'RO',NULL),(27596,2,'39-298-3','2. Tap the spacebar to maintain 40 mph','en',NULL,NULL,'RO',NULL),(27599,2,'39-298-2','2. Tap the spacebar to maintain 60 km/h','en',NULL,NULL,'RO',NULL),(27602,2,'39-298-4','2. Tap the spacebar to maintain 40 mph (64 km/h)','en',NULL,NULL,'RO',NULL),(27605,2,'39-298-9','2. Tap the speedometer to maintain 60 km/h','en',NULL,NULL,'RO',NULL),(27608,2,'39-299-7','3. Type the number on the phone','en',NULL,NULL,'RO',NULL),(27611,2,'39-299-1','3. Type the number on the phone using your mouse','en',NULL,NULL,'RO',NULL),(27614,2,'39-300-1','Now try to do both at the same time','en',NULL,NULL,'RO',NULL),(27617,2,'33-246-1','it is difficult to multitask without impacting performance','en',NULL,NULL,'RO',NULL),(27620,2,'33-245-1','it is difficult to maintain a consistent speed while multitasking','en',NULL,NULL,'RO',NULL),(27623,2,'34-5','mph','en',NULL,NULL,'RO',NULL),(27626,2,'34-8','feet','en',NULL,NULL,'RO',NULL),(27629,2,'34-7','meters','en',NULL,NULL,'RO',NULL),(27632,2,'34-6','km/h','en',NULL,NULL,'RO',NULL),(27635,2,'53-237-1','Multitasking cannot be done because your brain is not designed to efficiently juggle two or more tasks at a time. In fact, the term multitasking is not accurate. A more accurate phrase is task switching.','en',NULL,NULL,'RO',NULL),(27638,2,'52-238-1','Single task focus','en',NULL,NULL,'RO',NULL),(27641,2,'52-237-1','Why is multitasking impossible?','en',NULL,NULL,'RO',NULL),(27644,2,'53-238-1','As a person pursues a single goal, both sides of the brain focus on the task at hand.','en',NULL,NULL,'RO',NULL),(27647,2,'53-239-1','Many people assume that the brain is able to divide its attention to focus on multiple tasks simultaneously.','en',NULL,NULL,'RO',NULL),(27650,2,'52-239-1','Adding activities','en',NULL,NULL,'RO',NULL),(27653,2,'53-240-1','Instead, the brain rapidly switches focus between the two tasks, with one task being suspended while the other is being focused on.','en',NULL,NULL,'RO',NULL),(27656,2,'6-265-1','/media/lessons/dst/video/videos/ROM_EN_TMM.mp4','en',NULL,NULL,'RO',NULL),(27659,2,'52-240-1','Task switching','en',NULL,NULL,'RO',NULL),(27662,2,'7-265-1','The dangers of multitasking','en',NULL,NULL,'RO',NULL),(27665,2,'12-264-1','What are you missing?','en',NULL,NULL,'RO',NULL),(27668,2,'14-264-1','Drivers may think they can safely multitask by talking on a cell phone while driving, but studies show that those drivers miss about 50% of the visual information around them.','en',NULL,NULL,'RO',NULL),(27671,2,'31-258-1','What is important to remember about goal switching and rule activation?','en',NULL,NULL,'RO',NULL),(27674,2,'33-259-1','they only occur when you focus on a single task','en',NULL,NULL,'RO',NULL),(27677,2,'33-262-1','they only actually occur in computers and other technology','en',NULL,NULL,'RO',NULL),(27680,2,'33-260-1','they are instantaneous and require no time to complete','en',NULL,NULL,'RO',NULL),(27683,2,'33-261-1','they occur each time you switch tasks, and take time for the brain to complete','en',NULL,NULL,'RO',NULL),(27686,2,'33-263-1','they are a myth, and never occur','en',NULL,NULL,'RO',NULL),(27689,2,'33-273-1','multitasking allows anyone to complete several activities simultaneously','en',NULL,NULL,'RO',NULL),(27692,2,'33-274-1','switching between two different tasks does not result in any decrease in performance','en',NULL,NULL,'RO',NULL),(27695,2,'31-272-1','Now that you have completed the exercise, which statement about multitasking do you most agree with?','en',NULL,NULL,'RO',NULL),(27698,2,'33-275-1','a person can only concentrate on one complex task at a time','en',NULL,NULL,'RO',NULL),(27701,2,'33-276-1','multitasking challenges are only ever a concern while driving','en',NULL,NULL,'RO',NULL),(27704,2,'33-277-1','being good at multitasking is just a matter of practice','en',NULL,NULL,'RO',NULL),(27707,2,'31-266-1','What is true of drivers who attempt to multitask?','en',NULL,NULL,'RO',NULL),(27710,2,'33-267-1','they can still give driving their full attention','en',NULL,NULL,'RO',NULL),(27713,2,'33-269-1','they are less likely to be involved in a collision than other drivers','en',NULL,NULL,'RO',NULL),(27716,2,'33-270-1','they may not process unexpected actions even if they are in plain sight','en',NULL,NULL,'RO',NULL),(27719,2,'33-268-1','they can concentrate on all tasks simultaneously','en',NULL,NULL,'RO',NULL),(27722,2,'57-278-1','You have successfully completed the Multitasking exercise.','en',NULL,NULL,'RO',NULL),(27725,2,'33-271-1','they do not need to refocus each time they switch between tasks','en',NULL,NULL,'RO',NULL),(27728,2,'56-278-1','Congratulations','en',NULL,NULL,'RO',NULL),(27731,2,'58-278-1','Remember, safe driving requires your full attention.','en',NULL,NULL,'RO',NULL),(27734,2,'31-228-1','Welcome to the Multitasking exercise. Before we begin, please select the statement that best describes your current view on the subject.','en',NULL,NULL,'RO',NULL),(27737,2,'33-231-1','multitasking is impossible','en',NULL,NULL,'RO',NULL),(27740,2,'33-230-1','multitasking is a skill that requires training to master','en',NULL,NULL,'RO',NULL),(27743,2,'33-232-1','driving while talking on the phone is not considered true multitasking','en',NULL,NULL,'RO',NULL),(27746,2,'33-234-1','multitasking is twice as efficient as doing one task at a time','en',NULL,NULL,'RO',NULL),(27749,2,'33-233-1','the human brain can process multiple tasks simultaneously','en',NULL,NULL,'RO',NULL),(27752,2,'33-248-1','TRUE','en',NULL,NULL,'RO',NULL),(27755,2,'31-247-1','When your brain tries to multitask, it divides its attention to focus on each task simultaneously.','en',NULL,NULL,'RO',NULL),(27758,2,'33-249-1','FALSE','en',NULL,NULL,'RO',NULL),(27761,2,'52-251-1','How does multitasking affect performance?','en',NULL,NULL,'RO',NULL),(27764,2,'52-252-1','Multitasking in action','en',NULL,NULL,'RO',NULL),(27767,2,'53-251-1','When you try to multitask, each task takes longer to complete, and more errors are made, than if you focused on a single task at a time.','en',NULL,NULL,'RO',NULL),(27770,2,'53-252-1','In this example, watch as 2 people complete 2 tasks. Person A will focus on a single task at a time, and Person B will attempt to multitask.','en',NULL,NULL,'RO',NULL),(27773,2,'53-253-1','Both participants start Task 1 at the same time.','en',NULL,NULL,'RO',NULL),(27776,2,'52-253-1','Multitasking in action','en',NULL,NULL,'RO',NULL),(27779,2,'53-254-1','Person B decides to move from one task to another. This is called goal shifting, and it is the first step the brain must take in order to switch tasks.','en',NULL,NULL,'RO',NULL),(27782,2,'52-254-1','Goal shifting','en',NULL,NULL,'RO',NULL),(27785,2,'53-255-1','Next, the brain turns off the rules for the first task, and turns on the rules it needs to complete the next one. This is called rule activation.','en',NULL,NULL,'RO',NULL),(27788,2,'52-255-1','Rule activation','en',NULL,NULL,'RO',NULL),(27791,2,'52-256-1','The task switches','en',NULL,NULL,'RO',NULL),(27794,2,'53-256-1','After shifting goals and activating new rules, Person B now begins Task 2. Meanwhile, Person A has not needed these processes.','en',NULL,NULL,'RO',NULL),(27797,2,'38-12','Task 2','en',NULL,NULL,'RO',NULL),(27800,2,'53-257-1','Shifting goals and activating new rules does not take long. If done frequently though, that time adds up, and Person B falls behind.','en',NULL,NULL,'RO',NULL),(27803,2,'52-257-1','Look at what happened','en',NULL,NULL,'RO',NULL),(27806,2,'38-10','Person B','en',NULL,NULL,'RO',NULL),(27809,2,'38-9','Person A','en',NULL,NULL,'RO',NULL),(27812,2,'38-13','Task Switch','en',NULL,NULL,'RO',NULL),(27815,2,'31-241-1','Which statement best represents the main point of the exercise you just completed?','en',NULL,NULL,'RO',NULL),(27818,2,'38-11','Task 1','en',NULL,NULL,'RO',NULL),(27821,2,'33-242-1','it is difficult to maintain concentration while multitasking','en',NULL,NULL,'RO',NULL),(27824,2,'33-244-1','it is more difficult to drive a car than it is to dial a phone number','en',NULL,NULL,'RO',NULL),(27827,2,'33-243-1','it is difficult to dial a phone number while driving','en',NULL,NULL,'RO',NULL),(27830,2,'31-16','continue','en',NULL,NULL,'RU',NULL),(27833,2,'14-235-1','It is physically impossible for your brain to focus on more than one complex task at a time.','en',NULL,NULL,'RU',NULL),(27836,2,'10-223-1','Driver Attitude','en',NULL,NULL,'RU',NULL),(27839,2,'29-223-1','Multitasking','en',NULL,NULL,'RU',NULL),(27842,2,'12-235-1','Did you know?','en',NULL,NULL,'RU',NULL),(27845,2,'36-292-1','Try it for yourself','en',NULL,NULL,'RU',NULL),(27848,2,'39-292-1','The following example simulates the experience of attempting to multitask while driving.','en',NULL,NULL,'RU',NULL),(27851,2,'47-293-3','You drove distracted for the {$timeToDial} seconds it took you to dial the phone, and in this time you traveled {$distanceTravelledImperial} feet.','en',NULL,NULL,'RU',NULL),(27854,2,'47-293-2','You drove distracted for the {$timeToDial} seconds it took you to dial the phone, and in this time you traveled {$distanceTravelledMetric} meters.','en',NULL,NULL,'RU',NULL),(27857,2,'45-293-4','While attempting to multitask, your speed deviated from the target speed by {$speedDeviationImperial} mph ({$speedDeviationMetricEquivalent} km/h).','en',NULL,NULL,'RU',NULL),(27860,2,'45-293-3','While attempting to multitask, your speed deviated from the target speed by {$speedDeviationImperial} mph.','en',NULL,NULL,'RU',NULL),(27863,2,'43-293-1','You only maintained the target speed {$percentageTimeSpeedMaintained}% of the time.','en',NULL,NULL,'RU',NULL),(27866,2,'47-293-4','You drove distracted for the {$timeToDial} seconds it took you to dial the phone, and in this time you traveled {$distanceTravelledMetric} meters ({$distanceTravelledImperialEquivalent} feet).','en',NULL,NULL,'RU',NULL),(27869,2,'45-293-2','While attempting to multitask, your speed deviated from the target speed by {$speedDeviationMetric} km/h.','en',NULL,NULL,'RU',NULL),(27872,2,'39-297-10','1. Press the speedometer until you reach 40 mph (64 km/h)','en',NULL,NULL,'RU',NULL),(27875,2,'41-293-1','Look at what happened','en',NULL,NULL,'RU',NULL),(27878,2,'39-297-9','1. Press the speedometer until you reach 60 km/h','en',NULL,NULL,'RU',NULL),(27881,2,'39-297-2','1. Press the spacebar until you reach 60 km/h','en',NULL,NULL,'RU',NULL),(27884,2,'39-297-4','1. Press the spacebar until you reach 40 mph (64 km/h)','en',NULL,NULL,'RU',NULL),(27887,2,'39-297-3','1. Press the spacebar until you reach 40 mph','en',NULL,NULL,'RU',NULL),(27890,2,'39-297-8','1. Press the speedometer until you reach 40 mph','en',NULL,NULL,'RU',NULL),(27893,2,'39-298-8','2. Tap the speedometer to maintain 40 mph','en',NULL,NULL,'RU',NULL),(27896,2,'39-298-10','2. Tap the speedometer to maintain 40 mph (64 km/h)','en',NULL,NULL,'RU',NULL),(27899,2,'39-298-2','2. Tap the spacebar to maintain 60 km/h','en',NULL,NULL,'RU',NULL),(27902,2,'39-298-3','2. Tap the spacebar to maintain 40 mph','en',NULL,NULL,'RU',NULL),(27905,2,'39-298-4','2. Tap the spacebar to maintain 40 mph (64 km/h)','en',NULL,NULL,'RU',NULL),(27908,2,'39-298-9','2. Tap the speedometer to maintain 60 km/h','en',NULL,NULL,'RU',NULL),(27911,2,'39-299-1','3. Type the number on the phone using your mouse','en',NULL,NULL,'RU',NULL),(27914,2,'39-299-7','3. Type the number on the phone','en',NULL,NULL,'RU',NULL),(27917,2,'39-300-1','Now try to do both at the same time','en',NULL,NULL,'RU',NULL),(27920,2,'33-245-1','it is difficult to maintain a consistent speed while multitasking','en',NULL,NULL,'RU',NULL),(27923,2,'33-246-1','it is difficult to multitask without impacting performance','en',NULL,NULL,'RU',NULL),(27926,2,'34-7','meters','en',NULL,NULL,'RU',NULL),(27929,2,'34-8','feet','en',NULL,NULL,'RU',NULL),(27932,2,'53-237-1','Multitasking cannot be done because your brain is not designed to efficiently juggle two or more tasks at a time. In fact, the term multitasking is not accurate. A more accurate phrase is task switching.','en',NULL,NULL,'RU',NULL),(27935,2,'34-6','km/h','en',NULL,NULL,'RU',NULL),(27938,2,'34-5','mph','en',NULL,NULL,'RU',NULL),(27941,2,'52-238-1','Single task focus','en',NULL,NULL,'RU',NULL),(27944,2,'52-237-1','Why is multitasking impossible?','en',NULL,NULL,'RU',NULL),(27947,2,'53-239-1','Many people assume that the brain is able to divide its attention to focus on multiple tasks simultaneously.','en',NULL,NULL,'RU',NULL),(27950,2,'53-238-1','As a person pursues a single goal, both sides of the brain focus on the task at hand.','en',NULL,NULL,'RU',NULL),(27953,2,'53-240-1','Instead, the brain rapidly switches focus between the two tasks, with one task being suspended while the other is being focused on.','en',NULL,NULL,'RU',NULL),(27956,2,'6-265-1','/media/lessons/dst/video/videos/RUS_EN_TMM.mp4','en',NULL,NULL,'RU',NULL),(27959,2,'52-239-1','Adding activities','en',NULL,NULL,'RU',NULL),(27962,2,'52-240-1','Task switching','en',NULL,NULL,'RU',NULL),(27965,2,'12-264-1','What are you missing?','en',NULL,NULL,'RU',NULL),(27968,2,'7-265-1','The dangers of multitasking','en',NULL,NULL,'RU',NULL),(27971,2,'31-258-1','What is important to remember about goal switching and rule activation?','en',NULL,NULL,'RU',NULL),(27974,2,'33-259-1','they only occur when you focus on a single task','en',NULL,NULL,'RU',NULL),(27977,2,'14-264-1','Drivers may think they can safely multitask by talking on a cell phone while driving, but studies show that those drivers miss about 50% of the visual information around them.','en',NULL,NULL,'RU',NULL),(27980,2,'33-261-1','they occur each time you switch tasks, and take time for the brain to complete','en',NULL,NULL,'RU',NULL),(27983,2,'33-260-1','they are instantaneous and require no time to complete','en',NULL,NULL,'RU',NULL),(27986,2,'33-262-1','they only actually occur in computers and other technology','en',NULL,NULL,'RU',NULL),(27989,2,'31-272-1','Now that you have completed the exercise, which statement about multitasking do you most agree with?','en',NULL,NULL,'RU',NULL),(27992,2,'33-263-1','they are a myth, and never occur','en',NULL,NULL,'RU',NULL),(27995,2,'33-273-1','multitasking allows anyone to complete several activities simultaneously','en',NULL,NULL,'RU',NULL),(27998,2,'33-274-1','switching between two different tasks does not result in any decrease in performance','en',NULL,NULL,'RU',NULL),(28001,2,'33-276-1','multitasking challenges are only ever a concern while driving','en',NULL,NULL,'RU',NULL),(28004,2,'33-275-1','a person can only concentrate on one complex task at a time','en',NULL,NULL,'RU',NULL),(28007,2,'33-277-1','being good at multitasking is just a matter of practice','en',NULL,NULL,'RU',NULL),(28010,2,'31-266-1','What is true of drivers who attempt to multitask?','en',NULL,NULL,'RU',NULL),(28013,2,'33-268-1','they can concentrate on all tasks simultaneously','en',NULL,NULL,'RU',NULL),(28016,2,'33-267-1','they can still give driving their full attention','en',NULL,NULL,'RU',NULL),(28019,2,'33-271-1','they do not need to refocus each time they switch between tasks','en',NULL,NULL,'RU',NULL),(28022,2,'56-278-1','Congratulations','en',NULL,NULL,'RU',NULL),(28025,2,'57-278-1','You have successfully completed the Multitasking exercise.','en',NULL,NULL,'RU',NULL),(28028,2,'33-270-1','they may not process unexpected actions even if they are in plain sight','en',NULL,NULL,'RU',NULL),(28031,2,'33-269-1','they are less likely to be involved in a collision than other drivers','en',NULL,NULL,'RU',NULL),(28034,2,'58-278-1','Remember, safe driving requires your full attention.','en',NULL,NULL,'RU',NULL),(28037,2,'31-228-1','Welcome to the Multitasking exercise. Before we begin, please select the statement that best describes your current view on the subject.','en',NULL,NULL,'RU',NULL),(28040,2,'33-230-1','multitasking is a skill that requires training to master','en',NULL,NULL,'RU',NULL),(28043,2,'33-231-1','multitasking is impossible','en',NULL,NULL,'RU',NULL),(28046,2,'33-233-1','the human brain can process multiple tasks simultaneously','en',NULL,NULL,'RU',NULL),(28049,2,'33-234-1','multitasking is twice as efficient as doing one task at a time','en',NULL,NULL,'RU',NULL),(28052,2,'33-232-1','driving while talking on the phone is not considered true multitasking','en',NULL,NULL,'RU',NULL),(28055,2,'33-249-1','FALSE','en',NULL,NULL,'RU',NULL),(28058,2,'31-247-1','When your brain tries to multitask, it divides its attention to focus on each task simultaneously.','en',NULL,NULL,'RU',NULL),(28061,2,'33-248-1','TRUE','en',NULL,NULL,'RU',NULL),(28064,2,'53-251-1','When you try to multitask, each task takes longer to complete, and more errors are made, than if you focused on a single task at a time.','en',NULL,NULL,'RU',NULL),(28067,2,'52-251-1','How does multitasking affect performance?','en',NULL,NULL,'RU',NULL),(28070,2,'52-252-1','Multitasking in action','en',NULL,NULL,'RU',NULL),(28073,2,'53-253-1','Both participants start Task 1 at the same time.','en',NULL,NULL,'RU',NULL),(28076,2,'53-252-1','In this example, watch as 2 people complete 2 tasks. Person A will focus on a single task at a time, and Person B will attempt to multitask.','en',NULL,NULL,'RU',NULL),(28079,2,'52-253-1','Multitasking in action','en',NULL,NULL,'RU',NULL),(28082,2,'52-254-1','Goal shifting','en',NULL,NULL,'RU',NULL),(28085,2,'53-254-1','Person B decides to move from one task to another. This is called goal shifting, and it is the first step the brain must take in order to switch tasks.','en',NULL,NULL,'RU',NULL),(28088,2,'52-255-1','Rule activation','en',NULL,NULL,'RU',NULL),(28091,2,'53-255-1','Next, the brain turns off the rules for the first task, and turns on the rules it needs to complete the next one. This is called rule activation.','en',NULL,NULL,'RU',NULL),(28094,2,'52-256-1','The task switches','en',NULL,NULL,'RU',NULL),(28097,2,'52-257-1','Look at what happened','en',NULL,NULL,'RU',NULL),(28100,2,'53-256-1','After shifting goals and activating new rules, Person B now begins Task 2. Meanwhile, Person A has not needed these processes.','en',NULL,NULL,'RU',NULL),(28103,2,'53-257-1','Shifting goals and activating new rules does not take long. If done frequently though, that time adds up, and Person B falls behind.','en',NULL,NULL,'RU',NULL),(28106,2,'38-9','Person A','en',NULL,NULL,'RU',NULL),(28109,2,'38-13','Task Switch','en',NULL,NULL,'RU',NULL),(28112,2,'38-12','Task 2','en',NULL,NULL,'RU',NULL),(28115,2,'31-241-1','Which statement best represents the main point of the exercise you just completed?','en',NULL,NULL,'RU',NULL),(28118,2,'38-10','Person B','en',NULL,NULL,'RU',NULL),(28121,2,'38-11','Task 1','en',NULL,NULL,'RU',NULL),(28124,2,'33-243-1','it is difficult to dial a phone number while driving','en',NULL,NULL,'RU',NULL),(28127,2,'33-242-1','it is difficult to maintain concentration while multitasking','en',NULL,NULL,'RU',NULL),(28130,2,'33-244-1','it is more difficult to drive a car than it is to dial a phone number','en',NULL,NULL,'RU',NULL),(28133,2,'6-265-1','/media/lessons/dst/video/videos/SWE_EN_TMM.mp4','en',NULL,NULL,'SE',NULL),(28136,2,'10-223-1','Driver Attitude','en',NULL,NULL,'TH',NULL),(28139,2,'29-223-1','Multitasking','en',NULL,NULL,'TH',NULL),(28142,2,'31-16','continue','en',NULL,NULL,'TH',NULL),(28145,2,'12-235-1','Did you know?','en',NULL,NULL,'TH',NULL),(28148,2,'14-235-1','It is physically impossible for your brain to focus on more than one complex task at a time.','en',NULL,NULL,'TH',NULL),(28151,2,'36-292-1','Try it for yourself','en',NULL,NULL,'TH',NULL),(28154,2,'39-292-1','The following example simulates the experience of attempting to multitask while driving.','en',NULL,NULL,'TH',NULL),(28157,2,'47-293-3','You drove distracted for the {$timeToDial} seconds it took you to dial the phone, and in this time you traveled {$distanceTravelledImperial} feet.','en',NULL,NULL,'TH',NULL),(28160,2,'47-293-2','You drove distracted for the {$timeToDial} seconds it took you to dial the phone, and in this time you traveled {$distanceTravelledMetric} meters.','en',NULL,NULL,'TH',NULL),(28163,2,'45-293-4','While attempting to multitask, your speed deviated from the target speed by {$speedDeviationImperial} mph ({$speedDeviationMetricEquivalent} km/h).','en',NULL,NULL,'TH',NULL),(28166,2,'45-293-3','While attempting to multitask, your speed deviated from the target speed by {$speedDeviationImperial} mph.','en',NULL,NULL,'TH',NULL),(28169,2,'43-293-1','You only maintained the target speed {$percentageTimeSpeedMaintained}% of the time.','en',NULL,NULL,'TH',NULL),(28172,2,'47-293-4','You drove distracted for the {$timeToDial} seconds it took you to dial the phone, and in this time you traveled {$distanceTravelledMetric} meters ({$distanceTravelledImperialEquivalent} feet).','en',NULL,NULL,'TH',NULL),(28175,2,'45-293-2','While attempting to multitask, your speed deviated from the target speed by {$speedDeviationMetric} km/h.','en',NULL,NULL,'TH',NULL),(28178,2,'41-293-1','Look at what happened','en',NULL,NULL,'TH',NULL),(28181,2,'39-297-10','1. Press the speedometer until you reach 40 mph (64 km/h)','en',NULL,NULL,'TH',NULL),(28184,2,'39-297-9','1. Press the speedometer until you reach 60 km/h','en',NULL,NULL,'TH',NULL),(28187,2,'39-297-2','1. Press the spacebar until you reach 60 km/h','en',NULL,NULL,'TH',NULL),(28190,2,'39-297-3','1. Press the spacebar until you reach 40 mph','en',NULL,NULL,'TH',NULL),(28193,2,'39-297-4','1. Press the spacebar until you reach 40 mph (64 km/h)','en',NULL,NULL,'TH',NULL),(28196,2,'39-297-8','1. Press the speedometer until you reach 40 mph','en',NULL,NULL,'TH',NULL),(28199,2,'39-298-8','2. Tap the speedometer to maintain 40 mph','en',NULL,NULL,'TH',NULL),(28202,2,'39-298-10','2. Tap the speedometer to maintain 40 mph (64 km/h)','en',NULL,NULL,'TH',NULL),(28205,2,'39-298-3','2. Tap the spacebar to maintain 40 mph','en',NULL,NULL,'TH',NULL),(28208,2,'39-298-2','2. Tap the spacebar to maintain 60 km/h','en',NULL,NULL,'TH',NULL),(28211,2,'39-298-4','2. Tap the spacebar to maintain 40 mph (64 km/h)','en',NULL,NULL,'TH',NULL),(28214,2,'39-298-9','2. Tap the speedometer to maintain 60 km/h','en',NULL,NULL,'TH',NULL),(28217,2,'39-299-1','3. Type the number on the phone using your mouse','en',NULL,NULL,'TH',NULL),(28220,2,'39-299-7','3. Type the number on the phone','en',NULL,NULL,'TH',NULL),(28223,2,'39-300-1','Now try to do both at the same time','en',NULL,NULL,'TH',NULL),(28226,2,'34-7','meters','en',NULL,NULL,'TH',NULL),(28229,2,'34-6','km/h','en',NULL,NULL,'TH',NULL),(28232,2,'34-5','mph','en',NULL,NULL,'TH',NULL),(28235,2,'34-8','feet','en',NULL,NULL,'TH',NULL),(28238,2,'53-237-1','Multitasking cannot be done because your brain is not designed to efficiently juggle two or more tasks at a time. In fact, the term multitasking is not accurate. A more accurate phrase is task switching.','en',NULL,NULL,'TH',NULL),(28241,2,'52-237-1','Why is multitasking impossible?','en',NULL,NULL,'TH',NULL),(28244,2,'52-238-1','Single task focus','en',NULL,NULL,'TH',NULL),(28247,2,'53-238-1','As a person pursues a single goal, both sides of the brain focus on the task at hand.','en',NULL,NULL,'TH',NULL),(28250,2,'53-239-1','Many people assume that the brain is able to divide its attention to focus on multiple tasks simultaneously.','en',NULL,NULL,'TH',NULL),(28253,2,'52-239-1','Adding activities','en',NULL,NULL,'TH',NULL),(28256,2,'53-240-1','Instead, the brain rapidly switches focus between the two tasks, with one task being suspended while the other is being focused on.','en',NULL,NULL,'TH',NULL),(28259,2,'52-240-1','Task switching','en',NULL,NULL,'TH',NULL),(28262,2,'6-265-1','/media/lessons/dst/video/videos/THA_EN_TMM.mp4','en',NULL,NULL,'TH',NULL),(28265,2,'7-265-1','The dangers of multitasking','en',NULL,NULL,'TH',NULL),(28268,2,'12-264-1','What are you missing?','en',NULL,NULL,'TH',NULL),(28271,2,'14-264-1','Drivers may think they can safely multitask by talking on a cell phone while driving, but studies show that those drivers miss about 50% of the visual information around them.','en',NULL,NULL,'TH',NULL),(28274,2,'31-258-1','What is important to remember about goal switching and rule activation?','en',NULL,NULL,'TH',NULL),(28277,2,'33-259-1','they only occur when you focus on a single task','en',NULL,NULL,'TH',NULL),(28280,2,'33-260-1','they are instantaneous and require no time to complete','en',NULL,NULL,'TH',NULL),(28283,2,'33-261-1','they occur each time you switch tasks, and take time for the brain to complete','en',NULL,NULL,'TH',NULL),(28286,2,'33-262-1','they only actually occur in computers and other technology','en',NULL,NULL,'TH',NULL),(28289,2,'33-263-1','they are a myth, and never occur','en',NULL,NULL,'TH',NULL),(28292,2,'31-272-1','Now that you have completed the exercise, which statement about multitasking do you most agree with?','en',NULL,NULL,'TH',NULL),(28295,2,'33-273-1','multitasking allows anyone to complete several activities simultaneously','en',NULL,NULL,'TH',NULL),(28298,2,'33-274-1','switching between two different tasks does not result in any decrease in performance','en',NULL,NULL,'TH',NULL),(28301,2,'33-275-1','a person can only concentrate on one complex task at a time','en',NULL,NULL,'TH',NULL),(28304,2,'33-276-1','multitasking challenges are only ever a concern while driving','en',NULL,NULL,'TH',NULL),(28307,2,'33-277-1','being good at multitasking is just a matter of practice','en',NULL,NULL,'TH',NULL),(28310,2,'31-266-1','What is true of drivers who attempt to multitask?','en',NULL,NULL,'TH',NULL),(28313,2,'33-267-1','they can still give driving their full attention','en',NULL,NULL,'TH',NULL),(28316,2,'33-268-1','they can concentrate on all tasks simultaneously','en',NULL,NULL,'TH',NULL),(28319,2,'33-269-1','they are less likely to be involved in a collision than other drivers','en',NULL,NULL,'TH',NULL),(28322,2,'33-270-1','they may not process unexpected actions even if they are in plain sight','en',NULL,NULL,'TH',NULL),(28325,2,'33-271-1','they do not need to refocus each time they switch between tasks','en',NULL,NULL,'TH',NULL),(28328,2,'56-278-1','Congratulations','en',NULL,NULL,'TH',NULL),(28331,2,'57-278-1','You have successfully completed the Multitasking exercise.','en',NULL,NULL,'TH',NULL),(28334,2,'58-278-1','Remember, safe driving requires your full attention.','en',NULL,NULL,'TH',NULL),(28337,2,'31-228-1','Welcome to the Multitasking exercise. Before we begin, please select the statement that best describes your current view on the subject.','en',NULL,NULL,'TH',NULL),(28340,2,'33-230-1','multitasking is a skill that requires training to master','en',NULL,NULL,'TH',NULL),(28343,2,'33-231-1','multitasking is impossible','en',NULL,NULL,'TH',NULL),(28346,2,'33-232-1','driving while talking on the phone is not considered true multitasking','en',NULL,NULL,'TH',NULL),(28349,2,'33-233-1','the human brain can process multiple tasks simultaneously','en',NULL,NULL,'TH',NULL),(28352,2,'33-234-1','multitasking is twice as efficient as doing one task at a time','en',NULL,NULL,'TH',NULL),(28355,2,'31-247-1','When your brain tries to multitask, it divides its attention to focus on each task simultaneously.','en',NULL,NULL,'TH',NULL),(28358,2,'33-248-1','TRUE','en',NULL,NULL,'TH',NULL),(28361,2,'33-249-1','FALSE','en',NULL,NULL,'TH',NULL),(28364,2,'52-251-1','How does multitasking affect performance?','en',NULL,NULL,'TH',NULL),(28367,2,'53-251-1','When you try to multitask, each task takes longer to complete, and more errors are made, than if you focused on a single task at a time.','en',NULL,NULL,'TH',NULL),(28370,2,'52-252-1','Multitasking in action','en',NULL,NULL,'TH',NULL),(28373,2,'53-252-1','In this example, watch as 2 people complete 2 tasks. Person A will focus on a single task at a time, and Person B will attempt to multitask.','en',NULL,NULL,'TH',NULL),(28376,2,'53-253-1','Both participants start Task 1 at the same time.','en',NULL,NULL,'TH',NULL),(28379,2,'52-253-1','Multitasking in action','en',NULL,NULL,'TH',NULL),(28382,2,'52-254-1','Goal shifting','en',NULL,NULL,'TH',NULL),(28385,2,'53-254-1','Person B decides to move from one task to another. This is called goal shifting, and it is the first step the brain must take in order to switch tasks.','en',NULL,NULL,'TH',NULL),(28388,2,'53-255-1','Next, the brain turns off the rules for the first task, and turns on the rules it needs to complete the next one. This is called rule activation.','en',NULL,NULL,'TH',NULL),(28391,2,'52-255-1','Rule activation','en',NULL,NULL,'TH',NULL),(28394,2,'52-256-1','The task switches','en',NULL,NULL,'TH',NULL),(28397,2,'53-256-1','After shifting goals and activating new rules, Person B now begins Task 2. Meanwhile, Person A has not needed these processes.','en',NULL,NULL,'TH',NULL),(28400,2,'52-257-1','Look at what happened','en',NULL,NULL,'TH',NULL),(28403,2,'53-257-1','Shifting goals and activating new rules does not take long. If done frequently though, that time adds up, and Person B falls behind.','en',NULL,NULL,'TH',NULL),(28406,2,'38-12','Task 2','en',NULL,NULL,'TH',NULL),(28409,2,'38-9','Person A','en',NULL,NULL,'TH',NULL),(28412,2,'38-10','Person B','en',NULL,NULL,'TH',NULL),(28415,2,'38-13','Task Switch','en',NULL,NULL,'TH',NULL),(28418,2,'38-11','Task 1','en',NULL,NULL,'TH',NULL),(28421,2,'31-241-1','Which statement best represents the main point of the exercise you just completed?','en',NULL,NULL,'TH',NULL),(28424,2,'33-242-1','it is difficult to maintain concentration while multitasking','en',NULL,NULL,'TH',NULL),(28427,2,'33-243-1','it is difficult to dial a phone number while driving','en',NULL,NULL,'TH',NULL),(28430,2,'33-244-1','it is more difficult to drive a car than it is to dial a phone number','en',NULL,NULL,'TH',NULL),(28433,2,'33-245-1','it is difficult to maintain a consistent speed while multitasking','en',NULL,NULL,'TH',NULL),(28436,2,'33-246-1','it is difficult to multitask without impacting performance','en',NULL,NULL,'TH',NULL);
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `user` (
  `user_id` smallint(5) NOT NULL AUTO_INCREMENT,
  `group_id` tinyint(3) DEFAULT NULL,
  `name` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `hash` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  KEY `us_group_id_idx` (`group_id`),
  CONSTRAINT `us_group_id` FOREIGN KEY (`group_id`) REFERENCES `user_group` (`group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
INSERT INTO `user` VALUES (33,1,'John Parker','jp0624@gmail.com','$2a$10$5mogv7VZQJiLiNQuxSG3Eub.CZU4/WLZdcVUFRYk5xeGqZXrizbKG'),(54,1,'demo','demo','$2a$10$nKchaKYxefjTrymffGea1uVotxua.CO.P/CAWImBXOXYuCJeU0Vp.');
UNLOCK TABLES;

--
-- Table structure for table `user_group`
--

DROP TABLE IF EXISTS `user_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `user_group` (
  `group_id` tinyint(3) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `description` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_group`
--

LOCK TABLES `user_group` WRITE;
INSERT INTO `user_group` VALUES (1,'admin','System Administrators with full access.'),(2,'Supervisor','Supervisor Group'),(3,'','');
UNLOCK TABLES;

--
-- Table structure for table `user_group_permission`
--

DROP TABLE IF EXISTS `user_group_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `user_group_permission` (
  `permission_id` smallint(5) NOT NULL AUTO_INCREMENT,
  `group_id` tinyint(3) NOT NULL,
  `content_type_id` tinyint(3) NOT NULL,
  `read` tinyint(1) NOT NULL DEFAULT '0',
  `write` tinyint(1) NOT NULL DEFAULT '0',
  `delete` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`permission_id`),
  KEY `us_gr_pr_group_id_idx` (`group_id`),
  KEY `us_gr_pr_type_id_idx` (`content_type_id`),
  CONSTRAINT `us_gr_pr_group_id` FOREIGN KEY (`group_id`) REFERENCES `user_group` (`group_id`),
  CONSTRAINT `us_gr_pr_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `content_type` (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_group_permission`
--

LOCK TABLES `user_group_permission` WRITE;
UNLOCK TABLES;

--
-- Table structure for table `user_session`
--

DROP TABLE IF EXISTS `user_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `user_session` (
  `session_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` smallint(5) NOT NULL,
  `key` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `valid` tinyint(1) NOT NULL DEFAULT '1',
  `ip_address` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`session_id`),
  KEY `us_user_id_idx` (`user_id`),
  CONSTRAINT `us_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_session`
--

LOCK TABLES `user_session` WRITE;
UNLOCK TABLES;

--
-- Table structure for table `vehicle`
--

DROP TABLE IF EXISTS `vehicle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `vehicle` (
  `vehicle_id` tinyint(3) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`vehicle_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicle`
--

LOCK TABLES `vehicle` WRITE;
INSERT INTO `vehicle` VALUES (1,'car','','2017-11-16 16:37:27'),(2,'truck',NULL,'2017-08-11 16:29:13'),(3,'fork-lift','fork-lift','2018-05-24 20:40:34'),(4,'test','','2018-01-30 16:30:40'),(5,'','','2018-05-22 18:11:44'),(6,'New v','string','2018-05-24 18:39:57'),(7,'New v1','string','2018-05-24 18:46:20'),(8,'undefined','undefined','2018-05-24 19:07:18'),(9,'dfdfdfdfdf5','dfdfdfdfdf66','2018-05-24 20:10:24'),(10,'string12','string12','2018-05-29 18:31:17');
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-06-01 10:02:05