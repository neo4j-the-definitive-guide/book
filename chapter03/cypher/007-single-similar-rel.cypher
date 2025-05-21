MATCH path=(p:Playlist)-[r1:HAS_TRACK]->(track)<-[r2:HAS_TRACK]-(other:Playlist)
WITH p AS playlistLeft, other AS playlistRight,
     collect({track: track, positionLeft: r1.position, positionRight: r2.position}) AS commonTracks
  WHERE size(commonTracks) > 5
WITH playlistLeft, playlistRight,
     size([track in commonTracks WHERE track.positionLeft = track.positionRight]) AS tracksWithSamePosition,
     size([track in commonTracks WHERE NOT track.positionLeft = track.positionRight]) AS tracksAtDifferentPosition
MERGE (playlistLeft)-[r:SIMILAR]-(playlistRight)
SET r.samePosition = tracksWithSamePosition, r.notSamePosition = tracksAtDifferentPosition