CALL db.index.fulltext.queryNodes("Track", "purple rain")
YIELD node, score
MATCH (node)-[:ARTIST]->(artist)
RETURN node.name AS track, artist.name AS artist, score