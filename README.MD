# FlexiMart Data Architecture Project

**Student Name:** Jatin Shivdasani  
**Student ID:** bitsom_ba_25071025
**Email:** jatinshivdasani@gmail.com
**Date:** 08 January 2026  

---

## Project Overview

This project implements an end-to-end data architecture solution for FlexiMart. It covers relational database design, ETL processing, NoSQL modeling using MongoDB, and data warehouse analytics using a star schema. The project demonstrates both transactional and analytical data processing with realistic business scenarios.

---

## Repository Structure

├── part1-database-etl
│ ├── etl_pipeline.py
│ ├── schema_documentation.md
│ ├── business_queries.sql
│ └── data_quality_report.txt
│
├── part2-nosql
│ ├── nosql_analysis.md
│ ├── mongodb_operations.js
│ └── products_catalog.json
│
├── part3-datawarehouse
│ ├── star_schema_design.md
│ ├── warehouse_schema.sql
│ ├── warehouse_data.sql
│ └── analytics_queries.sql
│
└── README.md

---


## Technologies Used

- Python 3.x, pandas, mysql-connector-python  
- MySQL 8.0  
- MongoDB 6.0 (MongoDB Compass)  

---

## Setup Instructions

### Database Setup (MySQL)

```bash
# Create databases
mysql -u root -p -e "CREATE DATABASE fleximart;"
mysql -u root -p -e "CREATE DATABASE fleximart_dw;"

# Run Part 1 - ETL Pipeline
python part1-database-etl/etl_pipeline.py

# Run Part 1 - Business Queries
mysql -u root -p fleximart < part1-database-etl/business_queries.sql

# Run Part 3 - Data Warehouse
mysql -u root -p fleximart_dw < part3-datawarehouse/warehouse_schema.sql
mysql -u root -p fleximart_dw < part3-datawarehouse/warehouse_data.sql
mysql -u root -p fleximart_dw < part3-datawarehouse/analytics_queries.sql

mongosh < part2-nosql/mongodb_operations.js

Key Learnings

This project helped me understand end-to-end data architecture, including ETL pipelines, data quality handling, NoSQL document modeling, and dimensional data warehouse design. I gained hands-on experience with OLAP queries, star schemas, and MongoDB aggregations used in real-world analytics

Challenges Faced

1. Handling inconsistent raw data formats and ensuring clean transformations during the ETL process.

2. Designing realistic warehouse data while maintaining foreign key integrity across fact and dimension tables.