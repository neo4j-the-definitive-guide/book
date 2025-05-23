UNWIND range(1,20000) AS i
CREATE (n:Node {id: randomUuid()})