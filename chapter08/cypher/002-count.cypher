MATCH (t:Track)-[:ON_PLAYLIST]->(p:Playlist)
WITH t as track, COLLECT(p) as playlists
RETURN count(*)