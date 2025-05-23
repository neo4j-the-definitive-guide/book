MATCH (t:Track)
CALL (t) {
MATCH (t)-[:ON_PLAYLIST]->(p:Playlist)
RETURN collect(p) as playlists
}
RETURN count(*)