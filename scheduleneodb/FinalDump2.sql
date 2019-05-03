-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: localhost    Database: scheduleneodb
-- ------------------------------------------------------
-- Server version	8.0.11

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `completers`
--

DROP TABLE IF EXISTS `completers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `completers` (
  `EmployeeId` int(11) NOT NULL,
  `NeoId` int(11) NOT NULL,
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `AttendedTime` datetime DEFAULT NULL,
  `Attended` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`Id`,`EmployeeId`,`NeoId`),
  KEY `fk_employees_has_neos_neos1_idx` (`NeoId`),
  KEY `fk_employees_has_neos_employees_idx` (`EmployeeId`),
  CONSTRAINT `fk_employees_has_neos_employees` FOREIGN KEY (`EmployeeId`) REFERENCES `employees` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_employees_has_neos_neos1` FOREIGN KEY (`NeoId`) REFERENCES `neos` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `completers`
--

LOCK TABLES `completers` WRITE;
/*!40000 ALTER TABLE `completers` DISABLE KEYS */;
/*!40000 ALTER TABLE `completers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employees` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(255) DEFAULT NULL,
  `LastName` varchar(255) DEFAULT NULL,
  `IsCela` tinyint(4) DEFAULT '0',
  `Skipped` tinyint(4) DEFAULT '0',
  `TimesAttended` int(11) DEFAULT '0',
  `LastAttended` datetime DEFAULT CURRENT_TIMESTAMP,
  `OOF` tinyint(4) DEFAULT '0',
  `CreatedAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `UpdatedAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `Alias` varchar(255) DEFAULT NULL,
  `IsRobertHalf` tinyint(4) DEFAULT '0',
  `IsCelaVendor` tinyint(4) DEFAULT '0',
  `TimeShowedUp` datetime DEFAULT NULL,
  `Role` int(11) DEFAULT NULL,
  `IsOther` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` VALUES (1,'Kamilla','Bekmirzaeva',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 21:21:52','2019-05-02 21:21:52','v-kabekm',0,1,'0001-01-01 00:00:00',0,0),(2,'Viktoriya','Nikitenko',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 21:22:35','2019-05-02 21:22:35','v-vikni',0,1,'0001-01-01 00:00:00',0,0),(3,'Shalini','Bakshi',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 21:23:04','2019-05-02 21:23:04','v-shbaks',0,1,'0001-01-01 00:00:00',0,0),(4,'Ashley','Hogam',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 21:23:36','2019-05-02 21:23:36','v-ashoga',1,0,'0001-01-01 00:00:00',0,0),(5,'Stephanie','Brittle',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 21:24:03','2019-05-02 21:24:03','v-stbrit',1,0,'0001-01-01 00:00:00',0,0),(6,'Yara','Velez',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 21:24:26','2019-05-02 21:24:26','v-yavele',1,0,'0001-01-01 00:00:00',0,0),(7,'Tonya','Praseuth',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 21:24:44','2019-05-02 21:24:44','v-topra',1,0,'0001-01-01 00:00:00',0,0),(8,'Sudeshna','Deb',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 21:25:27','2019-05-02 21:25:27','v-suddeb',1,0,'0001-01-01 00:00:00',0,0),(9,'Rachel','Mwangi',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 21:25:47','2019-05-02 21:25:47','v-ramwan',1,0,'0001-01-01 00:00:00',0,0),(10,'Nicholas','Sor',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 21:25:58','2019-05-02 21:25:58','v-nisor',1,0,'0001-01-01 00:00:00',0,0),(11,'Shreya','Gaitonde',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 21:26:23','2019-05-02 21:26:23','v-shgait',1,0,'0001-01-01 00:00:00',0,0),(12,'Sarah','Simmons',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 21:28:16','2019-05-02 21:28:16','SASIMMON',1,0,'0001-01-01 00:00:00',0,0),(13,'Rene','De La Cruz',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 21:29:54','2019-05-02 21:29:54','REDELAR',1,0,'0001-01-01 00:00:00',0,0),(14,'Jack','Chen',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 21:30:34','2019-05-02 21:30:34','JACKCH',1,0,'0001-01-01 00:00:00',0,0),(15,'Katie','Smith',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 21:30:53','2019-05-02 21:30:53','KASMI',1,0,'0001-01-01 00:00:00',0,0),(16,'Miriam','Miller',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 21:31:13','2019-05-02 21:31:13','MIMILL',1,0,'0001-01-01 00:00:00',0,0),(17,'Mary','Covington',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 21:31:38','2019-05-02 21:31:38','LECOVING',1,0,'0001-01-01 00:00:00',0,0),(18,'Bob','Ulmer',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 21:31:55','2019-05-02 21:31:55','BOULMER',1,0,'0001-01-01 00:00:00',0,0),(19,'Ana','Krishnan',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 21:32:11','2019-05-02 21:32:11','ANTATTAM',1,0,'0001-01-01 00:00:00',0,0),(20,'Jenny','Saloman',1,0,0,'0001-01-01 00:00:00',0,'2019-05-02 21:32:32','2019-05-02 21:32:32','JENSAL',0,0,'0001-01-01 00:00:00',2,0),(21,'Emily','Liss',1,0,0,'0001-01-01 00:00:00',0,'2019-05-02 21:32:48','2019-05-02 21:32:48','EMLISS',0,0,'0001-01-01 00:00:00',2,0),(22,'Y','Le',1,0,0,'0001-01-01 00:00:00',0,'2019-05-02 21:35:05','2019-05-02 21:35:05','NHLE',0,0,'0001-01-01 00:00:00',2,0),(23,'David','Hwang',1,0,0,'0001-01-01 00:00:00',0,'2019-05-02 21:36:05','2019-05-02 21:36:05','DAVIDHW',0,0,'0001-01-01 00:00:00',2,0),(24,'Liz','Wheeler',1,0,0,'0001-01-01 00:00:00',0,'2019-05-02 21:36:21','2019-05-02 21:36:21','ELWHEEL',0,0,'0001-01-01 00:00:00',2,0),(25,'Annie','Wilson',1,0,0,'0001-01-01 00:00:00',0,'2019-05-02 21:38:28','2019-05-02 21:38:28','ANWILSON',0,0,'0001-01-01 00:00:00',2,0),(26,'Amae','Kurre',1,0,0,'0001-01-01 00:00:00',0,'2019-05-02 21:38:49','2019-05-02 21:38:49','AMKURRE',0,0,'0001-01-01 00:00:00',1,0),(27,'Daniele','Gillund',1,0,0,'0001-01-01 00:00:00',0,'2019-05-02 21:39:17','2019-05-02 21:39:17','DAGILLUN',0,0,'0001-01-01 00:00:00',1,0),(28,'Alyssa','Fukumoto',1,0,0,'0001-01-01 00:00:00',0,'2019-05-02 21:39:39','2019-05-02 21:39:39','ALFUKUMO',0,0,'0001-01-01 00:00:00',1,0),(29,'Christine','Ryan',1,0,0,'0001-01-01 00:00:00',0,'2019-05-02 21:39:56','2019-05-02 21:39:56','CHRYA',0,0,'0001-01-01 00:00:00',1,0),(30,'Midori','Nichols',1,0,0,'0001-01-01 00:00:00',0,'2019-05-02 21:40:23','2019-05-02 21:40:23','MIDNIC',0,0,'0001-01-01 00:00:00',1,0),(31,'Ruben','Silberman',1,0,0,'0001-01-01 00:00:00',0,'2019-05-02 21:40:40','2019-05-02 21:40:40','RUSILBER',0,0,'0001-01-01 00:00:00',1,0),(32,'Hillary','Converse Long',1,0,0,'0001-01-01 00:00:00',0,'2019-05-02 21:41:00','2019-05-02 21:41:00','HILARYC',0,0,'0001-01-01 00:00:00',2,0),(33,'Barbara','Leen',1,0,0,'0001-01-01 00:00:00',0,'2019-05-02 21:41:17','2019-05-02 21:41:17','BALEEN',0,0,'0001-01-01 00:00:00',2,0),(34,'Aaron','Epps',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 21:49:59','2019-05-02 21:49:59','AAEPPS',0,0,'0001-01-01 00:00:00',0,1),(35,'Alex','Daniel',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 21:50:29','2019-05-02 21:50:29','ALDANIEL',0,0,'0001-01-01 00:00:00',0,1),(36,'Alex','Horning',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 21:50:43','2019-05-02 21:50:43','v-alblom',0,0,'0001-01-01 00:00:00',0,1),(37,'Amanda','Pardee',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 21:50:59','2019-05-02 21:50:59','v-amapar',0,0,'0001-01-01 00:00:00',0,1),(38,'Andrea','Adams',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 21:51:14','2019-05-02 21:51:14','ANADA',0,0,'0001-01-01 00:00:00',0,1),(39,'Andrew','Morlin',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 21:51:46','2019-05-02 21:51:46','v-moand',0,0,'0001-01-01 00:00:00',0,1),(40,'Andrew','Wang',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 21:51:55','2019-05-02 21:51:55','WAAN',0,0,'0001-01-01 00:00:00',0,1),(41,'Andy','Herman',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 21:53:44','2019-05-02 21:53:44','ANHERMAN',0,0,'0001-01-01 00:00:00',0,1),(42,'Anthony','Martinez',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 21:54:02','2019-05-02 21:54:02','v-maanth',0,0,'0001-01-01 00:00:00',0,1),(43,'Ashley','Donaldson',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 21:55:37','2019-05-02 21:55:37','ASDONALD',0,0,'0001-01-01 00:00:00',0,1),(44,'Audrey','Yee Wen Chan',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 21:57:15','2019-05-02 21:57:15','AUCHAN',0,0,'0001-01-01 00:00:00',0,1),(45,'Briana','Alcala',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 21:57:34','2019-05-02 21:57:34','BRMAJCHE',0,0,'0001-01-01 00:00:00',0,1),(46,'Catie','Baird',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 21:57:51','2019-05-02 21:57:51','v-cabair',0,0,'0001-01-01 00:00:00',0,1),(47,'Catrina','Chen',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 21:58:05','2019-05-02 21:58:05','v-catche',0,0,'0001-01-01 00:00:00',0,1),(48,'Cesar','Pozo-Calderson',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 21:58:29','2019-05-02 21:58:29','v-cepoz',0,0,'0001-01-01 00:00:00',0,1),(49,'Christina','Cho',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 21:58:50','2019-05-02 21:58:50','v-chrcho',0,0,'0001-01-01 00:00:00',0,1),(50,'Christina','Chon',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 21:59:06','2019-05-02 21:59:06','v-chchon',0,0,'0001-01-01 00:00:00',0,1),(51,'Christina','Gee',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 21:59:20','2019-05-02 21:59:20','CHGEE',0,0,'0001-01-01 00:00:00',0,1),(52,'Cory','Blyth',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 21:59:41','2019-05-02 21:59:41','v-coblyt',0,0,'0001-01-01 00:00:00',0,1),(53,'Damon','Coupe',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 21:59:49','2019-05-02 21:59:49','DACOUP',0,0,'0001-01-01 00:00:00',0,1),(54,'Diane','Kuslich',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 22:00:23','2019-05-02 22:00:23','DIANEK',0,0,'0001-01-01 00:00:00',0,1),(55,'Erin','Creighton',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 22:00:41','2019-05-02 22:00:41','ERCEIGH',0,0,'0001-01-01 00:00:00',0,1),(56,'Erin','McLaughlin',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 22:00:54','2019-05-02 22:00:54','ERMCLAUG',0,0,'0001-01-01 00:00:00',0,1),(57,'Gabriel Garcia','Marquez',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 22:01:17','2019-05-02 22:01:17','GABEGM',0,0,'0001-01-01 00:00:00',0,1),(58,'Irene','Shieh',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 22:02:33','2019-05-02 22:02:33','v-irshie',0,0,'0001-01-01 00:00:00',0,1),(59,'James','Spaan',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 22:02:46','2019-05-02 22:02:46','v-jaspaa',0,0,'0001-01-01 00:00:00',0,1),(60,'Jennifer','Garrison',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 22:03:00','2019-05-02 22:03:00','JENGAR',0,0,'0001-01-01 00:00:00',0,1),(61,'Jenny','Cook',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 22:03:10','2019-05-02 22:03:10','JENCOOK',0,0,'0001-01-01 00:00:00',0,1),(62,'Jessica','Diesing',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 22:03:20','2019-05-02 22:03:20','JEDIE',0,0,'0001-01-01 00:00:00',0,1),(63,'Julie','Horng',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 22:03:34','2019-05-02 22:03:34','JHORNG',0,0,'0001-01-01 00:00:00',0,1),(64,'Julie','Moskalenko',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 22:03:55','2019-05-02 22:03:55','JZLAM',0,0,'0001-01-01 00:00:00',0,1),(65,'Julie','Owens',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 22:04:13','2019-05-02 22:04:13','JUOWEN',0,0,'0001-01-01 00:00:00',0,1),(66,'Julie','Robins',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 22:04:23','2019-05-02 22:04:23','v-jurobi',0,0,'0001-01-01 00:00:00',0,1),(67,'Kamara','Swaby',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 22:04:46','2019-05-02 22:04:46','KASWABY',0,0,'0001-01-01 00:00:00',0,1),(68,'Kate','Randall',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 22:05:16','2019-05-02 22:05:16','KARANDAL',0,0,'0001-01-01 00:00:00',0,1),(69,'Katelyn Marie','Carroll',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 22:05:42','2019-05-02 22:05:42','KCARROLL',0,0,'0001-01-01 00:00:00',0,1),(70,'Katie','Stutz',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 22:06:08','2019-05-02 22:06:08','v-kastut',0,0,'0001-01-01 00:00:00',0,1),(71,'Kelli','Muilenburg',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 22:06:25','2019-05-02 22:06:25','KELLIMU',0,0,'0001-01-01 00:00:00',0,1),(72,'Kelsea','Pullin',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 22:07:13','2019-05-02 22:07:13','KEPUL',0,0,'0001-01-01 00:00:00',0,1),(73,'Kevin','Lee',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 22:07:21','2019-05-02 22:07:21','LEKEVIN',0,0,'0001-01-01 00:00:00',0,1),(74,'Kristen','Purugganan',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 22:08:01','2019-05-02 22:08:01','v-krpuru',0,0,'0001-01-01 00:00:00',0,1),(75,'Kristen','Straube',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 22:08:18','2019-05-02 22:08:18','KSTAUB',0,0,'0001-01-01 00:00:00',0,1),(76,'Laura','Groebner',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 22:08:46','2019-05-02 22:08:46','LAGROEBN',0,0,'0001-01-01 00:00:00',0,1),(77,'Laurie','Miyauchi',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 22:09:36','2019-05-02 22:09:36','LAURIEMI',0,0,'0001-01-01 00:00:00',0,1),(78,'Leslie','Richardson',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 22:09:55','2019-05-02 22:09:55','LERISH',0,0,'0001-01-01 00:00:00',0,1),(79,'Liz','Wan',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 22:10:33','2019-05-02 22:10:33','ELIZASN',0,0,'0001-01-01 00:00:00',0,1),(80,'Lizbeth','Velazquez',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 22:11:12','2019-05-02 22:11:12','LIZVEL',0,0,'0001-01-01 00:00:00',0,1),(81,'Mackenzie','Fuller',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 22:11:32','2019-05-02 22:11:32','v-macful',0,0,'0001-01-01 00:00:00',0,1),(82,'Marian','Hunt',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 22:11:43','2019-05-02 22:11:43','v-mahun',0,0,'0001-01-01 00:00:00',0,1),(83,'Melissa','Kipersztok',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 22:12:02','2019-05-02 22:12:02','v-mekipe',0,0,'0001-01-01 00:00:00',0,1),(84,'Menelik','Bekele',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 22:12:21','2019-05-02 22:12:21','v-mebeke',0,0,'0001-01-01 00:00:00',0,1),(85,'Michelle','Fang',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 22:12:40','2019-05-02 22:12:40','MIFANG',0,0,'0001-01-01 00:00:00',0,1),(86,'Mike','Hughes',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 22:13:12','2019-05-02 22:13:12','MIHUG',0,0,'0001-01-01 00:00:00',0,1),(87,'Nicole','Welle',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 22:13:24','2019-05-02 22:13:24','NJACKSON',0,0,'0001-01-01 00:00:00',0,1),(88,'Palmer','McCutcheon',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 22:14:07','2019-05-02 22:14:07','PAMCCUTC',0,0,'0001-01-01 00:00:00',0,1),(89,'Rachel Marie','Wightman',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 22:14:36','2019-05-02 22:14:36','v-rawigh',0,0,'0001-01-01 00:00:00',0,1),(90,'Rafael','Williams',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 22:14:52','2019-05-02 22:14:52','RAWILL',0,0,'0001-01-01 00:00:00',0,1),(91,'Rod','Armstrong',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 22:15:11','2019-05-02 22:15:11','RODAR',0,0,'0001-01-01 00:00:00',0,1),(92,'Ryan','DiCicco',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 22:15:22','2019-05-02 22:15:22','RYANDI',0,0,'0001-01-01 00:00:00',0,1),(93,'Saba','Dini',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 22:15:36','2019-05-02 22:15:36','v-sadini',0,0,'0001-01-01 00:00:00',0,1),(94,'Sage','Wohlgemuth',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 22:15:52','2019-05-02 22:15:52','SAWOHL',0,0,'0001-01-01 00:00:00',0,1),(95,'Shelby','Gremel',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 22:16:05','2019-05-02 22:16:05','v-shgrem',0,0,'0001-01-01 00:00:00',0,1),(96,'Shelly','Li',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 22:16:15','2019-05-02 22:16:15','SHELLI',0,0,'0001-01-01 00:00:00',0,1),(97,'Shunying','Wang',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 22:16:50','2019-05-02 22:16:50','v-shunwa',0,0,'0001-01-01 00:00:00',0,1),(98,'Sybil','Adams',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 22:17:23','2019-05-02 22:17:23','SYADAMS',0,0,'0001-01-01 00:00:00',0,1),(99,'Tori','Uphoff',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 22:17:34','2019-05-02 22:17:34','TORIUP',0,0,'0001-01-01 00:00:00',0,1),(100,'Tracy','Foster',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 22:17:55','2019-05-02 22:17:55','TRFOSTER',0,0,'0001-01-01 00:00:00',0,1),(101,'Trent Isaiah','Parrish',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 22:18:20','2019-05-02 22:18:20','TRPARRIS',0,0,'0001-01-01 00:00:00',0,1),(102,'Vanessa','Lanng',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 22:18:33','2019-05-02 22:18:33','v-valan',0,0,'0001-01-01 00:00:00',0,1),(103,'Yasmin','Yassin',0,0,0,'0001-01-01 00:00:00',0,'2019-05-02 22:18:45','2019-05-02 22:18:45','v-yayas',0,0,'0001-01-01 00:00:00',0,1);
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `neos`
--

DROP TABLE IF EXISTS `neos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `neos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Attendees` int(11) DEFAULT NULL,
  `Date` datetime DEFAULT NULL,
  `Incompletes` int(11) DEFAULT NULL,
  `NoShows` int(11) DEFAULT NULL,
  `CreatedAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `UpdatedAt` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `neos`
--

LOCK TABLES `neos` WRITE;
/*!40000 ALTER TABLE `neos` DISABLE KEYS */;
/*!40000 ALTER TABLE `neos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notes`
--

DROP TABLE IF EXISTS `notes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `EmployeeId` int(11) NOT NULL,
  `NoteMessage` varchar(8000) DEFAULT NULL,
  `CreatedAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `UpdatedAt` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`,`EmployeeId`),
  KEY `fk_notes_employees_idx` (`EmployeeId`),
  CONSTRAINT `fk_notes_employees` FOREIGN KEY (`EmployeeId`) REFERENCES `employees` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notes`
--

LOCK TABLES `notes` WRITE;
/*!40000 ALTER TABLE `notes` DISABLE KEYS */;
/*!40000 ALTER TABLE `notes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(255) DEFAULT NULL,
  `LastName` varchar(255) DEFAULT NULL,
  `UserName` varchar(255) DEFAULT NULL,
  `Password` varchar(255) DEFAULT NULL,
  `CreatedAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `UpdatedAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `Admin` tinyint(4) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Nicholas','Sor','Nick0000100','AQAAAAEAACcQAAAAEFaXVxg4/f2SypozhMIAQERuBnQ/90+PZ6eOS/hrpOMFjXw4UfVR9Yz/FR4GPu1vzg==','2019-05-02 21:17:43','2019-05-02 21:17:43',1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-05-02 22:25:04
