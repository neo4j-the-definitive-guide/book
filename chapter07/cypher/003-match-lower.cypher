MATCH (n:Track)
WHERE toLower(n.name) = "purple rain"
RETURN n