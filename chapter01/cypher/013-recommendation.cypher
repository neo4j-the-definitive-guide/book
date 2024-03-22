//Find popular tracks
MATCH (popularTrack:Track)-[:HAS_TRACK]-(:Playlist)
WITH popularTrack, count(*) as playlistCount
  ORDER BY playlistCount DESC
  LIMIT 10
WITH collect(elementId(popularTrack)) as popularTracks


// For a given Playlist
MATCH (p:Playlist) WHERE p.name = "all that jazz"


// Find the last track
MATCH (p)-[r:HAS_TRACK]->(t)
  WHERE r.position = COUNT { (p)-[:HAS_TRACK]->()}
WITH p AS playlist, t AS lastTrack, popularTracks


// Get the previous tracks
WITH playlist, lastTrack, popularTracks, COLLECT {
MATCH (playlist)-[:HAS_TRACK]->(previous)
  WHERE previous <> lastTrack
RETURN elementId(previous)
} AS previousTracks


// Find other playlists that have the same the last track
MATCH (lastTrack)<-[:HAS_TRACK]-(otherPlaylist)-[:SIMILAR]-(playlist)
WHERE otherPlaylist <> playlist


// Find other tracks which are not in the given playlist
MATCH (otherPlaylist)-[:HAS_TRACK]->(recommendation)
WHERE NOT elementId(recommendation) IN previousTracks
AND NOT elementId(recommendation) IN popularTracks


// Score them by how frequently they appear
RETURN  recommendation.id as recommendedTrackId, recommendation.name AS recommendedTrack, otherPlaylist.name AS fromPlaylist, count(*) AS score
ORDER BY score DESC
LIMIT 5