MATCH (a:Artist)<-[:ARTIST]-(t:Track)
  WHERE t.duration > 0 AND a.name="Pink Floyd"
RETURN t.name as trackName, t.duration as trackDuration