# Pine & Pier Hotels: the trial week

This is your repository for the trial week at **Pine & Pier Hotels** (a DataGoLive project). The database is yours alone: a real Microsoft SQL Server, with twelve hotels' worth of messy data. Your work is a set of SQL files, one for each question Eleanor, the client, asks.

## What is in here

| Folder or file | What it is |
| --- | --- |
| `answers/day1/` to `answers/day4/` | one `.sql` file for each question of the day: five a day, twenty in all. Each starts with a comment that repeats the question and the shape of the answer |
| `answers/day5/` | the fifth day's four files: your notes on the plan of the slow report, its rewrite, the index, and the four views |
| `reports/monthly_report.sql` | Eleanor's monthly report. It works, but it takes forever. Day 5 starts from it |
| `handover.md` | the note you write for Eleanor on day 5: what is in the database, what you found, where your answers live |

## How to hand in (three steps)

1. **Write your query** in the day's file and **save** it (`Ctrl+S`). Run it first, with the SQL Server extension, to see what it gives.
2. **Commit and push to `main`** from the editor's *Source Control* panel (the Handbook's *Git in 5 minutes* shows every click).
3. **Press *Hand in*** on the day's pigeonhole in the game. The game reads what you pushed, runs each file as your own login, and tells you which are accepted.

You can fix and hand in again as often as you like.

## Rules of the house

* **One query for each file.** The game runs the whole file as it is written (`GO` separates batches, as in the editor) and judges the **last result** it gives.
* **Your login can read the database and see plans, and nothing else**, until Gus approves a change request on day 5. A query that tries to change data will say so.
* Nothing secret is in this repository. Your database password is in the game's *Back office*; the editor asks for it the first time you connect.
