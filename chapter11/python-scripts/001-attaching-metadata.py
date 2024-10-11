from neo4j import GraphDatabase
from neo4j import unit_of_work

URI = 'bolt://localhost:7687'
AUTH = ('neo4j', 'password')


@unit_of_work(timeout=5, metadata={"app": "electric_harmony", "type": "system"})
def count_playlists(tx):
    result = tx.run("MATCH (n:Playlist) RETURN count(n) AS count")
    record = result.single()
    return record["count"]

with GraphDatabase.driver(URI, auth=AUTH) as driver:
    with driver.session(database="neo4j") as session:
        playlists_count = session.execute_read(count_playlists)
        print(playlists_count)