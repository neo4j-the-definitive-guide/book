MATCH (t:Track {id: "0kish3Tobj6Wq0we74343q"})<-[:HAS_TRACK]-(n)
RETURN n.name, labels(n)