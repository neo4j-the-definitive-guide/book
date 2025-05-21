MATCH (a:Playlist)-[:SIMILAR]-(b:Playlist)
RETURN a,b