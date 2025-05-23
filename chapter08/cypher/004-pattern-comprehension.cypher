MATCH (t:Track)
WITH [(t)-[:ON_PLAYLIST]->(p:Playlist) | p] AS playlists
RETURN count(*)