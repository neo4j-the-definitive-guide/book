MATCH (t:Track)
  WHERE COUNT {(t)-[:ON_PLAYLIST]->(:Playlist)} > 2500
RETURN t.name