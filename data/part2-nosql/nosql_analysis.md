# NoSQL Analysis – FlexiMart

---

## Section A: Limitations of RDBMS
Relational Database Management Systems (RDBMS) like MySQL are well-suited for structured and stable data models but face challenges when handling highly dynamic product catalogs. In FlexiMart’s case, different products require different attributes—for example, laptops need specifications like RAM and processor, while clothing items require size and color. Representing this variability in an RDBMS would require multiple nullable columns or separate attribute tables, leading to complexity and inefficient queries.

Frequent schema changes pose another limitation. Introducing new product types often requires ALTER TABLE operations, which are costly and risky in production environments with large datasets. Such changes can also impact existing queries and application logic.

Additionally, storing nested data such as customer reviews is inefficient in relational databases. Reviews would need separate tables with foreign key relationships, increasing join operations and reducing read performance. These limitations make RDBMS less flexible and harder to scale for evolving, diverse product data.


## Section B: NoSQL Benefits (MongoDB)
MongoDB addresses the limitations of relational databases by offering a flexible, document-based data model. Its schema-less structure allows each product to store attributes relevant to its category without enforcing a rigid table schema. For example, electronic products can include specifications like RAM and processor, while apparel items can store size and color, all within the same collection.

MongoDB also supports embedded documents, making it ideal for storing nested data such as customer reviews directly inside product documents. This reduces the need for complex joins and significantly improves read performance, especially for frequently accessed data like product details and reviews.

Additionally, MongoDB is designed for horizontal scalability. It supports sharding, which allows data to be distributed across multiple servers as the dataset grows. This makes MongoDB well-suited for FlexiMart’s expanding and high-traffic product catalog, enabling better performance and easier scaling compared to traditional RDBMS solutions.


## Section C: Trade-offs
One disadvantage of using MongoDB instead of MySQL is the lack of strong relational constraints such as foreign keys. This makes it harder to enforce data integrity across related collections, which can lead to inconsistencies if not carefully handled at the application level.

Another drawback is that MongoDB is less suitable for complex transactional operations involving multiple entities. While MongoDB supports transactions, they are generally more complex and less efficient compared to traditional RDBMS systems like MySQL. For scenarios involving heavy financial transactions or strict consistency requirements, a relational database may still be the better choice.
