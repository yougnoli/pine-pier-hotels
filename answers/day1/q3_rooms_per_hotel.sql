-- Slip 103 · Rooms per hotel
-- Eleanor: "How many rooms does each hotel have?"
-- The answer: hotel, rooms; 12 rows.
-- Write your query below and save it, then commit and push to main, then press Hand in.

-- How many rooms does each hotel have? (the closed ones still count)
SELECT h.name AS hotel, COUNT(*) AS rooms
FROM dbo.rooms AS r
JOIN dbo.hotels AS h ON h.hotel_id = r.hotel_id
GROUP BY h.name
ORDER BY h.name;
