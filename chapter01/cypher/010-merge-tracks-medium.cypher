LOAD CSV WITH HEADERS FROM "file:///medium/sample_tracks_medium.csv" AS row

MERGE (track:Track {id: row.track_id})
SET track.uri = row.track_uri,
track.name = row.track_name

MERGE (album:Album {id: row.album_id})
SET album.uri = row.album_uri,
album.name = row.album_name

MERGE (artist:Artist {id: row.artist_id})
SET artist.uri = row.artist_uri,
artist.name = row.artist_name

MERGE (album)-[:HAS_TRACK]->(track)
MERGE (track)-[:ARTIST]->(artist)
