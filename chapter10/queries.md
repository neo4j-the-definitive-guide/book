## Composite db 1 creation

CREATE DATABASE erfacts WAIT ;
:use erfacts ;
MERGE (a:Artist {id: "fused-3qm84nBOXUEQ2vnTfUTTFC"})
WITH a
UNWIND [
{name: "Guns And Roses", id: "3qm84nBOXUEQ2vnTfUTTFC"}, 
{name: "G'N'R", id: "t5k9j2h7f1w6m3n8p4q0r2s6x"}, 
{name: "Guns n roses", id: "b7f3a2c9e5d1x8k6m4n0p2q9r"}, 
{name: "Guns n' roses", id: "z6r4k9n2h7p3m1j5f8x0w2d4q"}
] AS fact
MERGE (n:Artist {id: fact.id})
SET n.name = fact.name
SET n:Fact
MERGE (a)-[:FACT]->(n);

## Composite db 2 creation

CREATE DATABASE songs WAIT ;
:use songs ;
MERGE (a:Artist {id: "fused-3qm84nBOXUEQ2vnTfUTTFC"})
WITH a
UNWIND [
"Patience", "Paradise City", "November Rain"
] AS track
MERGE (t:Track {id: randomUuid()})
SET t.name = track
MERGE (t)-[:ARTIST]->(a);

## Query a constituent

USE composed.songs
MATCH (n) RETURN count(n)

## Query two constituents

USE composed.songs
MATCH (n) RETURN count(n) AS c
UNION
USE composed.erfacts
MATCH (n) RETURN count(n) AS c

## Get list of constituents

UNWIND graph.names() AS name
RETURN name

## Get data from all constituents

UNWIND graph.names() AS g
CALL {
    USE graph.byName(g)
    MATCH (n) RETURN count(n) AS c
}
RETURN sum(c) AS totalNodes

## Get songs

USE composed.songs
MATCH (t:Track {name: "Patience"})
MATCH p=(t)-->(a:Artist)<--(t2)
RETURN p


## Composed query

CALL {
    USE composed.songs
    MATCH (t:Track {name: "Patience"})
    MATCH p=(t)-->(a:Artist)<--(t2)
    RETURN a, p
}
WITH a.id AS artistId, p
CALL(artistId) {
    USE composed.erfacts
    MATCH (a2:Artist {id: artistId})
    MATCH fp=(a2)--(f:Fact)
    RETURN fp
}
RETURN p, fp