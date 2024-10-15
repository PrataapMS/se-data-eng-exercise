{{
    config(
        materialized='table',
        alias='movies_curate'
    )
}}

WITH raw_data AS (SELECT SAFE_CAST(LOWER(adult) = 'true' AS BOOL) AS adult,
                         belongs_to_collection,
                         SAFE_CAST(budget as NUMERIC)             AS budget,
                         genres,
                         homepage,
                         SAFE_CAST(id as NUMERIC)                 AS id,
                         imdb_id,
                         original_language,
                         original_title,
                         overview,
                         SAFE_CAST(popularity as FLOAT64)         AS popularity,
                         poster_path,
                         production_companies,
                         production_countries,
                         release_date,
                         SAFE_CAST(revenue as NUMERIC)            AS revenue,
                         SAFE_CAST(runtime as NUMERIC)            AS runtime,
                         spoken_languages,
                         status,
                         tagline,
                         title,
                         SAFE_CAST(LOWER(video) = 'true' AS BOOL) AS video,
                         SAFE_CAST(vote_average as NUMERIC)       as vote_average,
                         SAFE_CAST(vote_count as NUMERIC)         as vote_count,
                         CURRENT_TIMESTAMP()                      AS load_time
                  FROM {{ source('movies_data_prataap', 'movies_raw') }})

SELECT *
FROM raw_data