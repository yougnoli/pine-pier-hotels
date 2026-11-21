-- Slip 202 · Guests per country
-- Eleanor: "Where do our guests come from? How many guests from each country?"
-- The answer: country, guests; one row for each real country, most guests first.
-- Write your query below and save it, then commit and push to main, then press Hand in.

-- How many guests from each country? The country is written as a name or a code, in any case.
SELECT c.name AS country, COUNT(*) AS guests
FROM dbo.guests AS g
JOIN dbo.countries AS c
  ON LOWER(LTRIM(RTRIM(g.country))) IN (LOWER(c.name), LOWER(c.iso2), LOWER(c.iso3))
GROUP BY c.name
ORDER BY guests DESC, country;
