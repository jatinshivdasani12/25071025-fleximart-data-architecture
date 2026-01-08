# Star Schema Design - Fleximart Data Warehouse

## Section 1: Schema Overview

### FACT TABLE: fact_sales

**Grain:**  
One row per product per order line item

**Business Process:**  
Sales transactions

**Measures (Numeric Facts):**
- quantity_sold: Number of units sold
- unit_price: Price per unit at time of sale
- discount_amount: Discount applied
- total_amount: Final amount (quantity × unit_price − discount)

**Foreign Keys:**
- date_key → dim_date
- product_key → dim_product
- customer_key → dim_customer
### DIMENSION TABLE: dim_date

**Purpose:**  
Date dimension for time-based analysis

**Type:**  
Conformed dimension

**Attributes:**
- date_key (PK): Surrogate key (integer, format YYYYMMDD)
- full_date: Actual calendar date
- day_of_week: Monday, Tuesday, etc.
- month: 1–12
- month_name: January, February, etc.
- quarter: Q1, Q2, Q3, Q4
- year: 2023, 2024, etc.
- is_weekend: Boolean flag
### DIMENSION TABLE: dim_product

**Purpose:**  
Stores descriptive product attributes for product-level analysis.

**Type:**  
Slowly Changing Dimension (Type 2)

**Attributes:**
- product_key (PK): Surrogate key
- product_id: Business product identifier
- product_name: Name of the product
- category: Product category
- subcategory: Product sub-classification
- brand: Product brand
- standard_price: Base price
- warranty_months: Warranty duration
- is_active: Product availability status
### DIMENSION TABLE: dim_customer

**Purpose:**  
Stores customer profile and demographic information.

**Type:**  
Slowly Changing Dimension (Type 2)

**Attributes:**
- customer_key (PK): Surrogate key
- customer_id: Business customer identifier
- first_name: Customer first name
- last_name: Customer last name
- email: Customer email
- phone: Contact number
- city: City of residence
- registration_date: Customer registration date
- customer_segment: Customer classification
- is_active: Customer status

## Section 2: Design Decisions

The granularity of the fact table was chosen at the transaction line-item level to capture the most detailed representation of sales activity. Each record represents a single product within an order, allowing precise analysis of quantities sold, pricing, discounts, and revenue. This level of detail enables flexible reporting, such as product-wise sales, customer purchase behavior, and time-based trends, while still allowing aggregation to higher levels.

Surrogate keys were used instead of natural keys to improve performance and maintain historical accuracy. Natural keys from source systems may change over time or contain inconsistencies, whereas surrogate keys provide stable, system-generated identifiers. This approach also simplifies joins between fact and dimension tables and supports Slowly Changing Dimensions for tracking historical changes in product and customer attributes.

The star schema design supports drill-down and roll-up operations by organizing data around a central fact table with descriptive dimensions. Analysts can easily roll up data by month, category, or city, or drill down to individual transactions, products, or customers for detailed insights.


## Section 3: Sample Data Flow

### Source Transaction
Order ID: 101  
Customer: John Doe  
Product: Laptop  
Quantity: 2  
Unit Price: 50,000  

---

### Data Warehouse Representation

**fact_sales**
date_key: 20240115
product_key: 5
customer_key: 12
quantity_sold: 2
unit_price: 50000
total_amount: 100000

**dim date**
date_key: 20240115
full_date: 2024-01-15
day_of_week: Monday
month: 1
quarter: Q1
year: 2024

**dim product**
product_key: 5
product_name: Laptop
category: Electronics
subcategory: Laptops

**dim customer**
customer_key: 12
customer_name: John Doe
city: Mumbai

This example demonstrates how a single sales transaction from the source system is decomposed into fact and dimension tables in the data warehouse, enabling efficient analytical querying and dimensional analysis.
