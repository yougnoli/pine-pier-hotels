-- Slip 203 · Guests without email
-- Eleanor: "How many guests have no email address we can use?"
-- The answer: one figure, guests.
-- Write your query below and save it, then commit and push to main, then press Hand in.

-- How many guests have no email address we can use? NULL, '' and ' ' all say "missing".
SELECT COUNT(*) AS guests
FROM dbo.guests
WHERE email IS NULL OR LTRIM(RTRIM(email)) = '';
