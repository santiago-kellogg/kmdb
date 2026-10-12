-- Q: Which movie cast parts are safe to show in Spoiler-Free Mode?
SELECT movies.title AS movie,
       actors.name AS actor,
       characters.name AS character
FROM movies
INNER JOIN castings ON castings.movie_id = movies.id
INNER JOIN actors ON actors.id = castings.actor_id
INNER JOIN characters ON characters.id = castings.character_id
WHERE castings.is_spoiler = 0
ORDER BY movies.title, castings.cast_order ASC;

-- removed the cast_order column from the SELECT statement because it is not needed for the spoiler-free query.