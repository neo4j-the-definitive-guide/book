MATCH (t1:Track {id: 1})
MATCH (t2:Track {id: 2})
CREATE (t1)-[r:SIMILAR]->(t2)