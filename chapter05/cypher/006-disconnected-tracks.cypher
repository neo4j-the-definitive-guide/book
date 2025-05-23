EXPLAIN
MATCH (t:Track)
WITH COLLECT(t) as tracks
MATCH (a:Artist)
WITH tracks, COLLECT(a) as artists
RETURN artists,tracks