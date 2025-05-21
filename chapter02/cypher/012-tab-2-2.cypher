MERGE (t1:Track {id: '123'})
MERGE (t2:Track {id: '234'})
MERGE (t1)-[:SIMILAR_TO]->(t2)
