-- models/bronze/bronze_layer.sql
{{ config(materialized='table') }}

SELECT * FROM bronze_layer -- raakadata