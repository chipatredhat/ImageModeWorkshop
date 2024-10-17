-- MariaDB dump 10.19  Distrib 10.5.22-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: petclinic
-- ------------------------------------------------------
-- Server version	10.5.22-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `owners`
--
GRANT ALL PRIVILEGES ON petclinic.* TO 'petclinic@%' IDENTIFIED BY 'petclinic';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' IDENTIFIED BY 'rootpassword' WITH GRANT OPTION;

DROP TABLE IF EXISTS `owners`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `owners` (
  `id` int(4) unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(30) DEFAULT NULL,
  `last_name` varchar(30) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `city` varchar(80) DEFAULT NULL,
  `telephone` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `last_name` (`last_name`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `owners`
--

LOCK TABLES `owners` WRITE;
/*!40000 ALTER TABLE `owners` DISABLE KEYS */;
INSERT INTO `owners` VALUES (1,'George','Franklin','110 W. Liberty St.','Madison','6085551023'),(2,'Betty','Davis','638 Cardinal Ave.','Sun Prairie','6085551749'),(3,'Eduardo','Rodriquez','2693 Commerce St.','McFarland','6085558763'),(4,'Harold','Davis','563 Friendly St.','Windsor','6085553198'),(5,'Peter','McTavish','2387 S. Fair Way','Madison','6085552765'),(6,'Jean','Coleman','105 N. Lake St.','Monona','6085552654'),(7,'Jeff','Black','1450 Oak Blvd.','Monona','6085555387'),(8,'Maria','Escobito','345 Maple St.','Madison','6085557683'),(9,'David','Schroeder','2749 Blackhawk Trail','Madison','6085559435'),(10,'Carlos','Estaban','2335 Independence La.','Waunakee','6085555487'),(11,'Burr','Sutter','123 ABC Lane','Wonderland','5555555555');
/*!40000 ALTER TABLE `owners` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pets`
--

DROP TABLE IF EXISTS `pets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pets` (
  `id` int(4) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) DEFAULT NULL,
  `birth_date` date DEFAULT NULL,
  `type_id` int(4) unsigned NOT NULL,
  `owner_id` int(4) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `owner_id` (`owner_id`),
  KEY `type_id` (`type_id`),
  CONSTRAINT `pets_ibfk_1` FOREIGN KEY (`owner_id`) REFERENCES `owners` (`id`),
  CONSTRAINT `pets_ibfk_2` FOREIGN KEY (`type_id`) REFERENCES `types` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pets`
--

LOCK TABLES `pets` WRITE;
/*!40000 ALTER TABLE `pets` DISABLE KEYS */;
INSERT INTO `pets` VALUES (1,'Leo','2000-09-07',1,1),(2,'Basil','2002-08-06',6,2),(3,'Rosy','2001-04-17',2,3),(4,'Jewel','2000-03-07',2,3),(5,'Iggy','2000-11-30',3,4),(6,'George','2000-01-20',4,5),(7,'Samantha','1995-09-04',1,6),(8,'Max','1995-09-04',1,6),(9,'Lucky','1999-08-06',5,7),(10,'Mulligan','1997-02-24',2,8),(11,'Freddy','2000-03-09',5,9),(12,'Lucky','2000-06-24',2,10),(13,'Sly','2002-06-08',1,10);
/*!40000 ALTER TABLE `pets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `specialties`
--

DROP TABLE IF EXISTS `specialties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `specialties` (
  `id` int(4) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `specialties`
--

LOCK TABLES `specialties` WRITE;
/*!40000 ALTER TABLE `specialties` DISABLE KEYS */;
INSERT INTO `specialties` VALUES (3,'dentistry'),(1,'radiology'),(2,'surgery');
/*!40000 ALTER TABLE `specialties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `types`
--

DROP TABLE IF EXISTS `types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `types` (
  `id` int(4) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `types`
--

LOCK TABLES `types` WRITE;
/*!40000 ALTER TABLE `types` DISABLE KEYS */;
INSERT INTO `types` VALUES (5,'bird'),(1,'cat'),(2,'dog'),(6,'hamster'),(3,'lizard'),(4,'snake');
/*!40000 ALTER TABLE `types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vet_specialties`
--

DROP TABLE IF EXISTS `vet_specialties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vet_specialties` (
  `vet_id` int(4) unsigned NOT NULL,
  `specialty_id` int(4) unsigned NOT NULL,
  UNIQUE KEY `vet_id` (`vet_id`,`specialty_id`),
  KEY `specialty_id` (`specialty_id`),
  CONSTRAINT `vet_specialties_ibfk_1` FOREIGN KEY (`vet_id`) REFERENCES `vets` (`id`),
  CONSTRAINT `vet_specialties_ibfk_2` FOREIGN KEY (`specialty_id`) REFERENCES `specialties` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vet_specialties`
--

LOCK TABLES `vet_specialties` WRITE;
/*!40000 ALTER TABLE `vet_specialties` DISABLE KEYS */;
INSERT INTO `vet_specialties` VALUES (2,1),(3,2),(3,3),(4,2),(5,1);
/*!40000 ALTER TABLE `vet_specialties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vets`
--

DROP TABLE IF EXISTS `vets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vets` (
  `id` int(4) unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(30) DEFAULT NULL,
  `last_name` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `last_name` (`last_name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vets`
--

LOCK TABLES `vets` WRITE;
/*!40000 ALTER TABLE `vets` DISABLE KEYS */;
INSERT INTO `vets` VALUES (1,'James','Carter'),(2,'Helen','Leary'),(3,'Linda','Douglas'),(4,'Rafael','Ortega'),(5,'Henry','Stevens'),(6,'Sharon','Jenkins');
/*!40000 ALTER TABLE `vets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `visits`
--

DROP TABLE IF EXISTS `visits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `visits` (
  `id` int(4) unsigned NOT NULL AUTO_INCREMENT,
  `pet_id` int(4) unsigned NOT NULL,
  `visit_date` date DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pet_id` (`pet_id`),
  CONSTRAINT `visits_ibfk_1` FOREIGN KEY (`pet_id`) REFERENCES `pets` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visits`
--

LOCK TABLES `visits` WRITE;
/*!40000 ALTER TABLE `visits` DISABLE KEYS */;
INSERT INTO `visits` VALUES (1,7,'2010-03-04','rabies shot'),(2,8,'2011-03-04','rabies shot'),(3,8,'2009-06-04','neutered'),(4,7,'2008-09-04','spayed');
/*!40000 ALTER TABLE `visits` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-10-16 17:38:44
