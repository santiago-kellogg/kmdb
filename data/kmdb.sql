-- KMDB's rows, as INSERT statements: everything in README.md's data.
-- Only rows here. The tables (CREATE TABLE) go in schema/kmdb.sql.
--
-- bin/load runs this file after schema/kmdb.sql, so every table it inserts into must exist
-- there. Foreign keys can be typed-in ids (studio_id 1, and so on).

INSERT INTO studios (id, name) VALUES
  (1, 'Warner Bros.');

INSERT INTO movies (id, title, year, rating, studio_id) VALUES
  (1, 'Batman Begins', 2005, 'PG-13', 1),
  (2, 'The Dark Knight', 2008, 'PG-13', 1),
  (3, 'The Dark Knight Rises', 2012, 'PG-13', 1);

INSERT INTO actors (id, name) VALUES
  (1, 'Christian Bale'),
  (2, 'Michael Caine'),
  (3, 'Liam Neeson'),
  (4, 'Katie Holmes'),
  (5, 'Gary Oldman'),
  (6, 'Heath Ledger'),
  (7, 'Aaron Eckhart'),
  (8, 'Maggie Gyllenhaal'),
  (9, 'Tom Hardy'),
  (10, 'Joseph Gordon-Levitt'),
  (11, 'Anne Hathaway'),
  (12, 'Cillian Murphy');

INSERT INTO characters (id, name) VALUES
  (1, 'Bruce Wayne'),
  (2, 'Alfred'),
  (3, 'Ra''s Al Ghul'),
  (4, 'Rachel Dawes'),
  (5, 'Commissioner Gordon'),
  (6, 'Joker'),
  (7, 'Harvey Dent'),
  (8, 'Bane'),
  (9, 'John Blake'),
  (10, 'Selina Kyle'),
  (11, 'Scarecrow');

-- Spoiler flags belong to individual parts: 0 = safe, 1 = spoiler.
INSERT INTO castings (id, movie_id, actor_id, character_id, cast_order, is_spoiler) VALUES
  (1, 1, 1, 1, 1, 0),
  (2, 1, 2, 2, 2, 0),
  (3, 1, 3, 3, 3, 1),
  (4, 1, 4, 4, 4, 0),
  (5, 1, 5, 5, 5, 0),
  (6, 2, 1, 1, 1, 0),
  (7, 2, 6, 6, 2, 0),
  (8, 2, 7, 7, 3, 0),
  (9, 2, 2, 2, 4, 0),
  (10, 2, 8, 4, 5, 0),
  (11, 3, 1, 1, 1, 0),
  (12, 3, 5, 5, 2, 0),
  (13, 3, 9, 8, 3, 0),
  (14, 3, 10, 9, 4, 0),
  (15, 3, 11, 10, 5, 0),
  (16, 1, 12, 11, 6, 0),
  (17, 2, 12, 11, 6, 0),
  (18, 3, 12, 11, 6, 1);
