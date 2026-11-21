-- Slip 204 · Unreadable arrival dates
-- Eleanor: "Some arrival dates look broken. How many bookings have a date nobody can read?"
-- The answer: one figure, unreadable.
-- Write your query below and save it, then commit and push to main, then press Hand in.

-- How many bookings have an arrival date nobody can read? (TRY_CONVERT gives NULL for what it cannot read.)
SELECT COUNT(*) AS unreadable
FROM dbo.bookings
WHERE TRY_CONVERT(date, arrival_date) IS NULL;
