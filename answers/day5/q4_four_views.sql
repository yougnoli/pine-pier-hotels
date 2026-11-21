-- Slip 504 · Four views
-- Eleanor: "Save my four figures as views, so my accountant can use them."
-- The answer: four views in analyst that return the right rows.
-- Write your query below and save it, then commit and push to main, then press Hand in.

-- The bank's four figures, saved as views in my own schema (each CREATE VIEW starts its batch).
CREATE VIEW analyst.v_occupancy AS
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
LEFT JOIN nights AS x ON x.hotel_id = h.hotel_id AND x.month = mo.month;
GO
CREATE VIEW analyst.v_revenue_per_hotel AS
SELECT h.name AS hotel, CAST(SUM(p.amount) AS decimal(12, 2)) AS revenue
FROM dbo.payments AS p
JOIN dbo.bookings AS b ON b.booking_id = p.booking_id
JOIN dbo.hotels AS h ON h.hotel_id = b.hotel_id
WHERE p.paid_at >= '2025-01-01' AND p.paid_at < '2026-01-01'
GROUP BY h.name;
GO
CREATE VIEW analyst.v_best_worst_month AS
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
GROUP BY h.name;
GO
CREATE VIEW analyst.v_returning_guests AS
WITH people AS (
  SELECT guest_id, date_of_birth,
         REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(phone, '(', ''), ')', ''), '-', ''), '.', ''), ' ', '') AS digits
  FROM dbo.guests),
grouped AS (
  SELECT guest_id, MIN(guest_id) OVER (PARTITION BY date_of_birth, digits) AS person_id FROM people),
stays AS (
  SELECT g.person_id, COUNT(DISTINCT b.booking_id) AS stays
  FROM dbo.bookings AS b
  JOIN dbo.room_nights AS n ON n.booking_id = b.booking_id
  JOIN grouped AS g ON g.guest_id = b.guest_id
  WHERE LOWER(LTRIM(RTRIM(b.status))) NOT IN ('no-show', 'no show', 'ns')
  GROUP BY g.person_id)
SELECT COUNT(*) AS returning_people FROM stays WHERE stays >= 2;
GO
