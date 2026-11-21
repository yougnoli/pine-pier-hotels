-- Slip 301 · Revenue 2025
-- Eleanor: "What was our revenue in 2025, hotel by hotel? Careful: last year's figure in the old report was far too high."
-- The answer: hotel, revenue; 12 rows.
-- Write your query below and save it, then commit and push to main, then press Hand in.

-- Revenue in 2025, hotel by hotel. Payments know their booking; joining room_nights would repeat every payment for every night.
SELECT h.name AS hotel, CAST(SUM(p.amount) AS decimal(12, 2)) AS revenue
FROM dbo.payments AS p
JOIN dbo.bookings AS b ON b.booking_id = p.booking_id
JOIN dbo.hotels AS h ON h.hotel_id = b.hotel_id
WHERE p.paid_at >= '2025-01-01' AND p.paid_at < '2026-01-01'
GROUP BY h.name
ORDER BY h.name;
