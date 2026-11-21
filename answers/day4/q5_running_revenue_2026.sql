-- Slip 405 · Running revenue 2026
-- Eleanor: "What does our revenue add up to, month after month, in 2026?"
-- The answer: month, revenue, running_total; 11 rows.
-- Write your query below and save it, then commit and push to main, then press Hand in.

-- Revenue month by month in 2026 and its running total: payments of bookings that exist.
WITH monthly AS (
  SELECT MONTH(p.paid_at) AS month, SUM(p.amount) AS revenue
  FROM dbo.payments AS p
  JOIN dbo.bookings AS b ON b.booking_id = p.booking_id
  WHERE p.paid_at >= '2026-01-01' AND p.paid_at < '2027-01-01'
  GROUP BY MONTH(p.paid_at))
SELECT month,
       CAST(revenue AS decimal(12, 2)) AS revenue,
       CAST(SUM(revenue) OVER (ORDER BY month) AS decimal(12, 2)) AS running_total
FROM monthly
ORDER BY month;
