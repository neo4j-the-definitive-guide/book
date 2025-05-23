MATCH (n:Artist)
WHERE toLower(n.name) STARTS WITH "guns" OR
toLower(n.name) STARTS WITH "gnr"
RETURN n.id as `ID`,
n.name as `Music Artist`,
COLLECT {MATCH (n)-[:GENRE]->(g:Genre) return g.name} AS `Genre`,
COLLECT {MATCH (n)<-[:ARTIST]-(t:Track) return t.name} AS `Tracks`