// find playlists sharing tracks
MATCH path=(p:Playlist)-[r1:HAS_TRACK]->(track)<-[r2:HAS_TRACK]-(other:Playlist)
WITH 
    p AS playlistLeft, 
    other AS playlistRight,
    // collect the track and left, right positions
    collect(
        {
            track: track, 
            positionLeft: r1.position, 
            positionRight: r2.position
        }
    ) AS commonTracks
// omit if they don't share at least 5 tracks
WHERE size(commonTracks) > 5
RETURN 
    playlistLeft.name, 
    playlistRight.name,
    size([track in commonTracks WHERE track.positionLeft = track.positionRight]) 
        AS tracksWithSamePosition,
    size([track in commonTracks WHERE NOT track.positionLeft = track.positionRight]) 
        AS tracksAtDifferentPosition
ORDER BY tracksWithSamePosition DESC
LIMIT 100;