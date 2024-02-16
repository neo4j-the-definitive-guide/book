LOAD CSV WITH HEADERS FROM "file:///sample_tracks.csv" AS row
WITH row LIMIT 1

CREATE (track:Track {id: row.track_id})
SET track.uri = row.track_uri,
track.name = row.track_name

CREATE (album:Album {id: row.album_id})
SET album.uri = row.album_uri,
album.name = row.album_name

CREATE (artist:Artist {id: row.artist_id})
SET artist.uri = row.artist_uri,
artist.name = row.artist_name

CREATE (album)-[:HAS_TRACK]->(track)
CREATE (track)-[:ARTIST]->(artist)