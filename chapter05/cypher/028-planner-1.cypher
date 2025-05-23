MATCH (t:Track)-[:ON_PLAYLIST]->(p:Playlist)
  WHERE t.duration > 8000000 and p.followers > 5000
RETURN p.name, t.name