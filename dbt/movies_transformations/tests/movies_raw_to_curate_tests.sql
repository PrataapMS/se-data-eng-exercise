WITH invalid_ids AS (
    SELECT *
    FROM {{ ref('movies_raw_to_curate') }}
    WHERE load_time IS NULL
)

SELECT COUNT(*) AS num_errors
FROM invalid_ids
HAVING num_errors > 0
