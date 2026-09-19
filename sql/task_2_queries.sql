
SELECT
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    SUM(quantity) AS total_quantity
FROM sales_orders;

SELECT
    product_name,
    ROUND(SUM(sales), 2) AS total_sales
FROM sales_orders
GROUP BY product_name
ORDER BY total_sales DESC
LIMIT 5;

SELECT
    c.customer_name,
    c.segment,
    ROUND(SUM(o.sales), 2) AS total_spend
FROM sales_orders AS o
JOIN customers AS c
    ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.customer_name, c.segment
ORDER BY total_spend DESC
LIMIT 5;

SELECT
    strftime('%Y-%m', order_date) AS month,
    ROUND(SUM(sales), 2) AS total_sales
FROM sales_orders
GROUP BY month
ORDER BY month;

SELECT
    category,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM sales_orders
GROUP BY category
ORDER BY total_sales DESC;

SELECT
    region,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM sales_orders
GROUP BY region
ORDER BY total_profit DESC;

SELECT
    discount,
    ROUND(AVG(profit), 2) AS average_profit,
    ROUND(SUM(profit), 2) AS total_profit,
    COUNT(*) AS number_of_orders
FROM sales_orders
GROUP BY discount
ORDER BY discount;

SELECT
    sub_category,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM sales_orders
GROUP BY sub_category
HAVING SUM(profit) < 0
ORDER BY total_profit ASC;

SELECT
    c.segment,
    ROUND(SUM(o.sales), 2) AS total_sales,
    ROUND(SUM(o.profit), 2) AS total_profit,
    COUNT(DISTINCT o.customer_id) AS unique_customers
FROM sales_orders AS o
JOIN customers AS c
    ON o.customer_id = c.customer_id
GROUP BY c.segment
ORDER BY total_sales DESC;

WITH product_sales AS (
    SELECT
        category,
        product_name,
        ROUND(SUM(sales), 2) AS total_sales,
        ROW_NUMBER() OVER (
            PARTITION BY category
            ORDER BY SUM(sales) DESC
        ) AS sales_rank
    FROM sales_orders
    GROUP BY category, product_name
)
SELECT
    category,
    product_name,
    total_sales,
    sales_rank
FROM product_sales
WHERE sales_rank <= 3
ORDER BY category, sales_rank;


create_view_query = """
CREATE VIEW IF NOT EXISTS monthly_sales_summary AS
SELECT
    strftime('%Y-%m', order_date) AS month,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    COUNT(DISTINCT order_id) AS total_orders
FROM sales_orders
GROUP BY month;
"""

with engine.begin() as connection:
    connection.exec_driver_sql(create_view_query)

display(
    pd.read_sql_query(
        "SELECT * FROM monthly_sales_summary ORDER BY month;",
        engine
    )
)