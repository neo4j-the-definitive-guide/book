CALL db.index.fulltext.queryNodes("Track", "purple AND rain")
YIELD node, score
RETURN node.name, score