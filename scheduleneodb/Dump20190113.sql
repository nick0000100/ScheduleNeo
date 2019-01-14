CREATE DATABASE  IF NOT EXISTS `scheduleneodb` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `scheduleneodb`;
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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` VALUES (10,'Ashley','Hogan',0,0,0,'2019-01-13 22:23:57',0,'2019-01-06 20:36:49','2019-01-06 20:36:49','v-ashoga',1,0,'0001-01-01 00:00:00',0),(11,'Mai','Brittle',0,0,0,'2019-01-13 22:23:57',0,'2019-01-06 20:37:18','2019-01-06 20:37:18','v-stbrit',1,0,'0001-01-01 00:00:00',0),(12,'Yara','Velez',0,0,0,'2019-01-13 22:23:57',0,'2019-01-06 20:37:34','2019-01-06 20:37:34','v-yavele',1,0,'0001-01-01 00:00:00',0),(13,'Shalini','Bakshi',0,0,0,'2019-01-13 22:23:57',0,'2019-01-06 20:37:58','2019-01-06 20:37:58','v-shbaks',0,1,'0001-01-01 00:00:00',0),(14,'Ilona','Senyak',0,0,0,'2019-01-13 22:23:57',0,'2019-01-06 20:38:36','2019-01-06 20:38:36','v-ilseny',0,1,'0001-01-01 00:00:00',0),(15,'Kaitlyn','Tsai',0,0,0,'2019-01-13 22:23:57',0,'2019-01-06 20:38:53','2019-01-06 20:38:53','v-kaitsa',0,1,'0001-01-01 00:00:00',0),(16,'Mary','Lee Covington',1,0,0,'2019-01-13 22:23:57',0,'2019-01-06 20:43:27','2019-01-06 20:43:27','lee.covington',0,0,'0001-01-01 00:00:00',0),(17,'Rene','De La Rosa',1,0,0,'2019-01-13 22:23:57',0,'2019-01-06 20:44:19','2019-01-06 20:44:19','redelar',0,0,'0001-01-01 00:00:00',0),(18,'Sarah','Simmons',1,0,0,'2019-01-13 22:23:57',0,'2019-01-06 20:44:34','2019-01-06 20:44:34','sarah.simmons',0,0,'0001-01-01 00:00:00',0),(19,'Tonya','Praseuth',0,0,0,'2019-01-13 22:23:57',0,'2019-01-06 20:45:04','2019-01-06 20:45:04','v-topra',1,0,'0001-01-01 00:00:00',0),(20,'Alyssa','Fukumoto',1,0,0,'2019-01-13 22:23:57',0,'2019-01-09 20:56:48','2019-01-09 20:56:48','alfukumo',0,0,'0001-01-01 00:00:00',1),(21,'Emily','Liss',1,0,0,'2019-01-13 22:23:57',0,'2019-01-09 20:57:31','2019-01-09 20:57:31','emliss',0,0,'0001-01-01 00:00:00',2),(22,'Shreya','Gaitonde',0,0,0,'2019-01-13 22:23:57',0,'2019-01-13 21:35:13','2019-01-13 21:35:13','v-shgait',1,0,'0001-01-01 00:00:00',0),(23,'Annabel','Barnes',0,0,0,'2019-01-13 22:23:57',0,'2019-01-13 21:46:18','2019-01-13 21:46:18','v-annbar',1,0,'0001-01-01 00:00:00',0),(25,'Nicholas','Sor',0,0,0,'2019-01-13 22:23:57',0,'2019-01-13 22:08:15','2019-01-13 22:08:15','v-nisor',1,0,'0001-01-01 00:00:00',0);
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
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `neos`
--

LOCK TABLES `neos` WRITE;
/*!40000 ALTER TABLE `neos` DISABLE KEYS */;
/*!40000 ALTER TABLE `neos` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
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

-- Dump completed on 2019-01-13 22:35:50
