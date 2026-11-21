-- Slip 303 · Orphan payments
-- Eleanor: "How many payments have no booking, and what do they add up to?"
-- The answer: payments, total_amount.
-- Write your query below and save it, then commit and push to main, then press Hand in.

-- The best and the worst month of each hotel in 2025, by occupied nights (an earlier month wins a tie).
WITH nights AS (
  SELECT n.hotel_id, MONTH(n.stay_date) AS month, COUNT(*) AS occupied
  FROM dbo.room_nights AS n
  JOIN dbo.bookings AS b ON b.booking_id = n.booking_id
  WHERE n.stay_date >= '2025-01-01' AND n.stay_date < '2026-01-01'
    AND LOWER(LTRIM(RTRIM(b.status))) NOT IN ('no-show', 'no show', 'ns')
  GROUP BY n.hotel_id, MONTH(n.stay_date)),
months AS (SELECT m AS month FROM (VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10), (11), (12)) AS v(m)),
filled AS (
  SELECT h.hotel_id, mo.month, COALESCE(x.occupied, 0) AS occupied
  FROM dbo.hotels AS h CROSS JOIN months AS mo
  LEFT JOIN nights AS x ON x.hotel_id = h.hotel_id AND x.month = mo.month),
ranked AS (
  SELECT hotel_id, month,
         ROW_NUMBER() OVER (PARTITION BY hotel_id ORDER BY occupied DESC, month) AS best,
         ROW_NUMBER() OVER (PARTITION BY hotel_id ORDER BY occupied ASC, month) AS worst
  FROM filled)
SELECT h.name AS hotel,
       MAX(CASE WHEN r.best = 1 THEN r.month END) AS best_month,
       MAX(CASE WHEN r.worst = 1 THEN r.month END) AS worst_month
FROM ranked AS r
JOIN dbo.hotels AS h ON h.hotel_id = r.hotel_id
GROUP BY h.name
ORDER BY h.name;
