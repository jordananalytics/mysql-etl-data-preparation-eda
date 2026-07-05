# End-to-End MySQL ETL, Data Preparation & Exploratory Data Analysis

## Project Overview

This project demonstrates an end-to-end SQL workflow using MySQL, covering the complete data preparation process from raw data to business-ready insights. The dataset contains UAE real estate listings and is transformed through a structured ETL pipeline that cleans, standardizes, validates, and optimizes the data before performing exploratory data analysis (EDA).

The project also showcases database automation through scheduled events, data integrity using triggers, performance optimization with indexes, and reusable analytical components such as stored procedures and views.

Rather than focusing solely on querying data, this project demonstrates how MySQL can be used to build a maintainable and efficient data pipeline that supports reliable business analysis.

## Project Objectives

The primary objective of this project is to demonstrate how MySQL can be used to build a complete data preparation and analysis pipeline for real-world datasets.

The project focuses on the following objectives:

* Transform raw real estate data into a clean, standardized, and analysis-ready dataset.
* Detect and remove duplicate records while preserving deleted data through an audit table.
* Improve query performance using strategically designed indexes.
* Automate recurring ETL tasks using the MySQL Event Scheduler.
* Maintain data integrity through database triggers.
* Create reusable stored procedures for common business reports.
* Build SQL views to simplify access to frequently used datasets.
* Perform exploratory data analysis (EDA) to uncover trends and generate business insights from UAE real estate listings.
* Apply SQL best practices to produce a scalable, maintainable, and efficient database workflow.

## Skills Demonstrated

This project demonstrates practical experience with the following MySQL concepts and database development techniques:

### Data Preparation

* Data cleaning and standardization
* Date conversion and formatting
* Text normalization using string functions
* Data validation and quality improvement

### Database Design

* Primary keys
* Staging tables
* Archive tables
* Database views

### SQL Programming

* Common Table Expressions (CTEs)
* Window Functions
* Aggregate Functions
* Conditional Logic (`CASE`)
* Stored Procedures
* Views

### Database Automation

* Triggers
* Event Scheduler
* Automated ETL workflows

### Performance Optimization

* Single-column indexes
* Composite indexes
* Query optimization techniques

### Data Analysis

* Exploratory Data Analysis (EDA)
* Business KPI calculations
* Ranking and segmentation
* Property distribution analysis
* Trend analysis
* Business reporting


## Project Workflow

The project follows a structured ETL and analytics pipeline to transform raw real estate data into reliable business insights.

```text
                    Raw UAE Real Estate Dataset
                               │
                               ▼
                     Data Preparation & Cleaning
          • Standardize dates and text values
          • Remove invalid records
          • Detect duplicate records
                               │
                               ▼
                   Duplicate Management
          • Archive deleted records using a trigger
          • Remove duplicate records
                               │
                               ▼
                   Database Optimization
          • Create primary key
          • Build single and composite indexes
                               │
                               ▼
                      ETL Automation
          • Schedule automated data cleaning
          • Maintain data quality with Event Scheduler
                               │
                               ▼
                 Analytical Data Modeling
          • Stored Procedures
          • Views
          • Reusable analytical queries
                               │
                               ▼
               Exploratory Data Analysis (EDA)
          • KPI calculations
          • Property distribution
          • Area and city rankings
          • Price segmentation
          • Business insights
```



## Standardizing Date Formats

The `post_date` column was originally stored as text. To enable accurate filtering, sorting, and date-based analysis, it was converted to the MySQL `DATE` data type.

```sql
/*
Convert the post_date column from text format
to a proper DATE data type to enable accurate
date filtering and calculations.
*/

UPDATE uae_real_estate 
SET post_date = STR_TO_DATE(post_date ,'%Y-%m-%d '  ) ;

ALTER TABLE uae_real_estate 
MODIFY post_date DATE;
```

## Standardizing Text Fields

To improve data consistency, text values were standardized by removing unnecessary spaces and converting building names to uppercase. This ensures consistent grouping, filtering, and reporting across the dataset.

```sql
/*
Standardize text fields by:

- Removing leading and trailing spaces
- Converting building names to uppercase
for consistent grouping
- Cleaning location and property attributes
*/ 

UPDATE uae_real_estate_project 
SET building_name = TRIM(UPPER(building_name)),
    address = TRIM(address),
    furnishing = TRIM(furnishing),
    completion_status = TRIM(completion_status),
    country = TRIM(country),
    city = TRIM(city);
```

## Duplicate Detection (Staging Table)

To ensure data integrity, a staging table was created to detect duplicate records without modifying the original dataset. This approach allows safe identification and analysis of duplicates before removal.

The `ROW_NUMBER()` window function is used to assign a rank to each record within identical groups of property attributes. Records with a rank greater than 1 are considered duplicates.

```sql
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
  `purpose` text,
  duplicates int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO uae_real_estate_project 
SELECT *,
       ROW_NUMBER() OVER (
           PARTITION BY price, price_category, type, beds, baths, address,
                        furnishing, completion_status, post_date, average_rent,
                        building_name, year_of_completion, total_parking_spaces,
                        total_floors, total_building_area_sqft, elevators,
                        area_name, city, country, Latitude, Longitude, purpose
           ORDER BY post_date DESC
       ) AS duplicate
FROM uae_real_estate;
```


## Archive Deleted Records (Audit Table)

To maintain data integrity and create an audit trail, a separate table was created to store deleted records. This ensures that no data is permanently lost and allows recovery or historical tracking if needed.

```sql
/*
Create an archive table to store deleted records.

Keeping deleted data provides an audit trail and
allows recovery if records are removed by mistake.
*/

CREATE TABLE deleted_records 
LIKE uae_real_estate_project ;

ALTER TABLE deleted_records 
DROP COLUMN duplicates ;
```

## Archive Deleted Records (Audit Table)

To maintain data integrity and create an audit trail, a separate table was created to store deleted records. This ensures that no data is permanently lost and allows recovery or historical tracking if needed.

```sql
/*
Create an archive table to store deleted records.

Keeping deleted data provides an audit trail and
allows recovery if records are removed by mistake.
*/

CREATE TABLE deleted_records 
LIKE uae_real_estate_project ;

ALTER TABLE deleted_records 
DROP COLUMN duplicates ;
```


## Trigger for Deleted Records

A trigger was implemented to automatically store deleted records into the archive table whenever a deletion occurs in the main dataset. This ensures that all removed data is preserved without manual intervention.

```sql
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

INSERT INTO deleted_records (
 price, price_category, type, beds, baths, address, furnishing,
 completion_status, post_date, average_rent, building_name,
 year_of_completion, total_parking_spaces, total_floors,
 total_building_area_sqft, elevators, area_name, city,
 country, Latitude, Longitude, purpose
) 
VALUES (
 OLD.price, OLD.price_category, OLD.type, OLD.beds, OLD.baths,
 OLD.address, OLD.furnishing, OLD.completion_status, OLD.post_date,
 OLD.average_rent, OLD.building_name, OLD.year_of_completion,
 OLD.total_parking_spaces, OLD.total_floors,
 OLD.total_building_area_sqft, OLD.elevators, OLD.area_name,
 OLD.city, OLD.country, OLD.Latitude, OLD.Longitude,
 OLD.purpose
)
$$ 
DELIMITER ;
```

## Duplicate Removal (Final Cleaning Step)

After identifying duplicate records using the staging table, duplicates were removed from the main dataset. Only the first occurrence of each record was retained based on the duplicate ranking.

```sql
-- DUPLICATE DELETION 

SELECT * 
FROM uae_real_estate_project
WHERE duplicates > 1 ;

DELETE 
FROM uae_real_estate_project
WHERE duplicates > 1 ;

ALTER TABLE uae_real_estate_project
DROP COLUMN duplicates ;
```


## Primary Key Creation

To uniquely identify each record in the dataset, a surrogate primary key was added. This ensures every property entry can be referenced individually and improves data integrity.

```sql
/*
Assign a unique identifier to each property.

The Property_id column acts as the primary key
and ensures every record can be uniquely referenced.
*/

ALTER TABLE uae_real_estate_project 
ADD COLUMN Property_id INT AUTO_INCREMENT PRIMARY KEY FIRST;
```

## Index Creation (Performance Optimization)

Indexes were created on frequently queried columns to improve query performance, filtering speed, and overall database efficiency. Composite indexing was also used for common query patterns involving multiple columns.

```sql
/*
Purpose:
Create indexes on frequently used columns to improve
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
```


## Automated ETL Process (Event Scheduler)

To maintain data quality continuously, an automated ETL process was created using MySQL Event Scheduler. This process runs every 60 minutes and performs data cleaning, duplicate removal, and removal of invalid records.

This ensures that the dataset remains clean, consistent, and analysis-ready without manual intervention.

```sql
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
CREATE EVENT ETL
ON SCHEDULE EVERY 60 MINUTE
DO 
BEGIN 

-- DUPLICATE DELETION 
WITH duplicates AS (
    SELECT
        Property_id,
        ROW_NUMBER() OVER (
            PARTITION BY price, price_category, type, beds, baths,
                         address, furnishing, completion_status,
                         post_date, average_rent, building_name,
                         year_of_completion, total_parking_spaces,
                         total_floors, total_building_area_sqft,
                         elevators, area_name, city, country,
                         Latitude, Longitude, purpose
            ORDER BY Property_id
        ) AS rn
    FROM uae_real_estate_project
)
DELETE p
FROM uae_real_estate_project p
JOIN duplicates d
ON p.Property_id = d.Property_id
WHERE d.rn > 1;

-- TEXT STANDARDISING 
UPDATE uae_real_estate_project 
SET building_name = TRIM(UPPER(building_name)),
    address = TRIM(address),
    furnishing = TRIM(furnishing),
    completion_status = TRIM(completion_status),
    country = TRIM(country),
    city = TRIM(city);

-- REMOVE INVALID RECORDS 
DELETE
FROM uae_real_estate_project
WHERE price <= 0 
AND total_floors = 0 
AND year_of_completion = 0
AND total_building_area_sqft = 0;

DELETE 
FROM uae_real_estate_project 
WHERE average_rent = 0
AND price <= 0;

DELETE 
FROM uae_real_estate_project
WHERE price <= 0;

END $$
DELIMITER ;
```

## Stored Procedures (Business Performance Analysis)

Stored procedures were created to simplify and reuse common business analysis queries. These procedures provide key performance indicators and insights into the UAE real estate market.

```sql
/*
Calculate high-level business metrics including:

- Total properties
- Total property value
- Highest property price
- Total average rental value
*/

DELIMITER $$
CREATE PROCEDURE PERFOMANCE_INDICATORS()
BEGIN 
SELECT  
COUNT(*) AS Total_properties,
SUM(price) AS Total_Property_Value,
ROUND(AVG(price),2) AS Average_price,
MAX(price) AS Highest_Price,
SUM(average_rent) AS Total_Average_rent
FROM uae_real_estate_project;
END $$
DELIMITER ;
```

## Average Property Price by City

This procedure calculates the average property price for each city, providing insights into regional pricing differences.

```sql
DELIMITER $$
CREATE PROCEDURE AVERAGE_PROPERTY_PRICE()
BEGIN

SELECT 
city,
ROUND(AVG(price),2) AS Average_Price
FROM uae_real_estate_project 
GROUP BY city
ORDER BY Average_Price;

END $$
DELIMITER ;
```


## Top 50 Most Expensive Areas

This procedure identifies the top 50 most expensive areas based on the total value of properties listed in each area. It helps highlight high-value real estate zones in the UAE.

```sql
DELIMITER $$
CREATE PROCEDURE TOP_50_EXPENSIVE_AREAS()

BEGIN

WITH Agg AS (
SELECT
 city,
 area_name, 
 SUM(price) AS Total_cost
FROM uae_real_estate_project
GROUP BY city, area_name 
ORDER BY Total_cost
)

SELECT *,
DENSE_RANK() OVER(ORDER BY Total_cost DESC) AS `Rank`
FROM Agg
LIMIT 50;

END $$
DELIMITER ;
```

## Top 50 Cheapest Areas

This procedure ranks areas based on the lowest total property value, helping identify more affordable real estate zones across the UAE.

```sql
DELIMITER &&
CREATE PROCEDURE TOP_50_CHEAPEST_AREAS()
BEGIN

WITH Aggr AS (
SELECT 
 city,
 area_name,
 SUM(price) AS Total_Value
FROM uae_real_estate_project
GROUP BY city, area_name
)

SELECT *,
DENSE_RANK() OVER(ORDER BY Total_Value) AS `Rank`
FROM Aggr
LIMIT 50;

END &&
DELIMITER ;
```

## Property Value by City

This procedure calculates the total number of properties and total property value per city, providing a regional overview of the real estate market.

```sql
DELIMITER $$
CREATE PROCEDURE PROPERTY_VALUE()
BEGIN

SELECT 
city,
COUNT(*) AS Total_Properties,
SUM(price) AS Total_price
FROM uae_real_estate_project
GROUP BY city;

END $$
DELIMITER ;
```


## Property Type Distribution

This procedure calculates the total number of listings for each property type and their percentage distribution across the entire dataset.

```sql
DELIMITER &&
CREATE PROCEDURE PROPERTY_TYPE_DISTRIBUTION()
BEGIN 

WITH Aggr AS(
SELECT 
type,
COUNT(*) AS Listing
FROM uae_real_estate_project 
GROUP BY type
)

SELECT *,
ROUND(Listing * 100.0 / SUM(Listing) OVER(), 2) AS Distribution
FROM Aggr;

END &&
DELIMITER ;
```

## Area Price Status (Last 30 Days)

This procedure analyzes property price trends over the last 30 days, categorizing areas into price ranges and segments to identify market behavior.

```sql
DELIMITER $$
CREATE PROCEDURE AREA_PRICE_STATUS_LAST_30DAYS()
BEGIN

WITH Base AS (
SELECT *
FROM uae_real_estate_project
WHERE post_date BETWEEN 
    (SELECT DATE_SUB(MAX(post_date), INTERVAL 30 DAY) FROM uae_real_estate_project)
    AND (SELECT MAX(post_date) FROM uae_real_estate_project)
),

Agg AS (
SELECT 
city,
area_name,
SUM(price) AS Total_price 
FROM Base
GROUP BY city, area_name
),

Final AS (
SELECT 
city,
area_name,
CASE
    WHEN Total_price <= 1000000 THEN '< 1M'
    WHEN Total_price <= 3000000 THEN '1M-3M'
    WHEN Total_price <= 10000000 THEN '3M-10M'
    WHEN Total_price <= 50000000 THEN '10M-50M'
    ELSE '50M+'
END AS price_range,
CASE
    WHEN Total_price <= 1000000 THEN 'Affordable'
    WHEN Total_price <= 3000000 THEN 'Mid-Range'
    WHEN Total_price <= 10000000 THEN 'Luxury'
    WHEN Total_price <= 50000000 THEN 'Ultra Luxury'
    ELSE 'Elite'
END AS price_category 
FROM Agg
)

SELECT *
FROM Final;

END $$
DELIMITER ;
```

 ## Properties Posted Last Month (View)

This view extracts properties from the most recent complete month in the dataset, allowing quick access to recent market activity.

```sql
CREATE VIEW Properties_posted_last_month AS
SELECT *
FROM uae_real_estate_project
WHERE YEAR(post_date) = YEAR((SELECT MAX(post_date) FROM uae_real_estate_project))
AND MONTH(post_date) = MONTH((SELECT MAX(post_date) FROM uae_real_estate_project)) - 1
ORDER BY post_date;
```





