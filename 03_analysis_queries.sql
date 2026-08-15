-- E-Commerce Data Analysis Project
-- Business Analysis Queries
-- PostgreSQL


-- 1. Overall Sales Summary

SELECT
    COUNT(*) AS total_orders,
    ROUND(SUM(total_amount), 2) AS total_revenue,
    ROUND(AVG(total_amount), 2) AS average_order_value,
    ROUND(MIN(total_amount), 2) AS minimum_order_value,
    ROUND(MAX(total_amount), 2) AS maximum_order_value
FROM orders;


-- 2. Sales by Country
-- Demonstrates INNER JOIN and GROUP BY

SELECT
    c.country,
    COUNT(o.order_id) AS total_orders,
    ROUND(SUM(o.total_amount), 2) AS total_revenue
FROM customers c
INNER JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.country
ORDER BY total_revenue DESC;


-- 3. Monthly Sales Trend

SELECT
    DATE_TRUNC('month', order_date)::DATE AS sales_month,
    COUNT(*) AS total_orders,
    ROUND(SUM(total_amount), 2) AS total_revenue
FROM orders
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY sales_month;


-- 4. Top 10 Best-Selling Products

SELECT
    p.product_id,
    p.product_name,
    p.category,
    SUM(oi.quantity) AS total_quantity_sold,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS product_revenue
FROM products p
INNER JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY
    p.product_id,
    p.product_name,
    p.category
ORDER BY total_quantity_sold DESC
LIMIT 10;


-- 5. Category Performance

SELECT
    p.category,
    SUM(oi.quantity) AS total_quantity_sold,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS total_revenue,
    COUNT(DISTINCT oi.order_id) AS total_orders
FROM products p
INNER JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.category
ORDER BY total_revenue DESC;


-- 6. Top 10 Highest-Spending Customers

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    c.country,
    COUNT(o.order_id) AS total_orders,
    ROUND(SUM(o.total_amount), 2) AS total_spent,
    ROUND(AVG(o.total_amount), 2) AS average_order_value
FROM customers c
INNER JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name,
    c.country
ORDER BY total_spent DESC
LIMIT 10;


-- 7. Customers with No Orders
-- Demonstrates LEFT JOIN

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    c.country
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;


-- 8. Order Count for Every Customer
-- Demonstrates LEFT JOIN with COUNT

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(o.order_id) AS total_orders
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
ORDER BY total_orders ASC
LIMIT 10;


-- 9. Order Status Analysis

SELECT
    status,
    COUNT(*) AS total_orders,
    ROUND(
        COUNT(*) * 100.0 / (SELECT COUNT(*) FROM orders),
        2
    ) AS percentage_of_orders,
    ROUND(SUM(total_amount), 2) AS total_revenue
FROM orders
GROUP BY status
ORDER BY total_orders DESC;


-- 10. Repeat Customer Analysis

SELECT
    COUNT(*) AS repeat_customers
FROM (
    SELECT
        customer_id,
        COUNT(*) AS order_count
    FROM orders
    GROUP BY customer_id
    HAVING COUNT(*) > 1
) AS customer_orders;