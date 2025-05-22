//Stage 1
//Step 1
:auto
MATCH (p:Playlist)
CALL {
  WITH p
  MATCH (t:Track)-[r:ON_PLAYLIST]->(p:Playlist)
  //Step 2
  CREATE (pt:PlaylistTrack)
  CREATE (t)-[:PLAYLIST_ITEM]->(pt)
  //Step 3
  CREATE (p)-[:TRACK_ITEM_TEMP {position:r.position}]->(pt)
} IN TRANSACTIONS