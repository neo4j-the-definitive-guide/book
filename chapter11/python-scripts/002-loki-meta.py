from neo4j import GraphDatabase
from neo4j import unit_of_work

URI = 'bolt://localhost:7687'
AUTH = ('neo4j', 'password')


@unit_of_work(timeout=5, metadata={"app": "electric_harmony", "type": "user-direct"})
def search_playlist(tx):
    result = tx.run(
        """
        MATCH (n:Track) 
        WHERE toLower(n.name) CONTAINS $name 
        RETURN n.name AS name
        LIMIT 1""", 
        {'name': 'thunder'}
        )
    record = result.single()
    return record["name"]

with GraphDatabase.driver(URI, auth=AUTH) as driver:
    with driver.session(database="neo4j") as session:
        playlist_match = session.execute_read(search_playlist)
        print(playlist_match)