CALL db.index.fulltext.queryNodes('Genre', '*rock')
YIELD node, score
RETURN node.name, score