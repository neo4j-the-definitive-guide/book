EXPLAIN
MATCH (a:Artist)<-[:ARTIST]-(t:Track)
RETURN a.name, count(t) as trackCount
  ORDER by trackCount DESC
  LIMIT 10;
