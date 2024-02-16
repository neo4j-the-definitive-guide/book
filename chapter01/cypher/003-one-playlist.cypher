LOAD CSV WITH HEADERS FROM "file:///sample_playlists.csv" AS row
WITH row LIMIT 1

CREATE (playlist:Playlist {id: row.id})
SET playlist.name = row.name

CREATE (user:User {id: row.user_id})

CREATE (track:Track {id: row.track_id})

CREATE (user)-[:OWNS]->(playlist)
CREATE (playlist)-[:HAS_TRACK {position: row.playlist_track_index}]->(track)