//Find popular tracks
MATCH (popularTrack:Track)-[:ON_PLAYLIST]-(:Playlist)
WITH popularTrack, count(*) as playlistCount
  ORDER BY playlistCount DESC
  LIMIT 10
WITH collect(elementId(popularTrack)) as popularTracks
// For a given Playlist
MATCH (p:Playlist) WHERE p.name = "all that jazz"
// Find the last track
MATCH (p)<-[r:ON_PLAYLIST]-(t)
  WHERE r.position = COUNT { (p)<-[:ON_PLAYLIST]-()}
WITH p AS playlist, t AS lastTrack, popularTracks
// Get the previous tracks
WITH playlist, lastTrack, popularTracks, COLLECT {
MATCH (playlist)<-[:ON_PLAYLIST]-(previous)
  WHERE previous <> lastTrack
RETURN elementId(previous)
} AS previousTracks
// Find other playlists that have the same the last track
MATCH (lastTrack)-[:ON_PLAYLIST]->(otherPlaylist)-[:SIMILAR]-(playlist)
// Find other tracks which are not in the given playlist
MATCH (otherPlaylist)<-[:ON_PLAYLIST]-(recommendation)
WHERE NOT elementId(recommendation) IN previousTracks
AND NOT elementId(recommendation) IN popularTracks
// Score them by how frequently they appear
RETURN  recommendation.id as recommendedTrackId, recommendation.name AS recommendedTrack, otherPlaylist.name AS fromPlaylist, count(*) AS score
ORDER BY score DESC
LIMIT 5
