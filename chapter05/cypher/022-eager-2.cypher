EXPLAIN
MATCH (t:Track)-[:ARTIST]->(a:Artist)
RETURN a.name as artistName, avg(t.duration) as avgDuration
  ORDER BY avgDuration