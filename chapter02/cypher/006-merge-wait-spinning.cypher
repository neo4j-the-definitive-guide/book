MERGE (n:Track {id: 1})
WITH n
// the transaction will be paused for 60 seconds
CALL apoc.util.sleep(60000)
// the transaction now continues
SET n.name = 'Creep'
RETURN n