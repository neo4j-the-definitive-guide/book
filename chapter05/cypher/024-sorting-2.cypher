EXPLAIN
MATCH (a:Artist)<-[:ARTIST]-(t:Track)
RETURN a.name as artistName, t.duration as trackDuration
  ORDER BY trackDuration LIMIT 5