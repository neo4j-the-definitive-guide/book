MATCH (t1:Track {id: "7ysmJhXFQtiBQlk6EZ6sks"})
MATCH (t2:Track {id:"7N2UmTJG5Uv6zQvjf4eIjd"})
MATCH path = SHORTEST 5 (t1)-[r:HAS_TRACK]-+(t2)
RETURN path
