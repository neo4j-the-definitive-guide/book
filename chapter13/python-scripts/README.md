# AI community recommendation

Create `.env` file

NEO4J_URI=bolt://localhost:7687
NEO4J_USER=neo4j
NEO4J_PASSWORD=password
NEO4J_DATABASE=book
OPENAI_API_KEY=xxxxxx

```
CREATE VECTOR INDEX communitySummary
FOR (n:Community)
ON n.summaryEmbedding
OPTIONS {
    indexConfig: {
        `vector.dimensions`: 1536
    }
}
```

```
CREATE VECTOR INDEX question
FOR (n:Question)
ON n.embedding
OPTIONS {
    indexConfig: {
        `vector.dimensions`: 1536
    }
}
```


Communities tried

44386
49641

