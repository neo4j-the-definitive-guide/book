MATCH (n {id:"0eLgWXRdFvQWb5Ch6Hm33Z"})-[:HAS_TRACK]->(t:Track)
        -[:ARTIST]->(a:Artist) //this n matches an album
RETURN t.name AS trackName, a.name AS artistName