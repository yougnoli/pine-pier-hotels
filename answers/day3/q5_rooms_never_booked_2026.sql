-- Slip 305 · Rooms never booked 2026
-- Eleanor: "Which rooms have not been booked once this year?"
-- The answer: hotel, room_no, by hotel and room.
-- Write your query below and save it, then commit and push to main, then press Hand in.

-- Rooms with no night in 2026 (the closed rooms are in the list).
SELECT h.name AS hotel, r.room_no
FROM dbo.rooms AS r
JOIN dbo.hotels AS h ON h.hotel_id = r.hotel_id
WHERE NOT EXISTS (
  SELECT 1 FROM dbo.room_nights AS n
  WHERE n.room_id = r.room_id AND n.stay_date >= '2026-01-01' AND n.stay_date < '2027-01-01')
ORDER BY h.name, r.room_no;
