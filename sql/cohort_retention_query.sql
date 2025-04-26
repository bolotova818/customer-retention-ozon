
WITH Kogort_table AS (
  SELECT
    customer_id,
    order_date,
    MIN(order_date) OVER (PARTITION BY customer_id) AS first_order_date
  FROM Ozon_Orders
)

SELECT
  substr(first_order_date, 1, 7) AS cohort_month,
  CAST((julianday(order_date) - julianday(first_order_date)) / 30 AS INTEGER) AS months_since_first,
  COUNT(DISTINCT customer_id) AS customers_count
FROM Kogort_table
GROUP BY
  cohort_month,
  months_since_first
ORDER BY
  cohort_month,
  months_since_first;
