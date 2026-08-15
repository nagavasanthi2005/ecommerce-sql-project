-- E-Commerce Data Analysis Project
-- Generate Sample E-Commerce Data

-- 10,000 customers
INSERT INTO customers
    (first_name, last_name, email, country, signup_date)
SELECT
    'Customer' || gs,
    'User' || gs,
    'customer' || gs || '@example.com',
    (ARRAY[
        'USA',
        'India',
        'UK',
        'Canada',
        'Germany',
        'France',
        'Australia',
        'Japan',
        'Brazil',
        'Singapore'
    ])[1 + floor(random() * 10)::INTEGER],
    DATE '2020-01-01' + floor(random() * 2192)::INTEGER
FROM generate_series(1, 10000) AS gs;


-- 1,000 products
INSERT INTO products
    (product_name, category, price)
SELECT
    'Product ' || gs,
    (ARRAY[
        'Electronics',
        'Clothing',
        'Books',
        'Sports',
        'Home',
        'Beauty',
        'Toys',
        'Grocery'
    ])[1 + floor(random() * 8)::INTEGER],
    ROUND((10 + random() * 990)::NUMERIC, 2)
FROM generate_series(1, 1000) AS gs;


-- 100,000 orders
INSERT INTO orders
    (customer_id, order_date, status, total_amount)
SELECT
    (1 + floor(random() * 10000))::BIGINT,
    DATE '2023-01-01' + floor(random() * 1095)::INTEGER,
    CASE
        WHEN random() < 0.70 THEN 'Completed'
        WHEN random() < 0.85 THEN 'Shipped'
        WHEN random() < 0.95 THEN 'Pending'
        ELSE 'Cancelled'
    END,
    ROUND((20 + random() * 1980)::NUMERIC, 2)
FROM generate_series(1, 100000);


-- 200,000 order items
WITH generated_items AS (
    SELECT
        (1 + floor(random() * 100000))::BIGINT AS order_id,
        (1 + floor(random() * 1000))::BIGINT AS product_id,
        (1 + floor(random() * 5))::INTEGER AS quantity
    FROM generate_series(1, 200000)
)
INSERT INTO order_items
    (order_id, product_id, quantity, unit_price)
SELECT
    gi.order_id,
    gi.product_id,
    gi.quantity,
    p.price
FROM generated_items gi
INNER JOIN products p
    ON p.product_id = gi.product_id;