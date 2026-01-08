/**
 * MongoDB Operations for FlexiMart Product Catalog
 * Database: fleximart_nosql
 * Collection: products
 *
 * This file demonstrates basic MongoDB CRUD and aggregation operations
 * using a NoSQL document-based data model.
 */


/**
 * 1. FIND OPERATION
 * Find all products that have at least one review with a 5-star rating.
 */
db.products.find({
  "reviews.rating": 5
});


/**
 * 2. FIND OPERATION WITH FILTER
 * Retrieve all products belonging to the "Electronics" category.
 */
db.products.find({
  category: "Electronics"
});


/**
 * 3. UPDATE OPERATION
 * Add a new field "discount_percent" with value 10
 * to all products in the Electronics category.
 */
db.products.updateMany(
  { category: "Electronics" },
  { $set: { discount_percent: 10 } }
);


/**
 * 4. AGGREGATION OPERATION
 * Unwind the embedded reviews array so that each review
 * becomes a separate document in the pipeline.
 */
db.products.aggregate([
  { $unwind: "$reviews" }
]);


/**
 * 5. AGGREGATION OPERATION
 * Calculate the average rating for each product
 * and sort the results in descending order of average rating.
 */
db.products.aggregate([
  { $unwind: "$reviews" },
  {
    $group: {
      _id: "$name",
      average_rating: { $avg: "$reviews.rating" },
      total_reviews: { $sum: 1 }
    }
  },
  { $sort: { average_rating: -1 } }
]);
