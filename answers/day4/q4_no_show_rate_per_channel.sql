-- Slip 404 · No show rate per channel
-- Eleanor: "Which booking channel has the most no-shows, as a share?"
-- The answer: channel, no_show_rate_pct; 5 rows.
-- Write your query below and save it, then commit and push to main, then press Hand in.

-- The share of bookings that never turned up, for each channel: the channel is cleaned first and cancelled bookings are left out.
SELECT LOWER(LTRIM(RTRIM(channel))) AS channel,
       CAST(100.0 * SUM(CASE WHEN LOWER(LTRIM(RTRIM(status))) IN ('no-show', 'no show', 'ns') THEN 1 ELSE 0 END) / COUNT(*) AS decimal(6, 2)) AS no_show_rate_pct
FROM dbo.bookings
WHERE LOWER(LTRIM(RTRIM(status))) NOT IN ('cancelled', 'canceled', 'cxl')
GROUP BY LOWER(LTRIM(RTRIM(channel)))
ORDER BY channel;
