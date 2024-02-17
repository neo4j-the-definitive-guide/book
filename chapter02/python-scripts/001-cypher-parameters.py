from neo4j import GraphDatabase
from neo4j import Result

URI = 'bolt://localhost:7687'
AUTH = ('neo4j', 'password')


query = '''
    CREATE (track:Track {id: $id}) 
    SET track.name = $name
    RETURN track
    '''

def create_track(driver, parameters):
    record = driver.execute_query(
        query, 
        parameters, 
        database_='testload', 
        result_transformer_=Result.single
        )
    return record['track']['name']

with GraphDatabase.driver(URI, auth=AUTH) as driver:
    t1 = create_track(driver, {'id': 'track-01', 'name': 'Sin City'})
    t2 = create_track(driver, {'id': 'track-02', 'name': 'Creep'})
    print(t1)
    print(t2)