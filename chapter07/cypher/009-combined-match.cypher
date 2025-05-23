PROFILE
MATCH (n:Track)-[:ARTIST]->(a:Artist)
WHERE n.name CONTAINS "purple rain"
AND a.name = "prince"
RETURN n