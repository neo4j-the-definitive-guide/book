// You can use the following query to generate the data

CREATE (eg:EntityGroup {name: "Guns'N' Roses"})

// Create Artist nodes
CREATE (a1:Artist {name: "GNR"})
CREATE (a2:Artist {name: "Guns n roses"})
CREATE (a3:Artist {name: "Guns'N' Roses"})

// Create Track nodes
CREATE (t1:Track {name: "Estranged"})
CREATE (t2:Track {name: "Sweet Child O' Mine"})
CREATE (t3:Track {name: "Civil War"})

// Create relationships between Entity Group and Artists
CREATE (eg)-[:ENTITYGROUP_ARTIST]->(a1)
CREATE (eg)-[:ENTITYGROUP_ARTIST]->(a2)
CREATE (eg)-[:ENTITYGROUP_ARTIST]->(a3)

// Create relationships between Artists and Tracks
CREATE (a1)-[:TRACK]->(t1)
CREATE (a2)-[:TRACK]->(t2)
CREATE (a3)-[:TRACK]->(t3)

// Then the QPP to query

MATCH
  (n:Artist {name: "Guns'N' Roses"})
  (()-[:ENTITYGROUP_ARTIST]->()<-[:ENTITYGROUP_ARTIST]-()){0,1}
  ()-[:TRACK]-(track)
RETURN track