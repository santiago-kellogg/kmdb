# KMDB, the Kellogg Movie Database

A small app for looking up movies and who is in them. The database starts empty. You design
its tables and fill them.

## Getting started

1. In the terminal, run `bin/rails server`, then open the port it offers.
2. Open a second terminal with the **+** on the terminal panel; the server keeps the first one
   busy. That is where `bin/load` runs.
3. The loop: edit a `.sql` file, run `bin/load`, look at the **Schema**, **Run SQL** and
   **Queries** pages. `bin/load` starts over from the two files every time, so a bad paste is
   never permanent: fix the file and load again.

## The stories

- As a guest, I want to see every movie with its title, year, rating and studio, so I can pick
  one to watch.
- As a guest, I want to see the movies a studio has made, so I can find more like the ones I
  liked.
- As a guest, I want to see each movie's top cast, with each actor's name and the character
  they play, so I know who is in it. **This is the Top Cast report:** one query, in
  `queries/top-cast.sql`, that lists the top cast of all three movies.
- As a guest, I want to see the movies an actor has been in, so I can follow an actor I like.

A guest is anyone using the site without logging in, so there is no table for guests.

## The wireframe

Two pages a guest might see. Anything in [brackets] is a link.

```
+--------------------------------------------------+
|  KMDB                                            |
+--------------------------------------------------+
|                                                  |
|  The Dark Knight                                 |
|  2008 · PG-13 · [Warner Bros.]                   |
|                                                  |
|  Top cast                                        |
|  [Christian Bale] ............ Bruce Wayne       |
|  [Heath Ledger] .............. Joker             |
|  [Aaron Eckhart] ............. Harvey Dent       |
|  [Michael Caine] ............. Alfred            |
|  [Maggie Gyllenhaal] ......... Rachel Dawes      |
|                                                  |
+--------------------------------------------------+

+--------------------------------------------------+
|  KMDB                                            |
+--------------------------------------------------+
|                                                  |
|  Michael Caine                                   |
|                                                  |
|  Movies                                          |
|  [Batman Begins] (2005) ...... Alfred            |
|  [The Dark Knight] (2008) .... Alfred            |
|                                                  |
+--------------------------------------------------+
```
*Note: wireframes are for planning; a later design step would decide what the UI actually looks like. This step in the process just ensures we can later support something like this.*

## The data

Use Christopher Nolan's Batman trilogy to stress test the data model and satisfy the user stories.

- **Batman Begins** was released in 2005, rated PG-13, and made by Warner Bros. Its top cast:
  - Christian Bale as Bruce Wayne
  - Michael Caine as Alfred
  - Liam Neeson as Ra's Al Ghul
  - Katie Holmes as Rachel Dawes
  - Gary Oldman as Commissioner Gordon
- **The Dark Knight** was released in 2008, rated PG-13, and made by Warner Bros. Its top cast:
  - Christian Bale as Bruce Wayne
  - Heath Ledger as Joker
  - Aaron Eckhart as Harvey Dent
  - Michael Caine as Alfred
  - Maggie Gyllenhaal as Rachel Dawes
- **The Dark Knight Rises** was released in 2012, rated PG-13, and made by Warner Bros. Its top
  cast:
  - Christian Bale as Bruce Wayne
  - Gary Oldman as Commissioner Gordon
  - Tom Hardy as Bane
  - Joseph Gordon-Levitt as John Blake
  - Anne Hathaway as Selina Kyle

## Phase 1: paper first, then an AI chat

1. Template `dsgn425-fall2026/kmdb` as **Private**. Add the graders as collaborators. Create a Codespace.
2. Draw the ERD on paper. Photo as `erd.jpg`. **Commit it first.**
3. New chat with an AI assistant, whichever one you like. Give it this README and the photo. Ask what it would change about your drawing, and why, before any SQL.
4. Then ask for the tables. Paste the `CREATE TABLE` statements into `schema/kmdb.sql`. `bin/load`, then open the Schema page. Does it match your drawing, plus the changes you took?
5. Then ask for the data. Paste the `INSERT` statements into `data/kmdb.sql`. `bin/load` again.
6. The Top Cast report in `queries/top-cast.sql`.
7. `NOTES.md`: what the chat would change, what you took and why, and the chat link. Screenshots of the chat in `chat/`. Commit. Submit.

Why paper first: your commit history shows the drawing came first. That's the evidence, so
commit before you open the chat.

Why screenshots too: share links break, and some chats can't make one. The screenshots are
your backup. With no working link and no screenshots, there's no chat to grade.

## How to submit

> [!IMPORTANT]
> We grade a fresh copy of your repository on GitHub. If it isn't committed and synced, it
> isn't there. If we can't open your repository, we can't grade it.

### Private, with collaborators

Your copy is private, so nobody can see it until you add them, the way you would on any real
project. When you click **Use this template**, choose **Private**. Then, on your new
repository's page on github.com:

1. **Settings** (the tab at the top), then **Collaborators** in the left bar. GitHub may ask
   for your password.
2. **Add people**. Type `bjblock`, pick it from the list, **Add to repository**.
3. Again for `mrjonesbot`, and again for `emplumb`.

All three show as pending until they accept, and that's fine. Already made your copy public?
**Settings**, scroll to the bottom, **Change visibility**, **Private**.

### Getting the photo in

JPG or PNG. An iPhone photo can arrive on a Mac as HEIC, which nothing here can show; open it
in Preview and **File > Export** as JPEG. Then either:

- Drag it from your computer onto the file list on the left of the Codespace, and rename it
  `erd.jpg` if it isn't. Commit it from **Source Control**, then **Sync Changes**.
- Or on github.com, **Add file > Upload files**, and commit there. Then, in the Codespace,
  **Source Control**, the **...** menu, **Pull**, so the Codespace has it too.

### Handing it in

1. Commit, then **Sync Changes**. On github.com, check that your files are there, `erd.jpg`
   and `chat/` included.
2. On Canvas, submit your repository's URL, like `https://github.com/YOUR-USERNAME/kmdb`.

Phase 2 arrives when you submit phase 1.

## Why the terminal, and not the Run SQL page

Changing a database's structure (`CREATE TABLE`, `ALTER TABLE`, `DROP TABLE`) never happens
inside an app. The **Run SQL** box is for reading data, plus the occasional row change, and it
refuses the rest. Tables are built from a file, from the terminal: edit `schema/kmdb.sql`, run
`bin/load`.

Many teams give the people who analyze data read-only access to the database. Not out of
distrust: it means a slip can't change or delete anything.

## What is where

| Path | What it is |
|---|---|
| `erd.jpg` | Your drawing. Committed before anything else |
| `schema/kmdb.sql` | The tables, as `CREATE TABLE` statements |
| `data/kmdb.sql` | The rows, as `INSERT` statements |
| `bin/load` | Rebuilds the database from the two files above, from nothing, every time. If a file has an error it stops, names the line, and leaves the database as it was |
| `queries/top-cast.sql` | The Top Cast report |
| `NOTES.md` | What the chat would change about your drawing, what you took and why, and the chat link |
| `chat/` | Screenshots of the chat, as a backup for the link |
| `bin/query FILE` | Runs one `.sql` file from the terminal and prints the result |
| `db/kmdb.sqlite3` | The database, built by `bin/load`. Not committed: the `.sql` files are the source |
| `AGENTS.md` | Instructions for an AI agent working in this repo |
| `/` | **Run SQL**: one statement at a time, for reading data |
| `/queries` | **Queries**: every file in `queries/`, run fresh on each refresh |
| `/schema` | **Schema**: every table and column in the database right now, and where each foreign key points |
