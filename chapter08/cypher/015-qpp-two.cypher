// Use this query to remove the previously generated data

MATCH (n:EntityGroup)--(x)
DETACH DELETE n
DETACH DELETE x

// Create the example data

// Create Entity Group node
CREATE (eg:EntityGroup {name: "Guns'N' Roses"})

// Create Artist nodes
CREATE (a1:Artist {name: "GNR"})
CREATE (a2:Artist {name: "Guns n roses"})
CREATE (a3:Artist {name: "Guns'N' Roses"})

// Create Track nodes
CREATE (t1:Track {name: "Estranged"})
CREATE (t2:Track {name: "Sweet Child O' Mine"})
CREATE (t3:Track {name: "Civil War"})
CREATE (t4:Track {name: "Sweet Child of mine"}) // note the slightly different name (assumed to be a duplicate spelling)

// Create relationships from Entity Group to Artists
CREATE (eg)-[:ENTITYGROUP_ARTIST]->(a1)
CREATE (eg)-[:ENTITYGROUP_ARTIST]->(a2)
CREATE (eg)-[:ENTITYGROUP_ARTIST]->(a3)

// Create relationships from Artists to Tracks
CREATE (a1)-[:TRACK]->(t1)
CREATE (a2)-[:TRACK]->(t2)
CREATE (a3)-[:TRACK]->(t3)

// Create relationships from Entity Group to Tracks
CREATE (eg)-[:ENTITYGROUP_TRACK]->(t2)
CREATE (eg)-[:ENTITYGROUP_TRACK]->(t4)


// Use now the QPP to query

MATCH p =
(n:Artist {name: "Guns'N' Roses"})
(()-[:ENTITYGROUP_ARTIST]-()-[:ENTITYGROUP_ARTIST]-()){0,1}
()-[:TRACK]-()
(()-[:ENTITYGROUP_TRACK]-()-[:ENTITYGROUP_TRACK]-()){0,1}
RETURN p