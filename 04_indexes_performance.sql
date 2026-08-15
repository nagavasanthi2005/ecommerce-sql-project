-- E-Commerce Data Analysis Project
-- Query Performance Optimization
-- PostgreSQL
-- Performance test BEFORE creating the index

EXPLAIN ANALYZE
SELECT *
FROM orders
WHERE customer_id = 5000;

-- Create an index on the frequently filtered column

CREATE INDEX idx_orders_customer_id
ON orders(customer_id);

-- Performance test AFTER creating the index

EXPLAIN ANALYZE
SELECT *
FROM orders
WHERE customer_id = 5000;

-- Benchmark result from this project:
--
-- Before index: 8.704 ms
-- After index:  0.205 ms
-- Improvement:  approximately 97.6%
--
-- PostgreSQL used:
-- Bitmap Index Scan on idx_orders_customer_id