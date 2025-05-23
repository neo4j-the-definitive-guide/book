MATCH (a:Artist)<-[:ARTIST]-()-[:ON_PLAYLIST]->(p)
RETURN a.name AS artistName, count(p) as playlistCount