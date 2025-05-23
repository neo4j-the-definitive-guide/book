EXPLAIN
MATCH (p:Playlist) WHERE p.followers = 100
DELETE p
MERGE (p2:Playlist) SET p2.followers = 100