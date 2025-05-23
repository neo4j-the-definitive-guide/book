MATCH (a:Artist)<-[:ARTIST]-(t)
WHERE t.duration > 2000000
RETURN COUNT(a) AS artistCount
UNION
MATCH (a:Artist)<-[:ARTIST]-(t)
WHERE COUNT { (t)-[:ON_PLAYLIST]->(:Playlist) } > 500
RETURN COUNT(a) as artistCount