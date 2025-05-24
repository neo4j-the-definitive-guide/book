//Step 3
MATCH (p:Playlist)-[hastrack:HAS_TRACK]->(t:Track)
DELETE hastrack