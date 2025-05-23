CALL db.index.fulltext.queryNodes('Track', ' "rain purple" ')
YIELD node, score
RETURN node.name, score