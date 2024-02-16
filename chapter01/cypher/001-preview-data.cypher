LOAD CSV WITH HEADERS FROM "file:///sample_tracks.csv" AS row
RETURN row
LIMIT 5

LOAD CSV WITH HEADERS FROM "file:///sample_playlists.csv" AS row
RETURN row
LIMIT 5
