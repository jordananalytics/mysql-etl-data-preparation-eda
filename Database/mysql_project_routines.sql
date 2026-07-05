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
-- Temporary view structure for view `properties_posted_last_month`
--

DROP TABLE IF EXISTS `properties_posted_last_month`;
/*!50001 DROP VIEW IF EXISTS `properties_posted_last_month`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `properties_posted_last_month` AS SELECT 
 1 AS `Property_id`,
 1 AS `price`,
 1 AS `price_category`,
 1 AS `type`,
 1 AS `beds`,
 1 AS `baths`,
 1 AS `address`,
 1 AS `furnishing`,
 1 AS `completion_status`,
 1 AS `post_date`,
 1 AS `average_rent`,
 1 AS `building_name`,
 1 AS `year_of_completion`,
 1 AS `total_parking_spaces`,
 1 AS `total_floors`,
 1 AS `total_building_area_sqft`,
 1 AS `elevators`,
 1 AS `area_name`,
 1 AS `city`,
 1 AS `country`,
 1 AS `Latitude`,
 1 AS `Longitude`,
 1 AS `purpose`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `properties_posted_last_month`
--

/*!50001 DROP VIEW IF EXISTS `properties_posted_last_month`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `properties_posted_last_month` AS select `uae_real_estate_project`.`Property_id` AS `Property_id`,`uae_real_estate_project`.`price` AS `price`,`uae_real_estate_project`.`price_category` AS `price_category`,`uae_real_estate_project`.`type` AS `type`,`uae_real_estate_project`.`beds` AS `beds`,`uae_real_estate_project`.`baths` AS `baths`,`uae_real_estate_project`.`address` AS `address`,`uae_real_estate_project`.`furnishing` AS `furnishing`,`uae_real_estate_project`.`completion_status` AS `completion_status`,`uae_real_estate_project`.`post_date` AS `post_date`,`uae_real_estate_project`.`average_rent` AS `average_rent`,`uae_real_estate_project`.`building_name` AS `building_name`,`uae_real_estate_project`.`year_of_completion` AS `year_of_completion`,`uae_real_estate_project`.`total_parking_spaces` AS `total_parking_spaces`,`uae_real_estate_project`.`total_floors` AS `total_floors`,`uae_real_estate_project`.`total_building_area_sqft` AS `total_building_area_sqft`,`uae_real_estate_project`.`elevators` AS `elevators`,`uae_real_estate_project`.`area_name` AS `area_name`,`uae_real_estate_project`.`city` AS `city`,`uae_real_estate_project`.`country` AS `country`,`uae_real_estate_project`.`Latitude` AS `Latitude`,`uae_real_estate_project`.`Longitude` AS `Longitude`,`uae_real_estate_project`.`purpose` AS `purpose` from `uae_real_estate_project` where ((year(`uae_real_estate_project`.`post_date`) = year((select max(`uae_real_estate_project`.`post_date`) from `uae_real_estate_project`))) and (month(`uae_real_estate_project`.`post_date`) = (select (month(max(`uae_real_estate_project`.`post_date`)) - 1) from `uae_real_estate_project`))) order by `uae_real_estate_project`.`post_date` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Dumping events for database 'mysql_project'
--
/*!50106 SET @save_time_zone= @@TIME_ZONE */ ;
/*!50106 DROP EVENT IF EXISTS `ETL` */;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8mb4 */ ;;
/*!50003 SET character_set_results = utf8mb4 */ ;;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`localhost`*/ /*!50106 EVENT `ETL` ON SCHEDULE EVERY 60 MINUTE STARTS '2026-06-29 12:56:37' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN 
  
  
  -- DUPLICATE DELETION 
  
  WITH duplicates AS (
    SELECT
        Property_id,
        ROW_NUMBER() OVER (
            PARTITION BY
                price,
                price_category,
                type,
                beds,
                baths,
                address,
                furnishing,
                completion_status,
                post_date,
                average_rent,
                building_name,
                year_of_completion,
                total_parking_spaces,
                total_floors,
                total_building_area_sqft,
                elevators,
                area_name,
                city,
                country,
                Latitude ,
                Longitude ,
                purpose
            ORDER BY Property_id
        ) AS rn
    FROM uae_real_estate_project
)
DELETE p
FROM uae_real_estate_project p
JOIN duplicates d
ON p.Property_id = d.Property_id
WHERE d.rn > 1;

-- TEXT STANDADISING 

UPDATE uae_real_estate_project 
SET building_name =  TRIM(UPPER(building_name)) ,
 address = TRIM(address),
 furnishing =TRIM(furnishing) ,
 completion_status = TRIM(completion_status) ,
 country =TRIM(country) ,
 city = TRIM(city)  ;


-- REMOVING INVALID DATA 
 
DELETE
FROM uae_real_estate_project
WHERE price = 0 
AND total_floors = 0 
AND  year_of_completion = 0
AND  total_building_area_sqft = 0 
 ;
 
DELETE 
FROM uae_real_estate_project 
WHERE average_rent = 0
AND price = 0
 ;

DELETE 
FROM uae_real_estate_project
WHERE price = 0;

END */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
DELIMITER ;
/*!50106 SET TIME_ZONE= @save_time_zone */ ;

--
-- Dumping routines for database 'mysql_project'
--
/*!50003 DROP PROCEDURE IF EXISTS `AREA_PRICE_STATUS_LAST_30DAYS` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AREA_PRICE_STATUS_LAST_30DAYS`()
BEGIN

WITH Base AS (

SELECT *
FROM uae_real_estate_project
WHERE post_date BETWEEN
    (
        SELECT DATE_SUB(MAX(post_date), INTERVAL 30 DAY)
        FROM uae_real_estate_project
    )
    AND
    (
        SELECT MAX(post_date)
        FROM uae_real_estate_project
    )
    ORDER BY post_date
    DESC)
    ,
Agg AS (
    SELECT 
    city ,
    area_name ,
    SUM(price) AS Total_price 
    FROM Base
    GROUP BY CITY , area_name) ,
    
    Final AS(
    SELECT 
    city ,
    area_name ,
     CASE
        WHEN total_price <=1000000 THEN '< 1M'
        WHEN total_price <= 3000000 THEN '1M-3M'
        WHEN total_price <= 10000000 THEN '3M-10M'
        WHEN total_price <= 50000000 THEN '10M-50M'
        ELSE '50M+'
    END AS price_range,
    CASE
    WHEN total_price <= 1000000 THEN 'Affordable'
    WHEN total_price <= 3000000 THEN 'Mid-Range'
    WHEN total_price <= 10000000 THEN 'Luxury'
    WHEN total_price <= 50000000 THEN 'Ultra Luxury'
    ELSE 'Elite'
END AS price_category 
    FROM Agg
    order by Total_price )
    
    SELECT *
    FROM Final 

    ;
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AVERAGE _PROPERTY_PRICE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AVERAGE _PROPERTY_PRICE`()
BEGIN

SELECT 
city ,
ROUND(AVG(price),2)AS Average_Price
FROM uae_real_estate_project 
GROUP BY city
ORDER BY Average_Price  ;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PERFOMANCE_INDICATORS` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PERFOMANCE_INDICATORS`()
BEGIN 
SELECT  
count(*) AS Total_properties ,
SUM(price ) AS Total_Property_Value ,
ROUND(AVG(price),2) AS Average_price ,
MAX(price) AS Highest_Price,
SUM(average_rent) AS Total_Average_rent
FROM uae_real_estate_project 
;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PROPERTY_TYPE_DISTRIBUTION` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PROPERTY_TYPE_DISTRIBUTION`()
BEGIN 
WITH Aggr AS(
SELECT 
type ,
COUNT(*) Listing
FROM uae_real_estate_project 
GROUP BY type)

SELECT * ,
ROUND(Listing*100.0/SUM(Listing) OVER() ,2)
AS Distribution
FROM Aggr
;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PROPERTY_VALUE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PROPERTY_VALUE`()
BEGIN
SELECT 
city ,
COUNT(*) AS Total_Properties ,
SUM(price) AS Total_price
FROM uae_real_estate_project
GROUP BY city 
;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TOP_50_CHEAPEST_AREAS` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `TOP_50_CHEAPEST_AREAS`()
BEGIN
WITH Aggr AS (
SELECT 
city ,
area_name,
SUM(price) AS Total_Value
FROM  
uae_real_estate_project
GROUP BY city ,area_name)

SELECT * ,
DENSE_RANK() 
OVER(ORDER BY Total_Value ) `Rank`
FROM Aggr
LIMIT 50
; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TOP_50_EXPENSIVE_AREAS` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `TOP_50_EXPENSIVE_AREAS`()
BEGIN

WITH Agg AS (
SELECT
 city,
area_name  , 
SUM(PRICE ) Total_cost
FROM uae_real_estate_project
GROUP BY  city, area_name 
ORDER BY Total_cost)
SELECT * ,
DENSE_RANK() OVER(ORDER BY Total_cost DESC) AS `Rank`
FROM 
/*
Palm Jumeirah
Downtown Dubai
Dubai Marina
Dubai Hills Estate
Saadiyat Island 
Are the top five most expendive areas 
accounts of AED 31.12 billions 
*/
Agg 
LIMIT 50  ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-07-05 18:05:13
