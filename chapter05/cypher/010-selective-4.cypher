EXPLAIN
MATCH (a:Artist)<-[:ARTIST]-()-[:ON_PLAYLIST]->(p:Playlist)
  WHERE p.followers > 5000
RETURN a.name AS artistName, count(p) as playlistCount