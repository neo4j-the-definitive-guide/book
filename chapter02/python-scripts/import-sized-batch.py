import csv
from neo4j import GraphDatabase

URI = 'bolt://localhost:7687'
AUTH = ('neo4j', 'password')
driver = GraphDatabase.driver(URI, auth=AUTH)

query = '''
    UNWIND $trackInfos AS trackInfo
    CREATE (track:Track {id: trackInfo.id}) 
    SET track.name = trackInfo.name
    '''

BATCH_SIZE = 10_000
current_batch = []

def commit_batch(current_batch):
    records, _, _ = driver.execute_query(
        query,
        trackInfos=current_batch,
        database_='testload'
    )
    # reset current_batch to empty list
    current_batch.clear()

def process_row(row, current_batch):
    current_batch.append(row)
    if len(current_batch) >= BATCH_SIZE:
        commit_batch(current_batch)

with open('./files/sample_tracks_medium.csv', 'r') as file:
    reader = csv.DictReader(file)
    for row in reader:
        process_row(row, current_batch)
    else:
        commit_batch(current_batch)