-- Monthly report: the room nights and the revenue of each hotel, month by month, for 2026.
-- Written years ago by somebody who has left. It works, but it takes forever.
SELECT h.name AS hotel,
       MONTH(rn.stay_date) AS month,
       COUNT(*) AS nights,
       CAST(SUM(rn.price) / 100.0 AS decimal(12, 2)) AS revenue_usd
FROM dbo.room_nights AS rn
JOIN dbo.hotels AS h ON h.hotel_id = rn.hotel_id
WHERE YEAR(rn.stay_date) = 2026
GROUP BY h.name, MONTH(rn.stay_date)
ORDER BY h.name, MONTH(rn.stay_date);
