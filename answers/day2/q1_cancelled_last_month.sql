-- Slip 201 · Cancelled last month
-- Eleanor: "How many bookings were cancelled last month? The bank will ask."
-- The answer: one figure, cancelled.
-- Write your query below and save it, then commit and push to main, then press Hand in.

-- How many bookings were cancelled last month (October 2026)? "Cancelled" is written six ways.
SELECT COUNT(*) AS cancelled
FROM dbo.bookings
WHERE status IN ('Cancelled', 'CANCELLED', 'cancelled', 'Canceled', 'cxl', 'CXL')
  AND cancelled_at >= '2026-10-01' AND cancelled_at < '2026-11-01';
