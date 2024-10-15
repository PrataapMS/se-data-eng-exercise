WITH invalid_rows AS (
    SELECT *
    FROM {{ ref('movie_ratings_pres') }}
    WHERE movie_id IS NULL
       OR title IS NULL
       OR number_of_ratings IS NULL
       OR median_rating IS NULL
       OR bayesian_ranking IS NULL
)

SELECT COUNT(*) AS invalid_count
FROM invalid_rows
HAVING invalid_count > 0

