# AI community recommendation

Follow these instructions to run the example scripts.

**Create a virtual environment in this directory**

```bash
python3 -m venv .venv
```

**Activate the virtual environment**

```bash
source .venv/bin/activate
```

Or if using fish shell

```bash
source .venv/bin/activate.fish
```

**Install the Neo4j driver dependencies**

```bash
pip install -r requirements.txt
```

**Setup your variables**

Create a `.env` file and adjust the values

```
NEO4J_URI=bolt://localhost:7687
NEO4J_USER=neo4j
NEO4J_PASSWORD=password
NEO4J_DATABASE=book
OPENAI_API_KEY=xxxxxx
```

**Create the Neo4j Vector Indexes**

Run the following commands in your Neo4j database

```cypher
CREATE VECTOR INDEX communitySummary
FOR (n:Community)
ON n.summaryEmbedding
OPTIONS {
    indexConfig: {
        `vector.dimensions`: 1536
    }
}
```

```cypher
CREATE VECTOR INDEX question
FOR (n:Question)
ON n.embedding
OPTIONS {
    indexConfig: {
        `vector.dimensions`: 1536
    }
}
```

**Run the scripts**

```bash
python 01-community-summaries.py
```

```bash
python 02-playlist-recommendation.py
```

