-- Slip 301 · Revenue 2025
-- Eleanor: "What was our revenue in 2025, hotel by hotel? Careful: last year's figure in the old report was far too high."
-- The answer: hotel, revenue; 12 rows.
-- Write your query below and save it, then commit and push to main, then press Hand in.

-- Occupancy of each hotel, month by month, in 2025: occupied nights over the nights that could be sold.
-- A no-show is not occupied; a room closed for renovation is not capacity.
WITH nights AS (
  SELECT n.hotel_id, MONTH(n.stay_date) AS month, COUNT(*) AS occupied
  FROM dbo.room_nights AS n
  JOIN dbo.bookings AS b ON b.booking_id = n.booking_id
  WHERE n.stay_date >= '2025-01-01' AND n.stay_date < '2026-01-01'
    AND LOWER(LTRIM(RTRIM(b.status))) NOT IN ('no-show', 'no show', 'ns')
  GROUP BY n.hotel_id, MONTH(n.stay_date)),
open_rooms AS (
  SELECT hotel_id, COUNT(*) AS rooms FROM dbo.rooms WHERE closed_for_renovation = 0 GROUP BY hotel_id),
months AS (SELECT m AS month FROM (VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10), (11), (12)) AS v(m))
SELECT h.name AS hotel, mo.month,
       CAST(100.0 * COALESCE(x.occupied, 0) / (o.rooms * DAY(EOMONTH(DATEFROMPARTS(2025, mo.month, 1)))) AS decimal(6, 2)) AS occupancy_pct
FROM dbo.hotels AS h
CROSS JOIN months AS mo
JOIN open_rooms AS o ON o.hotel_id = h.hotel_id
LEFT JOIN nights AS x ON x.hotel_id = h.hotel_id AND x.month = mo.month
ORDER BY h.name, mo.month;
