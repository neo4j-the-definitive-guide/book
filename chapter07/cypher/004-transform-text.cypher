:auto
MATCH (n:Track)
CALL (n) {
    SET n.name = toLower(n.name)
} IN TRANSACTIONS OF 50_000 ROWS