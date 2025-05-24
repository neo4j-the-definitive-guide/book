EXPLAIN
MATCH (a:Artist)<-[:ARTIST]-(:Track)-[:ON_PLAYLIST]->(p:Playlist)
RETURN a.name AS artistName, count(p) as playlistCount