EXPLAIN MATCH (a:Artist)<-[:ARTIST]-(t:Track)
WITH a, count(t) as trackCount
  ORDER by trackCount DESC
  LIMIT 10
RETURN a.name, trackCount