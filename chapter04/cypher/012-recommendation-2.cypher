//Find popular tracks
MATCH (popularTrack:Track)-[:PLAYLIST_ITEM]->()
WITH popularTrack, count(*) as playlistCount
ORDER BY playlistCount DESC
LIMIT 10
WITH collect(elementId(popularTrack)) as popularTracks
// For a given Playlist
MATCH (playlist:Playlist) WHERE playlist.name = "all that jazz"
// Find the last track
MATCH (playlist)-[:LAST_PLAYLIST_TRACK]->(lastTrackItem)

// Get the previous tracks
WITH playlist, lastTrackItem, popularTracks, COLLECT {
MATCH (playlist) (()-[:PLAYLIST_TRACK]->()) {1,100} (previousTrackItem)
WHERE previousTrackItem <> lastTrackItem
RETURN elementId(previousTrackItem)
} AS previousTrackItems

// Find other playlists that have the same the last track
MATCH (playlist)-[:SIMILAR]-(otherPlaylist:Playlist)-[:LAST_PLAYLIST_TRACK]->(otherLastTrack)<-[:PLAYLIST_ITEM]-(:Track)-[:PLAYLIST_ITEM]->()<-[:LAST_PLAYLIST_TRACK]-(playlist)

// Find other tracks which are not in the given playlist
MATCH (otherPlaylist) (()-[:PLAYLIST_TRACK]->()) {1,100} (recommendationItem)<-[:PLAYLIST_ITEM]-(recommendation)
WHERE NOT elementId(recommendationItem) IN previousTrackItems
AND NOT elementId(recommendationItem) IN popularTracks

// Score them by how frequently they appear
RETURN  recommendation.id as recommendedTrackId, recommendation.name AS recommendedTrack, otherPlaylist.name AS fromPlaylist, count(*) AS score
ORDER BY score DESC
LIMIT 5