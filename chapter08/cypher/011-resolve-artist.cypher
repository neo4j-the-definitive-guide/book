MATCH (n:Artist)
WHERE n.id IN ['3qm84nBOXUEQ2vnTfUTTFC','t5k9j2h7f1w6m3n8p4q0r2s6x','b7f3a2c9e5d1x8k6m4n0p2q9r','z6r4k9n2h7p3m1j5f8x0w2d4q']//CALLOUT 1: Find the four artists to merge
WITH n ORDER BY n.primary //CALLOUT 2: Sort so that the primary node appears first 
WITH collect(n) as nodes //CALLOUT 3: Collect all nodes into a list, the primary is first
WITH nodes, head(nodes).name AS primaryName, head(nodes).id AS primaryId //CALLOUT 4: Extract the artist name and id from the primary node for use subsequently
CALL apoc.refactor.mergeNodes(nodes,{properties:"combine", mergeRels:true}) //CALLOUT 5: Merge all four nodes and combine the property values into an array if the values from all 4 nodes differ
YIELD node
WITH node, primaryName, primaryId
SET node.nameAlias=node.name, node.name=primaryName, node.id=primaryId //CALLOUT 6: Set the aliases, name and id
REMOVE node.primary //CALLOUT 7: Clean up the temporary primary property
RETURN node