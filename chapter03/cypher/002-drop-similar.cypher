//002-drop-similar.cypher
MATCH ()-[r:SIMILAR]-()
DELETE r