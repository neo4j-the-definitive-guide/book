EXPLAIN
MATCH (a:Artist)
WITH COLLECT(a) as artists
MATCH (t:Track)
WITH artists, COLLECT(t) as tracks
RETURN artists,tracks