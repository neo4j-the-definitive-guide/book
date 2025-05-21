// Find the 10 most popular tracks
WITH COLLECT {
    MATCH (popularTrack:Track)-[:HAS_TRACK]-(:Playlist)
    WITH popularTrack, count(*) as playlistCount
    ORDER BY playlistCount DESC
    LIMIT 10
    RETURN popularTrack
} AS popularTracks

// For a given Playlist
MATCH (p:Playlist) WHERE p.name = "all that jazz"

// Collect the tracks in reverse position
WITH p, popularTracks,
COLLECT {
    MATCH (p)-[r:HAS_TRACK]->(t)
    WITH t, r
    ORDER BY r.position DESC
    RETURN t
} AS playlistTracks

WITH 
    p AS playlist, 
    popularTracks,
    head(playlistTracks) AS lastTrack,
    tail(playlistTracks) AS previousTracks


// Find other playlists that have the same the last track
MATCH (lastTrack)<-[:HAS_TRACK]-(otherPlaylist)-[:SIMILAR]-(playlist)
WHERE otherPlaylist <> playlist

// Find other tracks which are not in the given playlist
MATCH (otherPlaylist)-[:HAS_TRACK]->(recommendation)
WHERE NOT recommendation IN previousTracks
AND NOT recommendation IN popularTracks

// Score them by how frequently they appear
RETURN recommendation.id as recommendedTrackId, recommendation.name AS recommendedTrack, otherPlaylist.name AS fromPlaylist, count(*) AS score
ORDER BY score DESC
LIMIT 10