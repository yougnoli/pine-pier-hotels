-- Slip 503 · Create index
-- Eleanor: "Make it fast. You may create one index."
-- The answer: one index on room_nights, and the rewritten report reads at most 5% of the pages.
-- Write your query below and save it, then commit and push to main, then press Hand in.

-- One index: the column the report filters by first, then the columns it reads
CREATE NONCLUSTERED INDEX ix_room_nights_stay_date
ON dbo.room_nights (stay_date)
INCLUDE (hotel_id, price);
