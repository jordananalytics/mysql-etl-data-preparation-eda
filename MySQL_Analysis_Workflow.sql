/*
DATA PREPARATION

This section cleans and standardizes the raw dataset
before analysis.

The preparation process includes:
- Standardizing date formats
- Cleaning text values
- Detecting and removing duplicates
- Preserving deleted records
- Creating indexes for performance
- Automating recurring ETL tasks
*/


/*
Convert the post_date column from text format
to a proper DATE data type to enable accurate
date filtering and calculations.
*/

UPDATE uae_real_estate 
SET  post_date = STR_TO_DATE(post_date ,'%Y-%m-%d '  ) ;

ALTER TABLE uae_real_estate 
MODIFY  post_date   DATE  ;


/*
Standardize text fields by:

- Removing leading and trailing spaces
- Converting building names to uppercase
for consistent grouping
- Cleaning location and property attributes
*/ 

UPDATE uae_real_estate_project 
SET building_name =  TRIM(UPPER(building_name)) ,
 address = TRIM(address),
 furnishing =TRIM(furnishing) ,
 completion_status = TRIM(completion_status) ,
 country =TRIM(country) ,
 city = TRIM(city)  ;

/*
DUPLICATE DETECTION

A staging table is created to safely identify
duplicate records without modifying the original
dataset.

ROW_NUMBER() is used to assign a sequence number
to records sharing identical property attributes.
Only the first occurrence is retained.
*/

CREATE TABLE `uae_real_estate_project` (
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
  `purpose` text ,
  duplicates int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*
Populate the staging table while assigning
a row number to each duplicate group.

Rows with duplicates > 1 are considered
duplicate records.
*/

INSERT INTO  
`uae_real_estate_project` 
SELECT *  , 
		ROW_NUMBER() 
		OVER( PARTITION BY price ,price_category , `type` , beds ,baths ,address ,furnishing ,completion_status
		 ,post_date ,average_rent ,building_name ,year_of_completion ,total_parking_spaces ,total_floors ,total_building_area_sqft 
		 ,elevators ,area_name ,city ,country ,Latitude ,Longitude ,purpose
             ORDER BY post_date DESC)  duplicate
		FROM uae_real_estate ;
 
 
SELECT *
FROM uae_real_estate_project
WHERE duplicates >1   ; 

/*
Create an archive table to store deleted records.

Keeping deleted data provides an audit trail and
allows recovery if records are removed by mistake.
*/
 
CREATE  TABLE deleted_records 
LIKE uae_real_estate_project ;

ALTER TABLE  deleted_records 
DROP COLUMN  duplicates ;
/*
Trigger Purpose

Whenever a row is deleted from the staging table,
the deleted record is automatically copied into
the deleted_records table.

This preserves historical data for auditing
and future reference.
*/
DELIMITER $$
CREATE TRIGGER Insert_deleted
AFTER DELETE ON mysql_project.uae_real_estate_project 
FOR EACH ROW 

INSERT INTO deleted_records ( price, price_category,type,beds ,baths ,address ,furnishing ,completion_status
 ,post_date ,average_rent ,building_name ,year_of_completion ,total_parking_spaces ,total_floors
 ,total_building_area_sqft ,elevators ,area_name, city ,country ,Latitude ,Longitude ,purpose ) 
 
VALUES( OLD.price ,OLD.price_category ,OLD.type ,OLD.beds ,OLD.baths ,OLD.address ,OLD.furnishing
,OLD.completion_status ,OLD.post_date ,OLD.average_rent ,OLD.building_name ,OLD.year_of_completion ,
OLD.total_parking_spaces ,OLD.total_floors ,OLD.total_building_area_sqft ,OLD.elevators ,OLD.area_name 
,OLD.city ,OLD.country ,OLD.Latitude ,OLD.Longitude , OLD.purpose )
$$ 
DELIMITER ; 
 
 
 
 
 
 
 -- DUPLICATE DELETION 
 
SELECT * 
FROM uae_real_estate_project
WHERE duplicates > 1 ;
 
 
 
DELETE 
FROM uae_real_estate_project
WHERE duplicates > 1 ;


ALTER TABLE uae_real_estate_project
DROP COLUMN   duplicates ;

/*
Assign a unique identifier to each property.

The Property_id column acts as the primary key
and ensures every record can be uniquely referenced.
*/

 ALTER TABLE uae_real_estate_project 
 ADD COLUMN Property_id  INT  AUTO_INCREMENT PRIMARY KEY  FIRST; 
 
/*
Purpose:
Create indexes on frequently queried columns to improve
search, filtering, sorting, and ETL performance.
Indexes were selected based on query patterns rather than
indexing every column to avoid unnecessary write overhead.
*/

 CREATE INDEX idx_city
ON uae_real_estate_project(city(100));

CREATE INDEX idx_post_date
ON uae_real_estate_project(post_date);

CREATE INDEX idx_price
ON uae_real_estate_project(price);

CREATE INDEX idx_city_area
ON uae_real_estate_project(city(100), area_name(100));
 


/*
AUTOMATED ETL PROCESS

Runs every 60 minutes to maintain data quality by:

1. Removing duplicate records
2. Standardizing text fields
3. Deleting invalid records

This minimizes manual maintenance and keeps the
dataset analysis-ready.
*/

DELIMITER $$
 CREATE EVENT  ETL
 ON SCHEDULE EVERY 60 MINUTE
  DO 
  BEGIN 
  
  
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


/*
Remove records that contain placeholder or
invalid values.

Properties with zero values for essential
attributes are treated as incomplete records.
*/
 
DELETE
FROM uae_real_estate_project
WHERE price <= 0 
AND total_floors = 0 
AND  year_of_completion = 0
AND  total_building_area_sqft = 0 
 ;
 
DELETE 
FROM uae_real_estate_project 
WHERE average_rent = 0
AND price <= 0
 ;

DELETE 
FROM uae_real_estate_project
WHERE price <= 0;

END $$
DELIMITER ;





/*
EXPLORATORY DATA ANALYSIS (EDA)

Frequently used analytical queries are stored as
procedures to simplify reporting and encourage
code reuse.
*/


/*
Calculate high-level business metrics including:

- Total properties
- Total property value
- Highest property price
- Total average rental value
*/

DELIMITER $$
CREATE PROCEDURE  PERFOMANCE_INDICATORS()
BEGIN 
SELECT  
count(*) AS Total_properties ,
SUM(price ) AS Total_Property_Value ,
ROUND(AVG(price),2) AS Average_price ,
MAX(price) AS Highest_Price,
SUM(average_rent) AS Total_Average_rent
FROM uae_real_estate_project 
;
END $$
DELIMITER ;


-/*
Calculate the average property price
for each city.
*/

DELIMITER $$
CREATE PROCEDURE AVERAGE_PROPERTY_PRICE()
BEGIN

SELECT 
city ,
ROUND(AVG(price),2)AS Average_Price
FROM uae_real_estate_project 
GROUP BY city
ORDER BY Average_Price  ;
/*
Fujailar  is the top city with  average price of AED 6 millions 
followed by Al alin and Dubai which accounts of  AED 9.36 millions 

*/
END $$
DELIMITER ;

/*
Rank the top 50 most valuable areas based on
the total value of listed properties.
*/

DELIMITER $$
CREATE PROCEDURE TOP_50_EXPENSIVE_AREAS()

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
LIMIT 50 
;
END $$
DELIMITER ;


/*
Rank the top 50 most cheapest areas based on
the total value of listed properties.
*/

DELIMITER &&
CREATE PROCEDURE TOP_50_CHEAPEST_AREAS()
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
END &&
DELIMITER ;








/*
 Calculates total properties by city 
and city value 
*/

DELIMITER $$
CREATE PROCEDURE PROPERTY_VALUE()
BEGIN
SELECT 
city ,
COUNT(*) AS Total_Properties ,
SUM(price) AS Total_price
FROM uae_real_estate_project
GROUP BY city 
;
END $$
DELIMITER ;

/*
calculates the area price status for every last
30 days
*/
DELIMITER $$
CREATE PROCEDURE AREA_PRICE_STATUS_LAST_30DAYS()
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
    END $$
    DELIMITER ;
    

/*
Calculates the total listings for each property type and
their percentage distribution across all property listings
*/

DELIMITER &&
CREATE PROCEDURE PROPERTY_TYPE_DISTRIBUTION()
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
END &&
DELIMITER ;



/*
Create a reusable view containing properties
posted during the most recent complete month
available in the dataset.
*/

CREATE VIEW Properties_posted_last_month
AS
SELECT *
FROM  uae_real_estate_project
WHERE YEAR(post_date) =YEAR( ( SELECT 
 MAX(post_date) 
 FROM uae_real_estate_project))
 AND MONTH(post_date) = 
 (SELECT
MONTH(MAX(post_date))-1 
FROM 
uae_real_estate_project )
ORDER BY post_date ;











  
  


 
 

