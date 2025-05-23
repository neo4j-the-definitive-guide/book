MATCH (t:Track)
  WHERE t.duration > 8000000
RETURN count(t);


MATCH (p:Playlist)
  WHERE p.followers > 5000
RETURN count(p);