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









