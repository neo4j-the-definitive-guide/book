PROFILE
MATCH (t:Track {name:"Tonight"})-[:ARTIST]->(a:Artist)
RETURN a.name