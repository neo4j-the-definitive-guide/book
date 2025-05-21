from neo4j import GraphDatabase
from openai import OpenAI
import json
import os
from typing import List
from dotenv import load_dotenv

load_dotenv()

# Setup environment or use dotenv
NEO4J_URI = os.getenv("NEO4J_URI", "bolt://localhost:7687")
NEO4J_USER = os.getenv("NEO4J_USER", "neo4j")
NEO4J_PASSWORD = os.getenv("NEO4J_PASSWORD", "password")
NEO4J_DATABASE=os.getenv("NEO4J_DATABASE", "book")
OPENAI_API_KEY = os.getenv("OPENAI_API_KEY")

# Initialize clients
neo4j_driver = GraphDatabase.driver(NEO4J_URI, auth=(NEO4J_USER, NEO4J_PASSWORD))
openai = OpenAI(api_key=OPENAI_API_KEY)

# Define query to fetch data from Neo4j
READ_QUERY = """
MATCH (c:Community)-[:HAS_PLAYLIST]->(p)
WHERE c.id = $id
MATCH (p)-[:HAS_TRACK]->(t)-[:ARTIST]->(a)
RETURN t.name AS track, a.name AS artist
ORDER BY rand()
LIMIT 50
"""

PROMPT_TEMPLATE = """
You will be given a sample of 100 songs belonging to similar playlists. For each song, you have the track name and artist name.
Your task is to generate a comprehensive summary for the community of playlists. Additionally, generate 5 hypothetical search 
phrases a listener could type in order to find such playlists, for example if the summary contains "Influential rock a billy", 
then a question could by "I'm looking for rockabilly themed playlists"
**You must return the data in the following JSON format**:
{{
  "questions": ["question1", "question2", ...],
  "summary": "text"
}}

Tracks:
{text}
"""


def get_community_sample_tracks(community_id: int):
    records = neo4j_driver.execute_query(READ_QUERY, {'id': community_id}, database_=NEO4J_DATABASE).records
    tracks = []
    for r in records:
        tracks.append({'track': r.get('track'), 'artist': r.get('artist')})
    return tracks

def store_community_summary(communityId: int, summary: str):
    query = 'MATCH (n:Community {id: $id}) SET n.summary = $summary'
    params = {'id': communityId, 'summary': summary}
    neo4j_driver.execute_query(query, params, database_=NEO4J_DATABASE)

def store_community_embedding(communityId: int, embedding: List[float]):
    query = '''
    MATCH (n:Community {id: $id})
    CALL db.create.setNodeVectorProperty(n, 'summaryEmbedding', $embedding)
    '''
    params = {'id': communityId, 'embedding': embedding}
    neo4j_driver.execute_query(query, params, database_=NEO4J_DATABASE)

def store_question_with_embedding(communityId: int, question: str, embedding: List[float]):
    query = '''
    MATCH (n:Community {id: $id})
    CREATE (q:Question {id: randomUuid()})
    SET q.text = $question
    MERGE (n)-[:QUESTION]->(q)
    WITH q
    CALL db.create.setNodeVectorProperty(q, 'embedding', $embedding)
    '''
    params = {'id': communityId, 'question': question, 'embedding': embedding}
    neo4j_driver.execute_query(query, params, database_=NEO4J_DATABASE)

def get_chat_completion(text: str) -> dict:
    prompt = {
        "role": "user",
        "content": text
    }

    response = openai.chat.completions.create(
        model="gpt-4.1-mini",
        messages=[prompt],
        temperature=0
    )
    response_text = response.choices[0].message.content.strip()
    if not response_text.startswith('{'):
        raise ValueError("Expected JSON, got: " + response_text[:100])
    return json.loads(response_text)

def embed_text(text: str) -> List[float]:
    response = openai.embeddings.create(
        model="text-embedding-3-small",
        input=text
    )
    return response.data[0].embedding

def main():
    community_id = 44386
    community_sample = get_community_sample_tracks(community_id)
    tracks_str = []
    for track in community_sample:
        tracks_str.append('Track: %s - Artist: %s' % (track['track'], track['artist']))
    tracks = '\n'.join(tracks_str)
    prompt = PROMPT_TEMPLATE.format(text=tracks)
    try:
        result = get_chat_completion(prompt)
        summary = result['summary']
        questions = result['questions']

        store_community_summary(community_id, summary)

        # embed summary
        summary_vector = embed_text(summary)
        store_community_embedding(community_id, summary_vector)

        # embed and store the questions
        for question in questions:
            vector = embed_text(question)
            store_question_with_embedding(community_id, question, vector)

    except Exception as e:
        print(f"Error processing community {community_id}: {e}")

if __name__ == "__main__":
    main()