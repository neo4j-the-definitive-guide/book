MATCH (n:Track)
WHERE n.name = toLower("Purple RAIN")
RETURN n