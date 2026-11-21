-- Slip 304 · Review score per hotel
-- Eleanor: "What is the average review score for each hotel, counting only the reviews we can trust?"
-- The answer: hotel, avg_score (two decimals).
-- Write your query below and save it, then commit and push to main, then press Hand in.

-- The share of bookings that never turned up, for each channel: the channel is cleaned first and cancelled bookings are left out.
SELECT LOWER(LTRIM(RTRIM(channel))) AS channel,
       CAST(100.0 * SUM(CASE WHEN LOWER(LTRIM(RTRIM(status))) IN ('no-show', 'no show', 'ns') THEN 1 ELSE 0 END) / COUNT(*) AS decimal(6, 2)) AS no_show_rate_pct
FROM dbo.bookings
WHERE LOWER(LTRIM(RTRIM(status))) NOT IN ('cancelled', 'canceled', 'cxl')
GROUP BY LOWER(LTRIM(RTRIM(channel)))
ORDER BY channel;
