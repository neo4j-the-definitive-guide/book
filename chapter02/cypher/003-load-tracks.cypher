LOAD CSV WITH HEADERS FROM "file:///medium/sample_tracks_medium.csv" AS row
MERGE (track:Track {id: row.track_id})
SET track.uri = row.track_uri,
track.name = row.track_name;