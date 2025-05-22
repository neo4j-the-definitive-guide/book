//Step 1
MATCH (p:Playlist)-[hastrack:HAS_TRACK]->(t:Track)
//Step 2
MERGE (t)-[onplaylist:ON_PLAYLIST]->(p)
SET onplaylist.position=hastrack.position;