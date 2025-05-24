MATCH (c:Community)-[:HAS_PLAYLIST]->(p)
WHERE c.id = 44386
MATCH (p)-[:HAS_TRACK]->(t)-[:ARTIST]->(a)
RETURN t.name AS track, a.name AS artist
ORDER BY rand()
LIMIT 10