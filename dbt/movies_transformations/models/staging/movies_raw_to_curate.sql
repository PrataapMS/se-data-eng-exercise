{{
    config(
        materialized='table',
        alias='movies_curate'
    )
}}

WITH raw_data AS (
    SELECT
        CASE
            WHEN LOWER(adult) = 'true' THEN TRUE
            WHEN LOWER(adult) = 'false' THEN FALSE
            ELSE NULL
        END AS adult,
        belongs_to_collection,
        SAFE_CAST(budget as NUMERIC) AS budget,
        genres,
        homepage,
        SAFE_CAST(id as NUMERIC) AS id,
        imdb_id,
        original_language,
        original_title,
        overview,
        SAFE_CAST(popularity as FLOAT64) AS popularity,
        poster_path,
        production_companies,
        production_countries,
        release_date,
        SAFE_CAST(revenue as NUMERIC) AS revenue,
        SAFE_CAST(runtime as NUMERIC) AS runtime,
        spoken_languages,
        status,
        tagline,
        title,
        CASE
            WHEN LOWER(video) = 'true' THEN TRUE
            WHEN LOWER(video) = 'false' THEN FALSE
            ELSE NULL
        END AS video,
        vote_average,
        vote_count,
        CURRENT_TIMESTAMP() AS load_time
    FROM {{ source('movies_data_prataap', 'movies_raw') }}
)

SELECT * FROM raw_data