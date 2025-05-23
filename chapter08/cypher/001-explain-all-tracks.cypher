EXPLAIN
MATCH (t:Track)-[:ON_PLAYLIST]->(p:Playlist)
RETURN t as track, COLLECT(p) as playlists