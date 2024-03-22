//001-double-traversal.cypher
MATCH path=(track1:Track {id:"0BB9eUBBaaX6GALSYNcEp7"})-[*3]-(track2:Track {id:"2KmEgiY8fQs0G6WNxtzQKr"})
RETURN path