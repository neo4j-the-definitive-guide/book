EXPLAIN
MATCH (a:Artist)<-[:ARTIST]-(t:Track)
  WHERE t.duration > 0
RETURN a.name as artistName, t.duration as trackDuration
  ORDER BY trackDuration LIMIT 5