-- Slip 205 · Bookings per month 2026
-- Eleanor: "How many bookings did we take in each month of 2026?"
-- The answer: month, bookings; 11 rows.
-- Write your query below and save it, then commit and push to main, then press Hand in.

-- How many bookings did we take in each month of 2026?
SELECT MONTH(booked_at) AS month, COUNT(*) AS bookings
FROM dbo.bookings
WHERE booked_at >= '2026-01-01' AND booked_at < '2027-01-01'
GROUP BY MONTH(booked_at)
ORDER BY month;
