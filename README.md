# E-Commerce Data Analysis using PostgreSQL
## Project Overview
This project analyzes a large-scale e-commerce dataset using PostgreSQL to identify sales trends, customer purchasing behavior, product performance, and order patterns.

The project contains:

- 10,000 customers
- 1,000 products
- 100,000 orders
- 200,000 order items
The dataset was generated using PostgreSQL and analyzed using SQL queries.

## Technologies Used
- PostgreSQL
- pgAdmin 4
- SQL
- GitHub

## Database Schema

The project contains four main tables:

### Customers

Stores customer profile information.

Important columns:

- customer_id
- first_name
- last_name
- email
- country
- signup_date

### Products

Stores product information.

Important columns:

- product_id
- product_name
- category
- price

### Orders

Stores customer order information.

Important columns:

- order_id
- customer_id
- order_date
- status
- total_amount

### Order Items

Stores products included in each order.

Important columns:

- order_item_id
- order_id
- product_id
- quantity
- unit_price

## SQL Analysis Performed

### 1. Overall Sales Analysis

Calculated:

- Total orders
- Total revenue
- Average order value
- Minimum order value
- Maximum order value

Actual results:

- Total orders: 100,000
- Total revenue: 100,976,250.08
- Average order value: 1,009.76
- Minimum order value: 20.03
- Maximum order value: 1,999.96

### 2. Sales by Country

Used INNER JOIN and GROUP BY to combine customer information with order history and analyze revenue by country.

### 3. Monthly Sales Trends

Used DATE_TRUNC() to analyze order volume and revenue month by month.

### 4. Top-Selling Products

Joined products with order items to identify products with the highest quantities sold.

### 5. Category Performance

Analyzed product categories based on:

- Quantity sold
- Revenue
- Number of orders

### 6. Customer Purchasing Behavior

Identified the highest-spending customers and calculated:

- Total orders
- Total spending
- Average order value

### 7. LEFT JOIN Analysis

Used LEFT JOIN to analyze customers and identify customers without matching orders.

### 8. Order Status Analysis

Analyzed:

- Completed orders
- Shipped orders
- Pending orders
- Cancelled orders

### 9. Repeat Customer Analysis

Used GROUP BY and HAVING to identify customers who placed more than one order.

The analysis identified 9,996 repeat customers.

## Query Performance Optimization
An index was created on the frequently filtered `customer_id` column in the orders table.

```sql
CREATE INDEX idx_orders_customer_id
ON orders(customer_id);
```markdown
### Performance Benchmark

The same query was tested using `EXPLAIN ANALYZE` before and after creating the index.

Benchmark query:

```sql
EXPLAIN ANALYZE
SELECT *
FROM orders
WHERE customer_id = 5000;
### Performance Results

| Test | Execution Time |
|---|---:|
| Before index | 8.704 ms |
| After index | 0.205 ms |