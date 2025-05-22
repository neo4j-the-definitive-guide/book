//Stage 3
//Step 1
:auto
MATCH (p:Playlist)
CALL {
WITH p
MATCH (p)-[r:TRACK_ITEM_TEMP]->(t:PlaylistTrack)
WITH r,t
  ORDER BY r.position
WITH COLLECT(t) AS playlistTracks
UNWIND RANGE(0,SIZE(playlistTracks) - 2) as idx
WITH playlistTracks[idx] AS t1, playlistTracks[idx+1] AS t2
MERGE (t1)-[:PLAYLIST_TRACK]->(t2)
} IN TRANSACTIONS