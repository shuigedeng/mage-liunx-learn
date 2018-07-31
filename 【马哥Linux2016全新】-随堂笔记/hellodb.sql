-- MySQL dump 10.13  Distrib 5.5.33, for Linux (x86_64)
--
-- Host: localhost    Database: hellodb
-- ------------------------------------------------------
-- Server version	5.5.33-log

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
-- Current Database: `hellodb`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `hellodb` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `hellodb`;

--
-- Table structure for table `classes`
--

DROP TABLE IF EXISTS `classes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `classes` (
  `ClassID` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `Class` varchar(100) DEFAULT NULL,
  `NumOfStu` smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`ClassID`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classes`
--

LOCK TABLES `classes` WRITE;
/*!40000 ALTER TABLE `classes` DISABLE KEYS */;
INSERT INTO `classes` VALUES (1,'Shaolin Pai',10),(2,'Emei Pai',7),(3,'QingCheng Pai',11),(4,'Wudang Pai',12),(5,'Riyue Shenjiao',31),(6,'Lianshan Pai',27),(7,'Ming Jiao',27),(8,'Xiaoyao Pai',15);
/*!40000 ALTER TABLE `classes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coc`
--

DROP TABLE IF EXISTS `coc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `coc` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ClassID` tinyint(3) unsigned NOT NULL,
  `CourseID` smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coc`
--

LOCK TABLES `coc` WRITE;
/*!40000 ALTER TABLE `coc` DISABLE KEYS */;
INSERT INTO `coc` VALUES (1,1,2),(2,1,5),(3,2,2),(4,2,6),(5,3,1),(6,3,7),(7,4,5),(8,4,2),(9,5,1),(10,5,9),(11,6,3),(12,6,4),(13,7,4),(14,7,3);
/*!40000 ALTER TABLE `coc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses`
--

DROP TABLE IF EXISTS `courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `courses` (
  `CourseID` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `Course` varchar(100) NOT NULL,
  PRIMARY KEY (`CourseID`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses`
--

LOCK TABLES `courses` WRITE;
/*!40000 ALTER TABLE `courses` DISABLE KEYS */;
INSERT INTO `courses` VALUES (1,'Hamo Gong'),(2,'Kuihua Baodian'),(3,'Jinshe Jianfa'),(4,'Taiji Quan'),(5,'Daiyu Zanghua'),(6,'Weituo Zhang'),(7,'Dagou Bangfa');
/*!40000 ALTER TABLE `courses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scores`
--

DROP TABLE IF EXISTS `scores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scores` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `StuID` int(10) unsigned NOT NULL,
  `CourseID` smallint(5) unsigned NOT NULL,
  `Score` tinyint(3) unsigned DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scores`
--

LOCK TABLES `scores` WRITE;
/*!40000 ALTER TABLE `scores` DISABLE KEYS */;
INSERT INTO `scores` VALUES (1,1,2,77),(2,1,6,93),(3,2,2,47),(4,2,5,97),(5,3,2,88),(6,3,6,75),(7,4,5,71),(8,4,2,89),(9,5,1,39),(10,5,7,63),(11,6,1,96),(12,7,1,86),(13,7,7,83),(14,8,4,57),(15,8,3,93);
/*!40000 ALTER TABLE `scores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `students`
--

DROP TABLE IF EXISTS `students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `students` (
  `StuID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) NOT NULL,
  `Age` tinyint(3) unsigned NOT NULL,
  `Gender` enum('F','M') NOT NULL,
  `ClassID` tinyint(3) unsigned DEFAULT NULL,
  `TeacherID` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`StuID`)
) ENGINE=MyISAM AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `students`
--

LOCK TABLES `students` WRITE;
/*!40000 ALTER TABLE `students` DISABLE KEYS */;
INSERT INTO `students` VALUES (1,'Shi Zhongyu',22,'M',2,3),(2,'Shi Potian',22,'M',1,7),(3,'Xie Yanke',53,'M',2,16),(4,'Ding Dian',32,'M',4,4),(5,'Yu Yutong',26,'M',3,1),(6,'Shi Qing',46,'M',5,NULL),(7,'Xi Ren',19,'F',3,NULL),(8,'Lin Daiyu',17,'F',7,NULL),(9,'Ren Yingying',20,'F',6,NULL),(10,'Yue Lingshan',19,'F',3,NULL),(11,'Yuan Chengzhi',23,'M',6,NULL),(12,'Wen Qingqing',19,'F',1,NULL),(13,'Tian Boguang',33,'M',2,NULL),(14,'Lu Wushuang',17,'F',3,NULL),(15,'Duan Yu',19,'M',4,NULL),(16,'Xu Zhu',21,'M',1,NULL),(17,'Lin Chong',25,'M',4,NULL),(18,'Hua Rong',23,'M',7,NULL),(19,'Xue Baochai',18,'F',6,NULL),(20,'Diao Chan',19,'F',7,NULL),(21,'Huang Yueying',22,'F',6,NULL),(22,'Xiao Qiao',20,'F',1,NULL),(23,'Ma Chao',23,'M',4,NULL),(24,'Xu Xian',27,'M',NULL,NULL),(25,'Sun Dasheng',100,'M',NULL,NULL);
/*!40000 ALTER TABLE `students` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teachers`
--

DROP TABLE IF EXISTS `teachers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `teachers` (
  `TID` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) NOT NULL,
  `Age` tinyint(3) unsigned NOT NULL,
  `Gender` enum('F','M') DEFAULT NULL,
  PRIMARY KEY (`TID`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teachers`
--

LOCK TABLES `teachers` WRITE;
/*!40000 ALTER TABLE `teachers` DISABLE KEYS */;
INSERT INTO `teachers` VALUES (1,'Song Jiang',45,'M'),(2,'Zhang Sanfeng',94,'M'),(3,'Miejue Shitai',77,'F'),(4,'Lin Chaoying',93,'F');
/*!40000 ALTER TABLE `teachers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `toc`
--

DROP TABLE IF EXISTS `toc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `toc` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `CourseID` smallint(5) unsigned DEFAULT NULL,
  `TID` smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `toc`
--

LOCK TABLES `toc` WRITE;
/*!40000 ALTER TABLE `toc` DISABLE KEYS */;
/*!40000 ALTER TABLE `toc` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-09-03  2:51:27
