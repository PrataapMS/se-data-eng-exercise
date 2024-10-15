WITH duplicates AS (
    SELECT movie_id, COUNT(*) AS dup_count
    FROM {{ ref('movie_ratings_pres') }}
    GROUP BY movie_id
    HAVING dup_count > 1
)
SELECT COUNT(*) AS duplicate_count
FROM duplicates
HAVING duplicate_count > 0