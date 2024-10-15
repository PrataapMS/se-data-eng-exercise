{{ config(
    materialized='view',
    alias='movie_ratings_pres'
)
}}


WITH movie_ratings AS (SELECT m.id AS movie_id,
                              m.title,
                              m.vote_average,
                              r.rating
                       FROM {{ ref('movies_raw_to_curate') }} AS m
                                LEFT JOIN {{ ref('ratings_raw_to_curate') }} AS r
                                          ON m.id = r.movie_id
                       WHERE m.id is not null and m.title is not null and r.rating is not null),
     -- Calculate median rating and number of ratings per movie
     ratings_stats AS (SELECT movie_id,
                              title,
                              vote_average,
                              COUNT(rating)                             AS num_ratings,
                              APPROX_QUANTILES(rating, 100)[OFFSET(50)] AS median_rating
                       FROM movie_ratings
                       GROUP BY movie_id, title, vote_average),

     global_stats AS (
         -- Calculate the global average rating across all movies
             SELECT AVG(rating) AS global_average_rating
         FROM movie_ratings),

     -- Rank movies by median rating
     ranked_movies AS (SELECT movie_id,
                              title,
                              vote_average,
                              num_ratings,
                              median_rating,
                              DENSE_RANK() OVER (ORDER BY num_ratings DESC, median_rating DESC) AS movie_rank, (
                 (num_ratings / (num_ratings + 100)) * median_rating +
                 (100 / (num_ratings + 100)) * (SELECT global_average_rating FROM global_stats)) AS bayesian_ranking
                       FROM ratings_stats)

SELECT movie_id,
       title,
       vote_average,
       num_ratings AS number_of_ratings,
       median_rating,
       movie_rank,
       bayesian_ranking,
FROM ranked_movies