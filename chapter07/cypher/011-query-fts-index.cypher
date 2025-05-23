CALL db.index.fulltext.queryNodes('Track', 'purple', {limit: 10})
YIELD node, score
RETURN node.name AS trackName, score