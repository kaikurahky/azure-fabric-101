-- Paste this file once. Run a whole SELECT through its final semicolon,
-- or run the entire file to get four result sets. All queries are read-only.

-- O1: source row counts
SELECT
    (SELECT COUNT(*) FROM dbo.sales) AS order_count,
    (SELECT COUNT(*) FROM dbo.ontology_products) AS product_count,
    (SELECT COUNT(*) FROM dbo.ontology_regions) AS region_count;

-- O2: unmatched relationships; expect zero rows
SELECT
    s.order_id,
    s.product,
    s.region
FROM dbo.sales AS s
LEFT JOIN dbo.ontology_products AS p ON s.product = p.product
LEFT JOIN dbo.ontology_regions AS r ON s.region = r.region
WHERE p.product IS NULL OR r.region IS NULL;

-- O3: follow both relationships for order 1001
SELECT
    s.order_id,
    p.product_label,
    p.category,
    r.region_label,
    s.sales_amount
FROM dbo.sales AS s
INNER JOIN dbo.ontology_products AS p ON s.product = p.product
INNER JOIN dbo.ontology_regions AS r ON s.region = r.region
WHERE s.order_id = 1001;

-- O4: revenue by the category defined in the product master
SELECT
    p.category,
    SUM(CAST(s.sales_amount AS decimal(18, 2))) AS total_sales
FROM dbo.sales AS s
INNER JOIN dbo.ontology_products AS p ON s.product = p.product
GROUP BY p.category
ORDER BY p.category;
