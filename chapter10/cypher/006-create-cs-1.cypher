CREATE DATABASE erfacts WAIT ;

// Switch db

:use erfacts

// Create data

MERGE (a:Artist {id: "fused-3qm84nBOXUEQ2vnTfUTTFC"})
WITH a
UNWIND
[
{name: "Guns And Roses", id: "3qm84nBOXUEQ2vnTfUTTFC"}, 
{name: "G'N'R", id: "t5k9j2h7f1w6m3n8p4q0r2s6x"}, 
{name: "Guns n roses", id: "b7f3a2c9e5d1x8k6m4n0p2q9r"}, 
{name: "Guns n' roses", id: "z6r4k9n2h7p3m1j5f8x0w2d4q"}
] AS fact
MERGE (n:Artist {id: fact.id})
SET n.name = fact.name
SET n:Fact
MERGE (a)-[:FACT]->(n);
