-- Q: Top Cast: each movie, and each actor in it with the character they play
--
-- One SELECT, under these comments. It needs more than one table. The Queries page runs it
-- on every refresh; compare what it shows with the top casts in README.md's data: every
-- part, once. The order and the column headings don't matter.
SELECT movies.title AS movie,
       actors.name AS actor,
       characters.name AS character
FROM movies
INNER JOIN castings ON castings.movie_id = movies.id
INNER JOIN actors ON actors.id = castings.actor_id
INNER JOIN characters ON characters.id = castings.character_id
ORDER BY movies.title, castings.cast_order ASC;
