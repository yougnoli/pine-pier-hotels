-- Slip 303 · Orphan payments
-- Eleanor: "How many payments have no booking, and what do they add up to?"
-- The answer: payments, total_amount.
-- Write your query below and save it, then commit and push to main, then press Hand in.

-- How many payments have no booking, and what do they add up to (in dollars)?
SELECT COUNT(*) AS payments, CAST(SUM(p.amount) AS decimal(12, 2)) AS total_amount
FROM dbo.payments AS p
LEFT JOIN dbo.bookings AS b ON b.booking_id = p.booking_id
WHERE b.booking_id IS NULL;
