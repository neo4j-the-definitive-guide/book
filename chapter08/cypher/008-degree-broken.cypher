PROFILE
MATCH (n:Track) WHERE n.track_id = '0qbV8TfCN7gTESOxixV2SI' 
RETURN COUNT { (n)<-[:HAS_TRACK]-(:Playlist) } AS degreeInHasTrack