-- models/gold/gold_layer.sql

{{ config(materialized='table') }}

WITH station_performance AS (
    SELECT
        stationShortCode,
        trainNumber,
        type,
        AVG(differenceInMinutes) as avg_delay_time, -- myöhästymisen kerkiarvo junaa kohden
        SUM(CASE WHEN differenceInMinutes > 5 THEN 1 ELSE 0 END) * 1.0 / COUNT(*) as percent_delays, -- jos juna on myöhässä alle 5 min, sitä ei luokitella myöhästymiseksi
        SUM(CASE WHEN differenceInMinutes < 0 THEN 1 ELSE 0 END) * 1.0 / COUNT(*) as percent_early_arrivals,
        SUM(CASE WHEN cancelled THEN 1 ELSE 0 END) * 1.0 / COUNT(*) as percent_cancelled, -- % perutuista junista per trainNumber
        AVG(differenceInMinutes) as avg_differenceInMinutes -- keskiarvo sarakkeesta differenceInMinutes
    FROM {{ ref('silver_layer') }}
    GROUP BY stationShortCode, trainNumber, type
)

SELECT
    stationShortCode,
    trainNumber,
    type,
    avg_delay_time,
    percent_delays,
    percent_early_arrivals,
    percent_cancelled,
    avg_differenceInMinutes
FROM station_performance
