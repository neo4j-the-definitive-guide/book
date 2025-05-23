USE composed.songs
MATCH (n) RETURN count(n)
UNION
USE composed.erfacts
MATCH (n) RETURN count(n)
