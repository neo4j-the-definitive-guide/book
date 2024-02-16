LOAD CSV WITH HEADERS FROM "file:///sample_playlists.csv" AS row

MERGE (playlist:Playlist {id: row.id})
SET playlist.name = row.name

MERGE (user:User {id: row.user_id})

MERGE (track:Track {id: row.track_id})

MERGE (user)-[:OWNS]->(playlist)
MERGE (playlist)-[:HAS_TRACK {position: row.track_index}]->(track)