UNWIND graph.names() AS g
CALL(g) {
    USE graph.byName(g)
    MATCH (n) RETURN count(n) AS c
}
RETURN sum(c) AS totalNodes
