LOAD CSV WITH HEADERS FROM "file:///medium/sample_playlists_medium.csv" AS row

MERGE (playlist:Playlist {id: row.id})
SET playlist.name = row.name

MERGE (user:User {id: row.user_id})

MERGE (track:Track {id: row.track_id})

MERGE (user)-[:OWNS]->(playlist)
MERGE (playlist)-[:HAS_TRACK {position: toInteger(row.track_index)}]->(track)