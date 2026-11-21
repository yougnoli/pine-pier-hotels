-- Slip 104 · Which bookings table
-- Eleanor: "Three tables look like bookings. Which one holds the current bookings? Give me the latest booking date for each."
-- The answer: table_name, latest_booked_at; 3 rows.
-- Write your query below and save it, then commit and push to main, then press Hand in.

-- Three tables look like bookings. Which one holds the current bookings? The latest booking date of each.
SELECT 'bookings' AS table_name, MAX(booked_at) AS latest_booked_at FROM dbo.bookings
UNION ALL
SELECT 'tbl_bookings_OLD', MAX(booked_at) FROM dbo.tbl_bookings_OLD
UNION ALL
SELECT 'bookings_v2', MAX(booked_at) FROM dbo.bookings_v2;
