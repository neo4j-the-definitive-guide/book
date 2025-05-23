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

neo4j_driver = GraphDatabase.driver(NEO4J_URI, auth=(NEO4J_USER, NEO4J_PASSWORD))
openai = OpenAI(api_key=OPENAI_API_KEY)


USER_QUESTION = """Recommend me a playlist of jazz music with a chic style."""

PROMPT = """
You will receive a summary of a community of playlists, some playlists and some sample tracks of them.
For each playlist, create a "here is a recommended playlist" answer to the user and explain why based on the songs.

Question : {user_question}

Data : {data}
"""

def embed_text(text: str) -> List[float]:
    response = openai.embeddings.create(
        model="text-embedding-3-small",
        input=text
    )
    return response.data[0].embedding

def find_similar(vector: List[float]) -> dict:
    query = """
    CALL () {
        CALL db.index.vector.queryNodes('communitySummary', 20, $vector)
        YIELD node, score
        WHERE score > 0.5
        WITH node AS community
        MATCH (community)-[:HAS_PLAYLIST]->(playlist)
        WITH community, playlist, COLLECT {
            MATCH (playlist)-[:HAS_TRACK]->(track)-[:ARTIST]->(artist)
            RETURN {track: track.name, artist: artist}
            ORDER BY rand()
            LIMIT 10
        } AS sampleTracks LIMIT 10
        RETURN community, playlist, sampleTracks

        UNION

        CALL db.index.vector.queryNodes('question', 20, $vector)
        YIELD node, score
        WHERE score > 0.5
        WITH node AS question
        MATCH (question)<-[:QUESTION]-(community)
        MATCH (community)-[:HAS_PLAYLIST]->(playlist)
        WITH community, playlist, COLLECT {
            MATCH (playlist)-[:HAS_TRACK]->(track)-[:ARTIST]->(artist)
            RETURN {track: track.name, artist: artist}
            ORDER BY rand()
            LIMIT 10
        } AS sampleTracks LIMIT 10
        RETURN community, playlist, sampleTracks
    }
    RETURN community.summary AS summary, collect({playlist: playlist.name, tracks: sampleTracks})
    """
    records = neo4j_driver.execute_query(query, {'vector': vector}, database_=NEO4J_DATABASE).records

    return records

def generate_response(text: str) -> dict:
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

    return response_text

def main():

    try:
        question_embedding = embed_text(USER_QUESTION)
        similar = str(find_similar(question_embedding))
        prompt = PROMPT.format(user_question=USER_QUESTION, data=similar)
        response = generate_response(prompt)
        print(response)


    except Exception as e:
        print(f"Error processing community {community_id}: {e}")

if __name__ == "__main__":
    main()