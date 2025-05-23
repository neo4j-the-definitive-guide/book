:auto
MATCH (n:Track)
WITH n
CALL (n) {
    SET n.name = toLower(n.name)
} IN TRANSACTIONS OF 50_000 ROWS