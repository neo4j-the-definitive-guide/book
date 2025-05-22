//Stage 2
:auto
MATCH (p:Playlist)
CALL {
  WITH p
  MATCH (p)-[:TRACK_ITEM_TEMP {position:1}]->(firstTrack:PlaylistTrack)
  CREATE (p)-[:PLAYLIST_TRACK]->(firstTrack)
  WITH p
  MATCH (p)-[r:TRACK_ITEM_TEMP]->(lastTrack:PlaylistTrack)
    WHERE r.position = COUNT {()-[:ON_PLAYLIST]->(p)}
  CREATE (p)-[:LAST_PLAYLIST_TRACK]->(lastTrack)
} IN TRANSACTIONS