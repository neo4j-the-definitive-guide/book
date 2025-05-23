CALL db.index.fulltext.queryNodes('Track', 'color~0.7')
YIELD node, score
WITH node WHERE node.name CONTAINS 'colour'
RETURN count(*) AS count