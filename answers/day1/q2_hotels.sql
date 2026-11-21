-- Slip 102 · Hotels
-- Eleanor: "List our hotels with their town and state."
-- The answer: name, town, state; 12 rows, by name.
-- Write your query below and save it, then commit and push to main, then press Hand in.

-- List our hotels with their town and state.
SELECT name, town, state
FROM dbo.hotels
ORDER BY name;
