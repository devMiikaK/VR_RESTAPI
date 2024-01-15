-- models/silver/silver_layer.sql

{{ config(materialized='table') }}

SELECT
    stationShortCode::VARCHAR(10) as stationShortCode, -- silver sarakkeesta suodatetaan ns. "turhat" sarakkeet pois, ja määritellään tietotyypit
    stationUICCode::INT as stationUICCode,
    type::VARCHAR(20) as type,
    trainStopping::BOOLEAN as trainStopping,
    commercialTrack::VARCHAR(5) as commercialTrack,
    cancelled::BOOLEAN as cancelled,
    scheduledTime::TIMESTAMP as scheduledTime,
    actualTime::TIMESTAMP as actualTime,
    differenceInMinutes::INT as differenceInMinutes,
    trainNumber::INT as trainNumber
FROM {{ ref('bronze_layer') }}
