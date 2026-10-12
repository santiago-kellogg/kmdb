# AGENTS.md

Instructions for an AI agent working in this repo.

The database is built only from two files: `schema/kmdb.sql` (CREATE TABLE) and
`data/kmdb.sql` (INSERT). `bin/load` rebuilds it from nothing, from both files, every time.

- To design or change tables, edit `schema/kmdb.sql`, then run `bin/load`. Never change the
  structure any other way: not through the app, not with `sqlite3` or `bin/rails db` directly.
- To add rows that should survive a rebuild, put them in `data/kmdb.sql`.
- To answer a question about the data, write the SQL to a file in `queries/` with the
  question on the first line (`-- Q: ...`) and run it with `bin/query`. Every number you give
  must come from a query you ran.
- Show any statement that changes data or structure before running it, and wait for
  confirmation.
- Do not create, edit or commit `erd.jpg`, `NOTES.md` or anything in `chat/`. Those are the
  student's own.
