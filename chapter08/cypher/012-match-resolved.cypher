MATCH (n:Artist)-[r]-(m)
WHERE toLower(n.name) STARTS WITH "guns" OR
toLower(n.name) STARTS WITH "gnr" return n,r,m