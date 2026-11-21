-- Slip 105 · Most expensive night
-- Eleanor: "What is the most expensive nightly room price, in dollars?"
-- The answer: one figure, max_price_usd.
-- Write your query below and save it, then commit and push to main, then press Hand in.

-- The most expensive nightly room price, in dollars (the column holds cents).
SELECT MAX(price) / 100.0 AS max_price_usd
FROM dbo.room_nights;
