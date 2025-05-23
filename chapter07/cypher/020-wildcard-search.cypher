CALL db.index.fulltext.queryNodes('Track', 'pur* AND rai*')
YIELD node, score
RETURN node.name, score