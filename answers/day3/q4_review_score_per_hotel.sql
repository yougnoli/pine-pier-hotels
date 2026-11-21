-- Slip 304 · Review score per hotel
-- Eleanor: "What is the average review score for each hotel, counting only the reviews we can trust?"
-- The answer: hotel, avg_score (two decimals).
-- Write your query below and save it, then commit and push to main, then press Hand in.

-- The average review score of each hotel, counting only valid reviews: the booking exists and the score is 1 to 5.
SELECT h.name AS hotel, CAST(AVG(CAST(r.score AS decimal(5, 2))) AS decimal(4, 2)) AS avg_score
FROM dbo.reviews AS r
JOIN dbo.bookings AS b ON b.booking_id = r.booking_id
JOIN dbo.hotels AS h ON h.hotel_id = b.hotel_id
WHERE r.score BETWEEN 1 AND 5
GROUP BY h.name
ORDER BY h.name;
