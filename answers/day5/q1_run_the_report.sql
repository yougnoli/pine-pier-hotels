-- Slip 501 · Run the report
-- Eleanor: "My monthly report takes forever. Run it (it is in the `reports` folder), look at what it does, and tell me in `handover.md` how many pages it reads."
-- The answer: the number in handover.md is within 10% of the measured pages.
-- Scratch for this slip (it is not judged): run reports/monthly_report.sql with SET STATISTICS IO ON, read the line for
-- room_nights, and write its number in handover.md.

-- Scratch for slip 501: the monthly report with the page reads switched on. In the Messages tab, the line for room_nights says how many
-- pages the report reads (its "logical reads"): that number goes in handover.md.
SET STATISTICS IO ON;
GO
SELECT h.name AS hotel,
       MONTH(rn.stay_date) AS month,
       COUNT(*) AS nights,
       CAST(SUM(rn.price) / 100.0 AS decimal(12, 2)) AS revenue_usd
FROM dbo.room_nights AS rn
JOIN dbo.hotels AS h ON h.hotel_id = rn.hotel_id
WHERE YEAR(rn.stay_date) = 2026
GROUP BY h.name, MONTH(rn.stay_date)
ORDER BY h.name, MONTH(rn.stay_date);
