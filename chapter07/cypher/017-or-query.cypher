CALL db.index.fulltext.queryNodes("Track", "purple OR rain")
YIELD node, score
RETURN node.name, score