-- Slip 302 · Orphan reviews
-- Eleanor: "Some reviews belong to bookings that do not exist. Show me which."
-- The answer: review_id, booking_id, by review_id.
-- Write your query below and save it, then commit and push to main, then press Hand in.

-- The ten guests who stayed the most nights. The same date of birth and the same phone digits are one person.
WITH people AS (
  SELECT guest_id, date_of_birth,
         REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(phone, '(', ''), ')', ''), '-', ''), '.', ''), ' ', '') AS digits
  FROM dbo.guests),
grouped AS (
  SELECT guest_id, MIN(guest_id) OVER (PARTITION BY date_of_birth, digits) AS person_id FROM people),
stays AS (
  SELECT g.person_id, COUNT(*) AS nights
  FROM dbo.room_nights AS n
  JOIN dbo.bookings AS b ON b.booking_id = n.booking_id
  JOIN grouped AS g ON g.guest_id = b.guest_id
  WHERE LOWER(LTRIM(RTRIM(b.status))) NOT IN ('no-show', 'no show', 'ns')
  GROUP BY g.person_id)
SELECT TOP (10) s.person_id AS guest_id, p.first_name, p.last_name, s.nights
FROM stays AS s
JOIN dbo.guests AS p ON p.guest_id = s.person_id
ORDER BY s.nights DESC, s.person_id;
