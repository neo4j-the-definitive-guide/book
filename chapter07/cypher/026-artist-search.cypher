// If the FTS index for Artist is not yet created, run this command first

CREATE FULLTEXT INDEX Artist FOR (n:Artist) ON EACH [n.name];

// Example query from book
CALL db.index.fulltext.queryNodes('Track', 'purple rain')
YIELD node AS track
MATCH path=(track)-[:ARTIST]->(a:Artist)
WHERE a IN COLLECT { 
  CALL db.index.fulltext.queryNodes('Artist', 'prince')
  YIELD node
}
RETURN path
LIMIT 10