MATCH (t1:Track {id: "7ysmJhXFQtiBQlk6EZ6sks"})
MATCH (t2:Track {id:"7N2UmTJG5Uv6zQvjf4eIjd"})
MATCH p = ((t1)-[*..5]-(t2))
RETURN p