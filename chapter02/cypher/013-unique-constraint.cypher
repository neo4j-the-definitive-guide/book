MATCH (n) DETACH DELETE n;
CREATE CONSTRAINT track_uk FOR (t:Track) REQUIRE t.id IS UNIQUE;
