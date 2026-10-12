# Notes

## What the chat would change about my drawing

The assistant suggested separating actors from their roles in movies. My original Cast
table stored a name along with movie_id and character_id. The proposed design adds an
Actors table and changes Cast to Castings, linking each movie, actor, and character.
This gives an actor a stable identity across movies and supports looking up the movies
an actor has appeared in without repeating the actor's name in every casting row.

The assistant also suggested marking primary and foreign keys, showing which relationships
are one-to-many, and adding an ordering field to Castings so the Top Cast report can
display each movie's cast in the order listed in the README.

As a simpler alternative, the assistant suggested storing character_name directly on
Castings instead of keeping a separate Characters table.

## What I took, what I didn't, and why

I took the separate Actors and Castings tables. Castings now connects a movie to an actor
and the character they play. This supports both the movie's cast list and an actor's
movie list.

I kept my Characters table rather than storing character names directly on Castings.
Recurring characters can be shared across movies even when the actor changes. For
example, Katie Holmes and Maggie Gyllenhaal both play Rachel Dawes in different movies.

I accepted the ordering field but chose the name cast_order instead of billing_order.
It belongs on Castings because an actor's position can differ between movies. The
planned Top Cast query will sort each movie's cast by this field.

The schema uses primary keys and foreign keys to represent these relationships: a studio
has many movies, and movies, actors, and characters each connect to castings. It also
requires positive cast_order values, prevents duplicate cast positions within a movie,
and prevents duplicate entries for the same movie, actor, and character.


## The chat

This conversation took place in VS Code with Codex. No share link is available; I was
unsure where to find one in VS Code.

I've added the chat screenshots in the /chat file under the names chat01 and chat02.

## Phase 2
I proposed adding a spoiler flag to individual castings and a filtered report, and thought through how future flags could be handled through data changes. After I clarified the approach, the assistant prepared the schema, data, and query edits. Adding the spoiler colum to the database, I then ran the SQl and confirmed that it was doing the right thing.