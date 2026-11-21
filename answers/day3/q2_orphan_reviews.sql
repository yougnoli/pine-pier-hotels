-- Slip 302 · Orphan reviews
-- Eleanor: "Some reviews belong to bookings that do not exist. Show me which."
-- The answer: review_id, booking_id, by review_id.
-- Write your query below and save it, then commit and push to main, then press Hand in.

-- Reviews of bookings that do not exist.
SELECT r.review_id, r.booking_id
FROM dbo.reviews AS r
LEFT JOIN dbo.bookings AS b ON b.booking_id = r.booking_id
WHERE b.booking_id IS NULL
ORDER BY r.review_id;
