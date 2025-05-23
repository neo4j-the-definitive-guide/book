:USE prod

// Then
UNWIND range(1,10) AS i
CREATE (n:Node)