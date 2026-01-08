-- Populate dim_date (January–February 2024)

INSERT INTO dim_date VALUES
(20240101,'2024-01-01','Monday',1,1,'January','Q1',2024,false),
(20240102,'2024-01-02','Tuesday',2,1,'January','Q1',2024,false),
(20240103,'2024-01-03','Wednesday',3,1,'January','Q1',2024,false),
(20240104,'2024-01-04','Thursday',4,1,'January','Q1',2024,false),
(20240105,'2024-01-05','Friday',5,1,'January','Q1',2024,false),
(20240106,'2024-01-06','Saturday',6,1,'January','Q1',2024,true),
(20240107,'2024-01-07','Sunday',7,1,'January','Q1',2024,true),
(20240108,'2024-01-08','Monday',8,1,'January','Q1',2024,false),
(20240109,'2024-01-09','Tuesday',9,1,'January','Q1',2024,false),
(20240110,'2024-01-10','Wednesday',10,1,'January','Q1',2024,false),
(20240111,'2024-01-11','Thursday',11,1,'January','Q1',2024,false),
(20240112,'2024-01-12','Friday',12,1,'January','Q1',2024,false),
(20240113,'2024-01-13','Saturday',13,1,'January','Q1',2024,true),
(20240114,'2024-01-14','Sunday',14,1,'January','Q1',2024,true),
(20240115,'2024-01-15','Monday',15,1,'January','Q1',2024,false),

(20240201,'2024-02-01','Thursday',1,2,'February','Q1',2024,false),
(20240202,'2024-02-02','Friday',2,2,'February','Q1',2024,false),
(20240203,'2024-02-03','Saturday',3,2,'February','Q1',2024,true),
(20240204,'2024-02-04','Sunday',4,2,'February','Q1',2024,true),
(20240205,'2024-02-05','Monday',5,2,'February','Q1',2024,false),
(20240206,'2024-02-06','Tuesday',6,2,'February','Q1',2024,false),
(20240207,'2024-02-07','Wednesday',7,2,'February','Q1',2024,false),
(20240208,'2024-02-08','Thursday',8,2,'February','Q1',2024,false),
(20240209,'2024-02-09','Friday',9,2,'February','Q1',2024,false),
(20240210,'2024-02-10','Saturday',10,2,'February','Q1',2024,true),
(20240211,'2024-02-11','Sunday',11,2,'February','Q1',2024,true),
(20240212,'2024-02-12','Monday',12,2,'February','Q1',2024,false),
(20240213,'2024-02-13','Tuesday',13,2,'February','Q1',2024,false),
(20240214,'2024-02-14','Wednesday',14,2,'February','Q1',2024,false),
(20240215,'2024-02-15','Thursday',15,2,'February','Q1',2024,false);


-- Populate dim_product (15 products across 3 categories)

INSERT INTO dim_product (product_id, product_name, category, subcategory, unit_price) VALUES
('P001','Samsung Galaxy S21','Electronics','Smartphones',45999.00),
('P002','Apple MacBook Pro','Electronics','Laptops',89999.00),
('P003','Sony Headphones','Electronics','Audio',1999.00),
('P004','Dell 24-inch Monitor','Electronics','Monitors',12999.00),
('P005','Samsung 55-inch TV','Electronics','Televisions',64999.00),

('P006','Levi Jeans','Fashion','Clothing',3499.00),
('P007','Nike Running Shoes','Fashion','Footwear',7999.00),
('P008','Adidas T-Shirt','Fashion','Clothing',1299.00),
('P009','Puma Sneakers','Fashion','Footwear',8999.00),
('P010','H&M Formal Shirt','Fashion','Clothing',1999.00),

('P011','Basmati Rice 5kg','Groceries','Food Grains',650.00),
('P012','Organic Almonds','Groceries','Dry Fruits',899.00),
('P013','Masoor Dal 1kg','Groceries','Pulses',120.00),
('P014','Organic Honey','Groceries','Health Foods',450.00),
('P015','Olive Oil 1L','Groceries','Cooking Oil',999.00);



-- Populate dim_customer (12 customers across 4 cities)

INSERT INTO dim_customer (customer_id, customer_name, city, state, customer_segment) VALUES
('C001','Rahul Sharma','Bangalore','Karnataka','Premium'),
('C002','Priya Patel','Mumbai','Maharashtra','Regular'),
('C003','Amit Kumar','Delhi','Delhi','Regular'),
('C004','Sneha Reddy','Hyderabad','Telangana','Premium'),
('C005','Vikram Singh','Chennai','Tamil Nadu','Regular'),
('C006','Anjali Mehta','Bangalore','Karnataka','Regular'),
('C007','Ravi Verma','Pune','Maharashtra','Regular'),
('C008','Pooja Iyer','Chennai','Tamil Nadu','Premium'),
('C009','Karthik Nair','Kochi','Kerala','Regular'),
('C010','Deepa Gupta','Delhi','Delhi','Premium'),
('C011','Arjun Rao','Hyderabad','Telangana','Regular'),
('C012','Lakshmi Krishnan','Bangalore','Karnataka','Regular');


-- Populate fact_sales (40 sales transactions)

INSERT INTO fact_sales
(date_key, product_key, customer_key, quantity_sold, unit_price, discount_amount, total_amount)
VALUES
(20240101,1,1,1,45999,0,45999),
(20240102,2,2,1,89999,5000,84999),
(20240103,3,3,2,1999,0,3998),
(20240104,4,4,1,12999,1000,11999),
(20240105,5,5,1,64999,3000,61999),

(20240106,6,6,2,3499,0,6998),
(20240107,7,7,1,7999,500,7499),
(20240108,8,8,3,1299,0,3897),
(20240109,9,9,1,8999,1000,7999),
(20240110,10,10,2,1999,0,3998),

(20240111,11,11,5,650,0,3250),
(20240112,12,12,2,899,0,1798),
(20240113,13,1,10,120,0,1200),
(20240114,14,2,3,450,0,1350),
(20240115,15,3,1,999,0,999),

(20240201,1,4,1,45999,2000,43999),
(20240202,2,5,1,89999,7000,82999),
(20240203,3,6,2,1999,0,3998),
(20240204,4,7,1,12999,0,12999),
(20240205,5,8,1,64999,4000,60999),

(20240206,6,9,2,3499,0,6998),
(20240207,7,10,1,7999,0,7999),
(20240208,8,11,4,1299,0,5196),
(20240209,9,12,1,8999,500,8499),
(20240210,10,1,3,1999,0,5997),

(20240211,11,2,6,650,0,3900),
(20240212,12,3,2,899,0,1798),
(20240213,13,4,12,120,0,1440),
(20240214,14,5,4,450,0,1800),
(20240215,15,6,2,999,0,1998),

(20240106,1,7,1,45999,3000,42999),
(20240107,2,8,1,89999,8000,81999),
(20240203,3,9,2,1999,0,3998),
(20240204,4,10,1,12999,0,12999),
(20240210,5,11,1,64999,5000,59999);
