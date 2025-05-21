:auto // necessary if you run this query in the Neo4j browser
LOAD CSV WITH HEADERS FROM "file:///medium/sample_tracks_medium.csv" AS row
CALL(row) {
MERGE (track:Track {id: row.track_id})
SET track.uri = row.track_uri,
track.name = row.track_name
} IN TRANSACTIONS OF 10_000 ROWS;