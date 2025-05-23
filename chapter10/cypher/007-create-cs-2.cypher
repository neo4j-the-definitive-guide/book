CREATE DATABASE songs WAIT ;

// Switch db

:use songs ;

// Create data

MERGE (a:Artist {id: "fused-3qm84nBOXUEQ2vnTfUTTFC"})
WITH a
UNWIND [
"Patience", "Paradise City", "November Rain"
] AS track
MERGE (t:Track {id: randomUuid()})
SET t.name = track
MERGE (t)-[:ARTIST]->(a);
