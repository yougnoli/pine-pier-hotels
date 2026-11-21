-- Slip 502 · Rewrite the report
-- Eleanor: "Now rewrite it so it can use an index."
-- The answer: the same rows, and no function around stay_date.
-- Write your query below and save it, then commit and push to main, then press Hand in.

-- The same report, filtered by a range of dates: the column is not wrapped in a function, so an index can be used.
SELECT h.name AS hotel,
       MONTH(rn.stay_date) AS month,
       COUNT(*) AS nights,
       CAST(SUM(rn.price) / 100.0 AS decimal(12, 2)) AS revenue_usd
FROM dbo.room_nights AS rn
JOIN dbo.hotels AS h ON h.hotel_id = rn.hotel_id
WHERE rn.stay_date >= '2026-01-01' AND rn.stay_date < '2027-01-01'
GROUP BY h.name, MONTH(rn.stay_date)
ORDER BY h.name, MONTH(rn.stay_date);
