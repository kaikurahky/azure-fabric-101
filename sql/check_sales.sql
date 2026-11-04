-- Q1
SELECT TOP (20) *
FROM dbo.sales
ORDER BY order_id;

-- Q2
SELECT
    COUNT(*) AS row_count,
    COUNT(DISTINCT order_id) AS distinct_order_count,
    SUM(CAST(quantity AS bigint)) AS total_quantity,
    SUM(CAST(sales_amount AS decimal(18, 2))) AS total_sales,
    CAST(
        SUM(CAST(sales_amount AS decimal(18, 2)))
        / NULLIF(COUNT(DISTINCT order_id), 0)
        AS decimal(18, 2)
    ) AS average_order_value
FROM dbo.sales;

-- Q3
SELECT
    product,
    SUM(CAST(quantity AS bigint)) AS total_quantity,
    SUM(CAST(sales_amount AS decimal(18, 2))) AS total_sales
FROM dbo.sales
GROUP BY product
ORDER BY total_sales DESC;

-- Q4
SELECT
    order_month,
    SUM(CAST(sales_amount AS decimal(18, 2))) AS total_sales
FROM dbo.sales
GROUP BY order_month
ORDER BY order_month;

-- Q5
SELECT
    region,
    SUM(CAST(sales_amount AS decimal(18, 2))) AS total_sales
FROM dbo.sales
GROUP BY region
ORDER BY region;

-- Q6
SELECT
    order_id,
    COUNT(*) AS occurrences
FROM dbo.sales
GROUP BY order_id
HAVING COUNT(*) > 1;

-- Q7
SELECT
    order_id,
    sales_amount,
    CAST(quantity AS decimal(18, 2))
        * CAST(unit_price AS decimal(18, 2)) AS calculated_sales
FROM dbo.sales
WHERE CAST(sales_amount AS decimal(18, 2))
    <> CAST(quantity AS decimal(18, 2)) * CAST(unit_price AS decimal(18, 2))
    OR order_id IS NULL
    OR quantity IS NULL
    OR unit_price IS NULL
    OR sales_amount IS NULL;

-- Q8
SELECT
    region,
    SUM(CAST(sales_amount AS decimal(18, 2))) AS total_sales
FROM dbo.sales
WHERE product = 'Coffee'
GROUP BY region
ORDER BY region;
