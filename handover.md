# Handover for Eleanor

*Pine & Pier Hotels · the trial week · written by the reference solution*

## What is in the database

Eleven tables in `PinePier`. The core of the business: `hotels` (12), `rooms` (1,094 rooms, 40 of them closed for renovation), `guests`, `bookings` and `room_nights` (one row for each night of a stay: the table that holds the prices, in **cents**), `payments` and `reviews`. Two small lookups: `room_types` and `countries`.
**Three tables look like bookings, and only one is real:** `bookings` holds the current bookings (up to October 2026). `tbl_bookings_OLD` is an old copy that stops in March 2021, and `bookings_v2` is a migration that stopped half way (January to June 2025).

## The problems I found

* **Status and channel are written in many ways**: "Cancelled", "CANCELLED", "cancelled", "Canceled", "cxl", "CXL" all mean cancelled; the channel has stray spaces and capitals.
* **Countries** are written as a name or a code, in any case ("US", "USA", "United States", "usa ").
* **Emails** are missing in three ways: `NULL`, an empty string and a single space.
* **Arrival dates are text, in three formats**, and some cannot be read as a date at all.
* **Orphans:** reviews and payments that point to bookings that do not exist (no foreign key stops them).
* **Duplicates:** the same guest stored up to five times; the same date of birth and the same phone digits are one person.
* **No-shows have nights** in `room_nights`, and closed rooms are not capacity.

## Where the answers live

My queries are in `answers/day1` to `answers/day5`, one file for each of Eleanor's questions. The four figures for the bank are saved as views in the `analyst` schema: `v_occupancy`, `v_revenue_per_hotel`, `v_best_worst_month` and `v_returning_guests`.

## The index and what it changed

Page reads before: (the number you measured for 501)

The monthly report filtered with `YEAR(stay_date) = 2026`, a function around the column, so SQL Server could not use an index and read every page of `room_nights`. I rewrote the filter as a range of dates, and created one covering index, `ix_room_nights_stay_date` on `stay_date`, including `hotel_id` and `price`: the report now reads the narrow index for 2026 only and no longer the whole table. The page reads fell by about **98%**.
