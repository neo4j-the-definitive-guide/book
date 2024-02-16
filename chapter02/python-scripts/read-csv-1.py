import csv
from neo4j import GraphDatabase

URI = 'bolt://localhost:7687'
AUTH = ('neo4j', 'password')

all_rows = []

with open('./files/sample_tracks_medium.csv', 'r') as file:
    reader = csv.DictReader(file)
    # accumulate all rows of the file 
    # into the all_rows variable
    for row in reader:
        all_rows.append(row)

query = '''
    UNWIND $trackInfos AS trackInfo
    CREATE (track:Track {id: trackInfo.id}) 
    SET track.name = trackInfo.name
    '''

with GraphDatabase.driver(URI, auth=AUTH) as driver:
    records, _, _ = driver.execute_query(
        query,
        trackInfos=all_rows,
        database_='testload'
    )