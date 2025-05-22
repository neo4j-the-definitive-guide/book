LOAD CSV WITH HEADERS FROM "file:///genres.csv" AS row
WITH row
WITH row.Artist as artist, split(row.Genre,"/") AS genreList
UNWIND genreList AS genre
WITH artist, collect(trim(toLower(genre))) AS genres
MATCH (a:Artist {name:artist})
SET a.genres=genres