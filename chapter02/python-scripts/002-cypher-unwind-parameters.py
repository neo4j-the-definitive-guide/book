from neo4j import GraphDatabase

URI = 'bolt://localhost:7687'
AUTH = ('neo4j', 'password')

query = '''
    UNWIND $trackInfos AS trackInfo
    CREATE (track:Track {id: trackInfo.id}) 
    SET track.name = trackInfo.name
    RETURN track
    '''

def create_tracks(driver, tracks):
    records, _, _ = driver.execute_query(
        query, 
        trackInfos=tracks, 
        database_='testload'
        )
    for record in records:
        print(record['track']['name'])

with GraphDatabase.driver(URI, auth=AUTH) as driver:
    all_tracks = []
    all_tracks.append({'id': 'track-01', 'name': 'Sin City'})
    all_tracks.append({'id': 'track-02', 'name': 'Creep'})

    create_tracks(driver, all_tracks)