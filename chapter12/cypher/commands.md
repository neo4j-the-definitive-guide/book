# Chapter12 Cypher commands

**Find playlist with 20 to 25 tracks**

```cypher
MATCH (n:Playlist)
WHERE 20 <=  n.total_tracks <= 25
RETURN count(n)
```

**Mark the playlists**

```cypher
MATCH (n:Playlist)
WHERE 20 <=  n.total_tracks <= 25
SET n:ExperimentOne
```

**Tracks in common between playlists**

```cypher
MATCH (playlist1:ExperimentOne)
WITH playlist1 LIMIT 1
MATCH 
(playlist1)-[:HAS_TRACK]->(track:Track)
<-[:HAS_TRACK]-(playlist2:ExperimentOne)
WHERE playlist1 <> playlist2
RETURN playlist1.id, playlist2.id, count(*) AS sharedTracks
ORDER BY sharedTracks DESC
LIMIT 5
```

**10 playlists**

```cypher
MATCH (playlist1:ExperimentOne)
WITH playlist1 LIMIT 10
MATCH 
(playlist1)-[:HAS_TRACK]->(track:Track)
<-[:HAS_TRACK]-(playlist2:ExperimentOne)
WHERE playlist1 <> playlist2
RETURN playlist1.id, playlist2.id, count(*) AS sharedTracks
ORDER BY sharedTracks DESC
LIMIT 5
```

**Skip low co-occurrences**

```cypher
MATCH (playlist1:ExperimentOne)
WITH playlist1 LIMIT 10
MATCH 
(playlist1)-[:HAS_TRACK]->(track:Track)
<-[:HAS_TRACK]-(playlist2:ExperimentOne)
WHERE playlist1 <> playlist2
WITH playlist1, playlist2, count(*) AS sharedTracks
WHERE sharedTracks > 1
RETURN playlist1.id, playlist2.id, sharedTracks
ORDER BY sharedTracks DESC
LIMIT 5
```

**Create co-occurrence relationships**

```cypher
:auto
MATCH (n:Playlist:ExperimentOne)
CALL (n) {
    MATCH (n)-[:HAS_TRACK]->(t)<-[:HAS_TRACK]-(other:ExperimentOne)
    WHERE n <> other
    WITH n, other, count(*) AS tracksInCommon
    WHERE tracksInCommon > 1
    MERGE (n)-[r:CO_OCCURS]-(other)
    SET r.weight = tracksInCommon
} IN TRANSACTIONS OF 10_000 ROWS
```

**min/max/avg of tracks in common**

```cypher
MATCH (n:Playlist)-[r:CO_OCCURS]->(o)
RETURN min(r.weight), max(r.weight), avg(r.weight)
```

**estimate graph projection**

```cypher
CALL gds.graph.project.estimate(
  'ExperimentOne',
  {CO_OCCURS: {orientation: 'UNDIRECTED', properties: 'weight'}}
)
YIELD requiredMemory, mapView, 
heapPercentageMin, heapPercentageMax
```

**first graph projection**

```cypher
CALL gds.graph.project(
  'playlistCoOccurrences',
  'ExperimentOne',
  {CO_OCCURS: {orientation: 'UNDIRECTED', properties: 'weight'}}
)
YIELD
  graphName AS graph,
  relationshipProjection AS relProjection,
  nodeCount AS nodes,
  relationshipCount AS rels
```

**Louvain algorithm memory estimation**

```cypher
CALL gds.louvain.write.estimate('playlistCoOccurrences', { writeProperty: 'community' })
YIELD nodeCount, relationshipCount, bytesMin, bytesMax, requiredMemory
```

**Louvain algorithm stream**

```cypher
CALL gds.louvain.stream('playlistCoOccurrences')
YIELD nodeId, communityId, intermediateCommunityIds
RETURN gds.util.asNode(nodeId).id AS playlist, communityId
ORDER BY communityId ASC
LIMIT 10
```

**Create communityId constraint**

```cypher
CREATE CONSTRAINT communityIdUnique
FOR (n:Community)
REQUIRE n.id IS UNIQUE
```

**Store Louvain communities**

```cypher
CALL gds.louvain.stream('playlistCoOccurrences')
YIELD nodeId, communityId, intermediateCommunityIds
WITH gds.util.asNode(nodeId) AS playlist, communityId
MERGE (c:Community {id: communityId})
MERGE (c)-[:HAS_PLAYLIST]->(playlist)
```

**Count communities**

```cypher
MATCH (c:Community)
RETURN count(c) AS count
```

**Communities with only 1 playlist**

```cypher
MATCH (c:Community)
WHERE COUNT { (c)-[:HAS_PLAYLIST]->() } = 1
RETURN count(c) AS count
```

**Second co-occurrence relationship**

```cypher
:auto
MATCH (n:Playlist:ExperimentOne)
CALL {
    WITH n
    MATCH (n)-[:HAS_TRACK]->(t)<-[:HAS_TRACK]-(other:ExperimentOne)
    WHERE n <> other
    WITH n, other, count(*) AS tracksInCommon
    WHERE tracksInCommon >= 4
    MERGE (n)-[r:CO_OCCURS_TWO]-(other)
    SET r.weight = tracksInCommon
} IN TRANSACTIONS OF 500 ROWS
```

**Second projection**

```cypher
CALL gds.graph.project(
  'playlistCoOccurrencesTwo',
  'ExperimentOne',
  {CO_OCCURS_TWO: {orientation: 'UNDIRECTED', properties: 'weight'}}
)
YIELD
  graphName AS graph,
  relationshipProjection AS relProjection,
  nodeCount AS nodes,
  relationshipCount AS rels
```

**Second communities**

```cypher
CALL gds.louvain.stream('playlistCoOccurrencesTwo')
YIELD nodeId, communityId, intermediateCommunityIds
WITH gds.util.asNode(nodeId) AS playlist, communityId
MERGE (c:CommunityTwo {id: communityId})
MERGE (c)-[:HAS_PLAYLIST]->(playlist)
```

**Cypher projection**

```cypher
MATCH (source:ExperimentOne)-[r:CO_OCCURS_TWO]->(target:ExperimentOne)
WITH gds.graph.project(
  'playlistCoOccurrencesThree',
  source,
  target,
  { relationshipProperties: r { .weight } }
) AS g
RETURN
  g.graphName AS graph, g.nodeCount AS nodes, g.relationshipCount AS rels
```


**Third co-occurrence**

```cypher
CALL gds.louvain.stream('playlistCoOccurrencesThree')
YIELD nodeId, communityId, intermediateCommunityIds
WITH gds.util.asNode(nodeId) AS playlist, communityId
MERGE (c:CommunityThree {id: communityId})
MERGE (c)-[:HAS_PLAYLIST]->(playlist)
```

**Proportion**

```cypher
MATCH (c:CommunityThree)
WHERE COUNT { (c)-[:HAS_PLAYLIST]->() } = 1
RETURN count(c) AS count;
// 2246

MATCH (c:CommunityThree)
RETURN count(c) AS count;
// 4158
```

**Similar playlists**

```cypher
MATCH (p:Playlist {id: "01wvUa0flceLMo1IYWD3vB"})
MATCH (p)<-[:HAS_PLAYLIST]-(c:CommunityThree)-[:HAS_PLAYLIST]->(other:Playlist)
WHERE other<> p
RETURN p.name AS playlistFrom,
other.name AS recommendation
ORDER BY rand()
LIMIT 5
```

**User segmentation**

```cypher
MATCH (u:User)-[:FOLLOWS]->(p:Playlist)<-[:HAS_PLAYLIST]-(c:Community)
WITH u, c.id AS communityId, count(*) AS score
ORDER BY score DESC
WITH u, collect(communityId)[0] AS topCommunity
SET u.segment = topCommunity
```

**Pagerank**

```cypher
CALL gds.pageRank.stream('playlistCoOccurrencesThree')
YIELD nodeId, score
WITH gds.util.asNode(nodeId) AS playlist, score
MATCH (c:CommunityThree)-[:HAS_PLAYLIST]->(playlist)
RETURN c.id AS communityId, playlist.name AS playlist, score
ORDER BY score DESC
LIMIT 5
```

**Behavioural cluster**

```cypher
CYPHER runtime=parallel
MATCH (c:CommunityThree)-[:HAS_PLAYLIST]->(p:Playlist)-[:HAS_TRACK]->(t:Track)
WHERE t.name IS NOT NULL AND t.name <> ""
WITH c.id AS communityId, collect(DISTINCT t.name)[0..3] AS sampleTracks, count(DISTINCT p) AS size
RETURN communityId, sampleTracks, size
ORDER BY size DESC
LIMIT 10
```

**High-impact tracks**

```cypher
MATCH (c:Community)-[:HAS_PLAYLIST]->(p:Playlist)-[:HAS_TRACK]->(t:Track)
WITH t, count(DISTINCT p) AS playlistCount
RETURN t.id, t.title, playlistCount
ORDER BY playlistCount DESC
LIMIT 50
```