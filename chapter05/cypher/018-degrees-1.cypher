PROFILE
MATCH (t:Track)-[:ON_PLAYLIST]->(p)
WITH t, count(p) as playlistCount
  WHERE playlistCount > 2500
RETURN t.name