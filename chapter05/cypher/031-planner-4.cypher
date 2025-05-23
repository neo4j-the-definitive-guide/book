MATCH (t:Track)-[:ON_PLAYLIST]->(p:Playlist)
USING INDEX t:Track(duration)
  WHERE t.duration > 8000000
MATCH (t)-[:ON_PLAYLIST]->(p)
  WHERE p.followers > 5000
RETURN p.name, t.name