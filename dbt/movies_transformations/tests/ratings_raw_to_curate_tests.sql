WITH invalid_user_ids AS (
    SELECT *
    FROM {{ ref('ratings_raw_to_curate') }}
    WHERE user_id IS NULL
)

SELECT COUNT(*) AS num_errors
FROM invalid_user_ids
HAVING num_errors > 0
