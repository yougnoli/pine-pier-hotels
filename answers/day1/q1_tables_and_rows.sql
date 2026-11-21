-- Slip 101 · Tables and rows
-- Eleanor: "Which tables are in this database, and how many rows does each have?"
-- The answer: table_name, row_count; 11 rows, by name.
-- Write your query below and save it, then commit and push to main, then press Hand in.

-- Which tables are in this database, and how many rows does each have?
SELECT t.name AS table_name, SUM(p.rows) AS row_count
FROM sys.tables AS t
JOIN sys.partitions AS p ON p.object_id = t.object_id AND p.index_id IN (0, 1)
WHERE SCHEMA_NAME(t.schema_id) = 'dbo'
GROUP BY t.name
ORDER BY t.name;
