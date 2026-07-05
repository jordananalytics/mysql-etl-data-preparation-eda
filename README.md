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




