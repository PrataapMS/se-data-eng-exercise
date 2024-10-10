{{ config(
    materialized='incremental',
    unique_key='id',
    alias='ratings_curate'
)
}}

WITH raw_data AS (
    SELECT
        CAST(userId AS NUMERIC) AS user_id,
        CAST(movieId AS NUMERIC) AS movie_id,
        CAST(rating AS NUMERIC) AS rating,
        CAST(timestamp AS NUMERIC) AS timestamp,
        CURRENT_TIMESTAMP() AS load_time
    FROM {{ source('movies_data_prataap', 'ratings_raw') }}
)

SELECT * FROM raw_data
