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
) ENGINE=InnoDB AUTO_INCREMENT=157 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `completers`
--

LOCK TABLES `completers` WRITE;
/*!40000 ALTER TABLE `completers` DISABLE KEYS */;
INSERT INTO `completers` VALUES (10,74,70,'0001-01-01 00:00:00',0),(11,74,71,'0001-01-01 00:00:00',0),(12,74,72,'0001-01-01 00:00:00',0),(19,74,73,'0001-01-01 00:00:00',0),(22,74,74,'0001-01-01 00:00:00',0),(23,74,75,'0001-01-01 00:00:00',0),(25,74,76,'0001-01-01 00:00:00',0),(14,74,77,'0001-01-01 00:00:00',0),(15,74,78,'0001-01-01 00:00:00',0),(13,74,79,'0001-01-01 00:00:00',0),(18,74,80,'0001-01-01 00:00:00',0),(10,75,83,'2019-04-02 20:25:36',1),(11,75,84,'0001-01-01 00:00:00',0),(12,75,85,'2019-04-02 20:25:44',1),(19,75,86,'0001-01-01 00:00:00',0),(22,75,87,'0001-01-01 00:00:00',0),(23,75,88,'0001-01-01 00:00:00',0),(25,75,89,'0001-01-01 00:00:00',0),(26,75,90,'0001-01-01 00:00:00',0),(14,75,91,'0001-01-01 00:00:00',0),(15,75,92,'0001-01-01 00:00:00',0),(13,75,93,'0001-01-01 00:00:00',0),(21,75,94,'0001-01-01 00:00:00',0),(18,75,95,'0001-01-01 00:00:00',0),(17,75,96,'0001-01-01 00:00:00',0),(16,75,97,'0001-01-01 00:00:00',0),(10,76,98,'0001-01-01 00:00:00',0),(11,76,99,'0001-01-01 00:00:00',0),(12,76,100,'0001-01-01 00:00:00',0),(19,76,101,'0001-01-01 00:00:00',0),(22,76,102,'0001-01-01 00:00:00',0),(23,76,103,'0001-01-01 00:00:00',0),(25,76,104,'0001-01-01 00:00:00',0),(26,76,105,'0001-01-01 00:00:00',0),(14,76,106,'0001-01-01 00:00:00',0),(15,76,107,'0001-01-01 00:00:00',0),(13,76,108,'0001-01-01 00:00:00',0),(21,76,109,'0001-01-01 00:00:00',0),(18,76,110,'0001-01-01 00:00:00',0),(17,76,111,'0001-01-01 00:00:00',0),(10,77,112,'0001-01-01 00:00:00',0),(11,77,113,'0001-01-01 00:00:00',0),(12,77,114,'0001-01-01 00:00:00',0),(19,77,115,'0001-01-01 00:00:00',0),(22,77,116,'0001-01-01 00:00:00',0),(23,77,117,'0001-01-01 00:00:00',0),(25,77,118,'0001-01-01 00:00:00',0),(26,77,119,'0001-01-01 00:00:00',0),(14,77,120,'0001-01-01 00:00:00',0),(15,77,121,'0001-01-01 00:00:00',0),(13,77,122,'0001-01-01 00:00:00',0),(21,77,123,'0001-01-01 00:00:00',0),(18,77,124,'0001-01-01 00:00:00',0),(10,79,125,'0001-01-01 00:00:00',0),(11,79,126,'0001-01-01 00:00:00',0),(12,79,127,'0001-01-01 00:00:00',0),(19,79,128,'0001-01-01 00:00:00',0),(22,79,129,'0001-01-01 00:00:00',0),(23,79,130,'0001-01-01 00:00:00',0),(25,79,131,'0001-01-01 00:00:00',0),(26,79,132,'0001-01-01 00:00:00',0),(14,79,133,'0001-01-01 00:00:00',0),(15,79,134,'0001-01-01 00:00:00',0),(13,79,135,'0001-01-01 00:00:00',0),(21,79,136,'0001-01-01 00:00:00',0),(18,79,137,'0001-01-01 00:00:00',0),(17,79,138,'0001-01-01 00:00:00',0),(16,79,139,'0001-01-01 00:00:00',0),(28,80,140,'0001-01-01 00:00:00',0),(29,80,141,'0001-01-01 00:00:00',0),(10,80,142,'0001-01-01 00:00:00',0),(11,80,143,'0001-01-01 00:00:00',0),(12,80,144,'0001-01-01 00:00:00',0),(19,80,145,'0001-01-01 00:00:00',0),(22,80,146,'0001-01-01 00:00:00',0),(23,80,147,'0001-01-01 00:00:00',0),(25,80,148,'0001-01-01 00:00:00',0),(26,80,149,'0001-01-01 00:00:00',0),(14,80,150,'0001-01-01 00:00:00',0),(15,80,151,'0001-01-01 00:00:00',0),(13,80,152,'0001-01-01 00:00:00',0),(21,80,153,'0001-01-01 00:00:00',0),(18,80,154,'0001-01-01 00:00:00',0),(17,80,155,'0001-01-01 00:00:00',0),(16,80,156,'0001-01-01 00:00:00',0);
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
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` VALUES (10,'Ashley','Hogan',0,0,4,'2019-04-02 00:00:00',0,'2019-01-06 20:36:49','2019-01-06 20:36:49','v-ashoga',1,0,'0001-01-01 00:00:00',0,0),(11,'Mai','Brittle',0,1,1,'2019-01-16 00:00:00',0,'2019-01-06 20:37:18','2019-01-06 20:37:18','v-stbrit',1,0,'0001-01-01 00:00:00',0,0),(12,'Yara','Velez',0,0,3,'2019-04-02 00:00:00',0,'2019-01-06 20:37:34','2019-01-06 20:37:34','v-yavele',1,0,'0001-01-01 00:00:00',0,0),(13,'Shalini','Bakshi',0,0,1,'2019-01-16 00:00:00',0,'2019-01-06 20:37:58','2019-01-06 20:37:58','v-shbaks',0,1,'0001-01-01 00:00:00',0,0),(14,'Ilona','Senyak',0,0,0,'2019-01-13 22:23:57',0,'2019-01-06 20:38:36','2019-01-06 20:38:36','v-ilseny',0,1,'0001-01-01 00:00:00',0,0),(15,'Kaitlyn','Tsai',0,0,1,'2019-01-16 00:00:00',0,'2019-01-06 20:38:53','2019-01-06 20:38:53','v-kaitsa',0,1,'0001-01-01 00:00:00',0,0),(16,'Mary','Lee Covington',1,0,0,'2019-01-13 22:23:57',0,'2019-01-06 20:43:27','2019-01-06 20:43:27','lee.covington',0,0,'0001-01-01 00:00:00',0,0),(17,'Rene','De La Rosa',1,0,0,'2019-01-13 22:23:57',0,'2019-01-06 20:44:19','2019-01-06 20:44:19','redelar',0,0,'0001-01-01 00:00:00',0,0),(18,'Sarah','Simmons',1,0,0,'2019-01-13 22:23:57',0,'2019-01-06 20:44:34','2019-01-06 20:44:34','sarah.simmons',0,0,'0001-01-01 00:00:00',0,0),(19,'Tonya','Praseuth',0,1,0,'2019-01-16 00:00:00',0,'2019-01-06 20:45:04','2019-01-06 20:45:04','v-topra',1,0,'0001-01-01 00:00:00',0,0),(21,'Emily','Liss',1,1,0,'2019-04-01 00:00:00',0,'2019-01-09 20:57:31','2019-01-09 20:57:31','emliss',0,0,'0001-01-01 00:00:00',2,0),(22,'Shreya','Gaitonde',0,0,0,'2019-01-16 00:00:00',0,'2019-01-13 21:35:13','2019-01-13 21:35:13','v-shgait',1,0,'0001-01-01 00:00:00',0,0),(23,'Annabel','Barnes',0,1,1,'2019-01-16 00:00:00',0,'2019-01-13 21:46:18','2019-01-13 21:46:18','v-annbar',1,0,'0001-01-01 00:00:00',0,0),(25,'Nicholas','Sor',0,0,0,'2019-01-13 22:23:57',0,'2019-01-13 22:08:15','2019-01-13 22:08:15','v-nisor',1,0,'0001-01-01 00:00:00',0,0),(26,'sd','sdds',0,0,0,'0001-01-01 00:00:00',0,'2019-04-01 22:15:24','2019-04-01 22:15:24','dssd',1,0,'0001-01-01 00:00:00',0,0),(28,'other','other',0,0,0,'0001-01-01 00:00:00',0,'2019-05-01 21:51:09','2019-05-01 21:51:09','other',0,0,'0001-01-01 00:00:00',0,1),(29,'ohter2','other2',0,0,0,'0001-01-01 00:00:00',0,'2019-05-01 22:25:44','2019-05-01 22:25:44','sdofsd',0,0,'0001-01-01 00:00:00',0,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `neos`
--

LOCK TABLES `neos` WRITE;
/*!40000 ALTER TABLE `neos` DISABLE KEYS */;
INSERT INTO `neos` VALUES (74,150,'2019-02-01 00:00:00',0,0,'2019-01-16 20:39:28','2019-01-16 20:39:28'),(75,800,'2019-04-15 00:00:00',0,0,'2019-04-02 20:25:29','2019-04-02 20:25:29'),(76,200,'2019-05-22 00:00:00',0,0,'2019-05-01 22:25:37','2019-05-01 22:25:37'),(77,213,'2019-05-15 00:00:00',0,0,'2019-05-01 22:35:10','2019-05-01 22:35:10'),(78,100,'2019-12-31 00:00:00',0,0,'2019-05-01 22:35:52','2019-05-01 22:35:52'),(79,234234,'2019-05-09 00:00:00',0,0,'2019-05-01 22:41:38','2019-05-01 22:41:38'),(80,234234,'2019-05-24 00:00:00',0,0,'2019-05-01 22:43:10','2019-05-01 22:43:10'),(81,150,'2019-05-15 00:00:00',0,0,'2019-05-01 22:43:59','2019-05-01 22:43:59');
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
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notes`
--

LOCK TABLES `notes` WRITE;
/*!40000 ALTER TABLE `notes` DISABLE KEYS */;
INSERT INTO `notes` VALUES (11,15,'sdfsdf','2019-04-01 18:24:17','2019-04-01 18:24:17'),(12,15,'sdfsdfs','2019-04-01 18:24:20','2019-04-01 18:24:20'),(18,15,'@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@','2019-04-01 19:59:19','2019-04-01 19:59:19'),(19,15,'Add Note...','2019-04-01 20:01:00','2019-04-01 20:01:00'),(20,10,'Add Note...','2019-04-01 20:57:34','2019-04-01 20:57:34'),(21,10,'Add Note...','2019-04-01 20:57:34','2019-04-01 20:57:34'),(22,10,'Add Note...','2019-04-01 20:57:35','2019-04-01 20:57:35'),(23,10,'Add Note...','2019-04-01 20:57:36','2019-04-01 20:57:36'),(24,10,'Add Note...','2019-04-01 20:57:36','2019-04-01 20:57:36');
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (5,'Nicholas','Sor','nisor','AQAAAAEAACcQAAAAEDDmJMioL/zSu2TzrwWFCNlllYBrB+M+yvjITAuow/8l9aZ7qkCKGTsLAC7w6rZhRA==','2019-01-16 19:15:08','2019-01-16 19:15:08',0),(6,'Nick','Sor','nick0000100','AQAAAAEAACcQAAAAECf8Hjljwi8wuu8RHcFUofiIB32emIRtbtuFKf0J29yPFpCRkKQckgOUH0ohQaokMw==','2019-04-01 18:19:53','2019-04-01 18:19:53',0),(7,'Nick','Nick','bobby1','AQAAAAEAACcQAAAAEE6j0HGpMfksFdM/FLfXl03RF9x9loj2ZBRd0+J6gF1AvmJUoYzp04KV1QimLTHL8g==','2019-04-01 21:23:38','2019-04-01 21:23:38',1),(8,'Nick','Sor','Johhny','AQAAAAEAACcQAAAAEDA4SXqTtcwT8VTyXL0x0CsLEZZdU979IjH/EBqp9Kfb1F3iS/XJdWLSwybMDVFiDw==','2019-04-01 22:12:55','2019-04-01 22:12:55',1),(9,'Test','Test','Test','AQAAAAEAACcQAAAAEG/ljqGUGgCs1XU+kySxsjJwulBUgeJ/BDRhEcmx07CgBPHwPvUya22H7mlpIq5p0g==','2019-04-02 18:59:04','2019-04-02 18:59:04',1),(10,'sdfsdf','sdfsdfs','nicksss','AQAAAAEAACcQAAAAEKuStDnu6NAwbLjZP2XLYhfv2MQRq7aZX3IbYp11vhqLKcAL5Vvj+z4IAGupPfr6bw==','2019-05-01 21:46:09','2019-05-01 21:46:09',1);
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

-- Dump completed on 2019-05-01 22:47:29
