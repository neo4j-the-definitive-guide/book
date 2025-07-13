MATCH (primary:Artist {id:"3qm84nBOXUEQ2vnTfUTTFC"})
WITH primary //CALLOUT 1
MERGE (fused:Artist {id:"fused-3qm84nBOXUEQ2vnTfUTTFC"})
SET fused.name = primary.name, fused.uri = primary.uri, //CALLOUT 2
fused.aliases=[] //CALLOUT 3
SET fused:$(labels(primary))  //CALLOUT 4
WITH fused
MATCH (fact:Artist)
WHERE fact.id IN ['3qm84nBOXUEQ2vnTfUTTFC','t5k9j2h7f1w6m3n8p4q0r2s6x',
'b7f3a2c9e5d1x8k6m4n0p2q9r','z6r4k9n2h7p3m1j5f8x0w2d4q']
SET fused.aliases=fused.aliases + fact.name //CALLOUT 5
WITH fused, fact
OPTIONAL MATCH (fact)-[factRelOut]->(otherOut)
MERGE (fused)-[fusedRelOut:$(type(factRelOut))]->(otherOut) //CALLOUT 6
SET fusedRelOut=factRelOut //CALLOUT 7
WITH fact, fused
OPTIONAL MATCH (fact)<-[factRelIn]-(otherIn) //CALLOUT 8
MERGE (fused)-[fusedRelIn:$(type(factRelIn))]->(otherIn)
SET fusedRelIn=factRelIn
WITH fact, fused
MERGE (fused)-[:FACT]->(fact) //CALLOUT 9