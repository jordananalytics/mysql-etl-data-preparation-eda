-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: localhost    Database: mysql_project
-- ------------------------------------------------------
-- Server version	8.0.45

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `deleted_records`
--

DROP TABLE IF EXISTS `deleted_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `deleted_records` (
  `price` int DEFAULT NULL,
  `price_category` text,
  `type` text,
  `beds` int DEFAULT NULL,
  `baths` int DEFAULT NULL,
  `address` text,
  `furnishing` text,
  `completion_status` text,
  `post_date` date DEFAULT NULL,
  `average_rent` int DEFAULT NULL,
  `building_name` text,
  `year_of_completion` int DEFAULT NULL,
  `total_parking_spaces` int DEFAULT NULL,
  `total_floors` int DEFAULT NULL,
  `total_building_area_sqft` int DEFAULT NULL,
  `elevators` int DEFAULT NULL,
  `area_name` text,
  `city` text,
  `country` text,
  `Latitude` double DEFAULT NULL,
  `Longitude` double DEFAULT NULL,
  `purpose` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deleted_records`
--

LOCK TABLES `deleted_records` WRITE;
/*!40000 ALTER TABLE `deleted_records` DISABLE KEYS */;
INSERT INTO `deleted_records` VALUES (0,'Average','Apartment',2,3,'SLS Residence Palm Jumeirah, Palm Jumeirah, Dubai','Unfurnished','Off-Plan','2024-04-08',0,'UNKNOWN',0,0,0,0,0,'Palm Jumeirah','Dubai','UAE',25.10019025,55.11853499506269,'For Sale'),(0,'Average','Apartment',2,3,'SLS Residence Palm Jumeirah, Palm Jumeirah, Dubai','Unfurnished','Off-Plan','2024-04-09',0,'UNKNOWN',0,0,0,0,0,'Palm Jumeirah','Dubai','UAE',25.1180879,55.1342009,'For Sale'),(0,'Average','Penthouse',4,5,'SLS Residence Palm Jumeirah, Palm Jumeirah, Dubai','Unfurnished','Off-Plan','2024-04-08',0,'UNKNOWN',0,0,0,0,0,'Palm Jumeirah','Dubai','UAE',25.10019025,55.11853499506269,'For Sale'),(0,'Average','Villa',4,4,'Garden Homes Frond A, Garden Homes Palm Jumeirah, Palm Jumeirah, Dubai','Unfurnished','Ready','2024-02-14',1311464,'UNKNOWN',0,0,0,0,0,'Palm Jumeirah','Dubai','UAE',25.10019025,55.11853499506269,'For Sale'),(0,'Average','Villa',4,5,'Balqis Residence Villas, Balqis Residence, Kingdom of Sheba, Palm Jumeirah, Dubai','Unfurnished','Ready','2024-03-22',949695,'UNKNOWN',0,0,0,0,0,'Palm Jumeirah','Dubai','UAE',25.10019025,55.11853499506269,'For Sale'),(0,'Average','Villa',5,6,'Al Barsha 3, Al Barsha, Dubai','Unfurnished','Ready','2024-03-29',681900,'UNKNOWN',0,0,0,0,0,'Al Barsha','Dubai','UAE',25.096326,55.1984022,'For Sale'),(0,'Average','Apartment',5,6,'The Royal Atlantis Resort & Residences, The Crescent, Palm Jumeirah, Dubai','Unfurnished','Ready','2023-12-07',0,'THE ROYAL ATLANTIS RESORT & RESIDENCES',2022,1634,40,4,34,'Palm Jumeirah','Dubai','UAE',25.1180879,55.1342009,'For Sale'),(0,'Average','Apartment',1,1,'Ruby, Tiara Residences, Palm Jumeirah, Dubai','Unfurnished','Ready','2024-02-20',235177,'RUBY',2009,0,16,275,0,'Palm Jumeirah','Dubai','UAE',25.10019025,55.11853499506269,'For Sale'),(0,'Average','Apartment',2,3,'Azizi Mina, Palm Jumeirah, Dubai','Furnished','Ready','2024-01-11',262141,'AZIZI MINA',2021,238,11,549,8,'Palm Jumeirah','Dubai','UAE',25.1180879,55.1342009,'For Sale'),(0,'Average','Apartment',2,3,'Golden Mile 5, Golden Mile, Palm Jumeirah, Dubai','Unfurnished','Ready','2024-02-15',220260,'GOLDEN MILE 5',2009,256,13,533,28,'Palm Jumeirah','Dubai','UAE',25.10019025,55.11853499506269,'For Sale'),(0,'Average','Apartment',2,3,'Maurya, The Grandeur Residences, Palm Jumeirah, Dubai','Furnished','Ready','2024-04-05',200633,'GRANDUER RESIDENCES-MAURYA',2012,0,6,220,0,'Palm Jumeirah','Dubai','UAE',25.1180879,55.1342009,'For Sale'),(0,'Average','Apartment',2,3,'Park Gate Residence A, Park Gate Residence, Al Kifaf, Bur Dubai, Dubai','Furnished','Ready','2023-12-12',185117,'PARK GATE RESIDENCES 1',2020,1010,31,728,6,'Bur Dubai','Dubai','UAE',25.23559045,55.29672026315799,'For Sale'),(0,'Average','Apartment',3,5,'The Royal Atlantis Resort & Residences, The Crescent, Palm Jumeirah, Dubai','Unfurnished','Ready','2023-09-19',1229719,'THE ROYAL ATLANTIS RESORT & RESIDENCES',2022,1634,40,4,34,'Palm Jumeirah','Dubai','UAE',25.10019025,55.11853499506269,'For Sale'),(0,'Average','Apartment',3,5,'The Royal Atlantis Resort & Residences, The Crescent, Palm Jumeirah, Dubai','Unfurnished','Ready','2023-12-07',1179894,'THE ROYAL ATLANTIS RESORT & RESIDENCES',2022,1634,40,4,34,'Palm Jumeirah','Dubai','UAE',25.1180879,55.1342009,'For Sale'),(0,'Average','Apartment',3,5,'The Royal Atlantis Resort & Residences, The Crescent, Palm Jumeirah, Dubai','Unfurnished','Ready','2024-03-27',1186468,'THE ROYAL ATLANTIS RESORT & RESIDENCES',2022,1634,40,4,34,'Palm Jumeirah','Dubai','UAE',25.1180879,55.1342009,'For Sale'),(0,'Average','Penthouse',4,5,'Al Hallawi, Shoreline Apartments, Palm Jumeirah, Dubai','Unfurnished','Ready','2024-03-08',569000,'AL HALLAWI',2009,0,11,245,0,'Palm Jumeirah','Dubai','UAE',25.1180879,55.1342009,'For Sale'),(490000,'Average','Apartment',0,1,'Orchid B, Orchid, DAMAC Hills, Dubai','Unfurnished','Ready','2023-11-30',28121,'DAMAC HILLS - ORCHID B',2018,192,8,93,2,'DAMAC Hills','Dubai','UAE',25.0281481,55.264246,'For Sale'),(530000,'Average','Apartment',0,1,'Artesia A, Artesia, DAMAC Hills, Dubai','Furnished','Ready','2024-03-11',53381,'DAMAC HILLS - ARTESIA TOWER A',2021,968,28,615,10,'DAMAC Hills','Dubai','UAE',25.0279508,55.2649127,'For Sale'),(1400000,'Medium','Apartment',1,1,'Park Heights 1, Park Heights, Dubai Hills Estate, Dubai','Unfurnished','Ready','2024-04-22',94608,'PARK HEIGHTS I',2020,315,20,534,5,'Dubai Hills Estate','Dubai','UAE',25.12689085,55.263874387067744,'For Sale'),(1900000,'Medium','Apartment',2,1,'Collective 2.0 Tower A, Collective 2.0, Dubai Hills Estate, Dubai','Unfurnished','Ready','2024-03-19',137440,'COLLECTIVE 2.0 TOWER A',2022,242,18,345,5,'Dubai Hills Estate','Dubai','UAE',25.12689085,55.263874387067744,'For Sale'),(1950000,'Medium','Apartment',1,1,'Al Jazi, Madinat Jumeirah Living, Umm Suqeim, Dubai','Unfurnished','Off-Plan','2024-03-18',0,'UNKNOWN',0,0,0,0,0,'Umm Suqeim','Dubai','UAE',25.1647586,55.2187285,'For Sale'),(2000000,'Medium','Apartment',2,2,'Hills Park, Dubai Hills Estate, Dubai','Unfurnished','Off-Plan','2024-02-28',0,'HILLS PARK',0,497,22,834,6,'Dubai Hills Estate','Dubai','UAE',25.12689085,55.263874387067744,'For Sale'),(2100000,'Medium','Townhouse',2,3,'Noya Viva, Noya, Yas Island, Abu Dhabi','Unfurnished','Off-Plan','2024-04-15',0,'UNKNOWN',0,0,0,0,0,'Yas Island','Abu Dhabi','UAE',24.4940223,54.6073721,'For Sale'),(2200000,'Medium','Townhouse',3,4,'Bloom Living, Zayed City, Abu Dhabi','Unfurnished','Off-Plan','2024-04-16',0,'UNKNOWN',0,0,0,0,0,'Zayed City','Abu Dhabi','UAE',24.36917605,54.59059179361312,'For Sale'),(2800000,'Medium','Villa',4,5,'Al Raha Gardens, Abu Dhabi','Unfurnished','Ready','2024-04-17',103920,'UNKNOWN',0,0,0,0,0,'Al Raha Gardens','Abu Dhabi','UAE',24.43839295,54.58828682847664,'For Sale'),(3150000,'High','Apartment',1,2,'Palm Beach Tower 1, The Palm Beach Towers, Palm Jumeirah, Dubai','Unfurnished','Off-Plan','2023-12-01',0,'PALM BEACH TOWERS -1',0,561,54,1,5,'Palm Jumeirah','Dubai','UAE',25.1180879,55.1342009,'For Sale'),(3500000,'High','Villa',4,5,'Noya Viva, Noya, Yas Island, Abu Dhabi','Unfurnished','Off-Plan','2024-04-19',0,'UNKNOWN',0,0,0,0,0,'Yas Island','Abu Dhabi','UAE',24.4940223,54.6073721,'For Sale'),(3600000,'High','Villa',4,5,'Noya Viva, Noya, Yas Island, Abu Dhabi','Unfurnished','Off-Plan','2024-04-19',0,'UNKNOWN',0,0,0,0,0,'Yas Island','Abu Dhabi','UAE',24.4940223,54.6073721,'For Sale'),(3800000,'High','Villa',4,5,'Noya Viva, Noya, Yas Island, Abu Dhabi','Unfurnished','Off-Plan','2024-04-17',0,'UNKNOWN',0,0,0,0,0,'Yas Island','Abu Dhabi','UAE',24.4940223,54.6073721,'For Sale'),(4000000,'High','Townhouse',4,5,'The Sustainable City, Yas Island, Abu Dhabi','Unfurnished','Off-Plan','2024-04-15',0,'UNKNOWN',0,0,0,0,0,'Yas Island','Abu Dhabi','UAE',24.4940223,54.6073721,'For Sale'),(4000000,'High','Apartment',2,2,'Jadeel Building 3, Jadeel, Madinat Jumeirah Living, Umm Suqeim, Dubai','Unfurnished','Off-Plan','2024-01-30',0,'UNKNOWN',0,0,0,0,0,'Umm Suqeim','Dubai','UAE',25.1647586,55.2187285,'For Sale'),(4400000,'High','Villa',4,5,'Noya Viva, Noya, Yas Island, Abu Dhabi','Unfurnished','Off-Plan','2024-04-19',0,'UNKNOWN',0,0,0,0,0,'Yas Island','Abu Dhabi','UAE',24.4940223,54.6073721,'For Sale'),(4700000,'High','Villa',3,4,'Nad Al Sheba Gardens, Nad Al Sheba 1, Nad Al Sheba, Dubai','Unfurnished','Off-Plan','2023-11-28',0,'UNKNOWN',0,0,0,0,0,'Nad Al Sheba','Dubai','UAE',25.1597355,55.3436278,'For Sale'),(7000000,'High','Villa',3,4,'Golf Grove, Dubai Hills Estate, Dubai','Unfurnished','Ready','2024-04-22',396014,'UNKNOWN',0,0,0,0,0,'Dubai Hills Estate','Dubai','UAE',25.12689085,55.263874387067744,'For Sale');
/*!40000 ALTER TABLE `deleted_records` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-07-05 18:05:12
