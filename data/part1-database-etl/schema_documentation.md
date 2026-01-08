# Database Schema Documentation – FlexiMart

---

## 1. Entity-Relationship Description

### ENTITY: customers

Purpose:
Stores customer master information.

Attributes:
- customer_id: Unique customer identifier (Primary Key)
- first_name: Customer’s first name
- last_name: Customer’s last name
- email: Customer email address (nullable)
- phone: Customer phone number
- city: Customer city of residence
- registration_date: Date when the customer registered

Relationships:
- One customer can place many orders (1:M relationship with orders)


### ENTITY: products

Purpose:
Stores product catalog details.

Attributes:
- product_id: Unique product identifier (Primary Key)
- product_name: Name of the product
- category: Product category
- price: Unit price of the product
- stock_quantity: Available inventory quantity

Relationships:
- One product can appear in many order items (1:M relationship with order_items)


### ENTITY: orders

Purpose:
Stores order-level transaction details.

Attributes:
- order_id: Unique order identifier (Primary Key)
- customer_id: Customer who placed the order (Foreign Key)
- order_date: Date of the order
- total_amount: Total monetary value of the order
- status: Order status (Completed, Pending, Cancelled)

Relationships:
- One order belongs to one customer (M:1 with customers)
- One order can contain many order items (1:M with order_items)


### ENTITY: order_items

Purpose:
Stores individual items within an order.

Attributes:
- order_item_id: Unique order item identifier (Primary Key)
- order_id: Associated order (Foreign Key)
- product_id: Associated product (Foreign Key)
- quantity: Quantity of product ordered
- unit_price: Price per unit at transaction time
- subtotal: Calculated line-item total

Relationships:
- Many order items belong to one order
- Many order items reference one product

---

## 2. Normalization Explanation

The database schema for FlexiMart is designed in Third Normal Form (3NF) to ensure data integrity, reduce redundancy, and prevent data anomalies.

In the customers table, all attributes such as first_name, last_name, email, phone, city, and registration_date are fully functionally dependent on the primary key customer_id. There are no partial or transitive dependencies, as customer-related details are stored only once and are not dependent on any non-key attribute.

The products table stores product-specific information where attributes like product_name, category, price, and stock_quantity depend solely on product_id. This separation ensures that changes in product pricing or category do not affect transactional data, thereby avoiding update anomalies.

The orders table captures order-level information and maintains a clear dependency where order_id determines customer_id, order_date, status, and total_amount. Customer details are not duplicated in this table and are instead referenced via a foreign key, ensuring referential integrity and eliminating redundancy.

The order_items table resolves the many-to-many relationship between orders and products. Each record is uniquely identified by order_item_id, and attributes such as quantity, unit_price, and subtotal depend entirely on this key. Product and order details are referenced using foreign keys, preventing transitive dependencies.

This design avoids insertion anomalies by allowing customers and products to exist independently of orders. Deletion anomalies are prevented since removing an order does not delete customer or product records. Update anomalies are avoided because changes to customer or product data need to be made in only one place. Hence, the schema satisfies all conditions of Third Normal Form (3NF).

---

## 3. Sample Data Representation

Customers Table (Sample Records)    
| customer_id | first_name | last_name | email                   | city       | registration_date |
| C001        | Rahul      | Sharma    | rahul.sharma@gmail.com  | Bangalore  | 2023-01-15        |
| C002        | Priya      | Patel     | priya.patel@yahoo.com   | Mumbai     | 2023-02-20        |
| C004        | Sneha      | Reddy     | sneha.reddy@gmail.com   | Hyderabad  | 2023-04-15        |

Products Table (Sample Records) 
| product_id | product_name       | category    | price   | stock_quantity |
| P001       | Samsung Galaxy S21 | Electronics | 45999.00| 150            |
| P004       | Levi’s Jeans       | Fashion     | 2999.00 | 120            |
| P019       | Boat Earbuds       | Electronics | 1499.00 | 250            |

Orders Table (Samples Records)
| order_id | customer_id | order_date | status | total_amount|
| 1        |     C001 | 2024-01-15  | Completed | 45999.00|
| 2        |     C002 | 2024-01-16  | Completed | 5998.00 |
| 3        |     C005 | 2024-01-20  | Completed | 1950.00 |

Order_Items Table (Sample Records)
| order_item_id | order_id | product_id | quantity | unit_price | subtotal |
| 1             |    1     |       P001 |       1  |   45999.00 | 45999.00 |
| 2             | 2        |       P004 |        2 |    2999.00 |  5998.00 |
| 3             | 3        |       P009 |        3 |     650.00 |  1950.00 |