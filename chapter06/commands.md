# Commands for Chapter 6

**Set initial Neo4j password**

```bash
neo4j-admin dbms set-initial-password be4Hw%qi9 –-require-password-change
```

**Create user accounts**

```cypher
CREATE USER reco
SET PASSWORD 'password' CHANGE NOT REQUIRED;

CREATE USER paul
SET PASSWORD 'password';

CREATE USER john
SET PASSWORD 'password';

CREATE USER angus
SET PASSWORD 'password';
```

**Create roles**

```cypher
CREATE ROLE content_manager;
CREATE ROLE data_scientist;
CREATE ROLE reco_app;
```

**Grant roles to users**

```cypher
GRANT ROLE reco_app TO reco;
GRANT ROLE content_manager TO angus;
GRANT ROLE data_scientist TO paul, john;
```

**Grant privileges**

```cypher
GRANT MATCH {*} ON GRAPH neo4j NODES Album, Artist, Track, Playlist TO reco_app;
GRANT MATCH {*} ON GRAPH neo4j RELATIONSHIPS * TO reco_app;
```

```cypher
GRANT MATCH {*} ON GRAPH neo4j NODES Album,Artist,Track TO content_manager;
GRANT MATCH {*} ON GRAPH neo4j RELATIONSHIPS HAS_TRACK,ARTIST TO content_manager;
GRANT MATCH {*} ON GRAPH neo4j NODES Album,Artist,Track,Playlist TO data_scientist;
GRANT MATCH {*} ON GRAPH neo4j RELATIONSHIPS HAS_TRACK,ARTIST,ON_PLAYLIST,SIMILAR TO data_scientist;
GRANT MERGE {*} ON GRAPH neo4j RELATIONSHIP SIMILAR TO data_scientist;
```

**Set similarity property**

```cypher
MATCH (a:Playlist)-[r:SIMILAR]-(b:Playlist)
WHERE id(a) < id(b)
CALL (r) {
    SET r.similar_liveness=1
} IN TRANSACTIONS
```

**Create property**

```cypher
CALL db.createProperty('similar_liveness');
```

**Grant create properties privilege**

```cypher
GRANT CREATE NEW PROPERTY NAME ON DATABASE neo4j TO data_scientist;
```

**LOAD CSV privilege**

```cypher
GRANT LOAD ON ALL DATA TO dataloaders;
```

**CIDR restriction**

```cypher
DENY LOAD ON CIDR "127.0.0.1/32" TO dataloaders;
```

**Prevent procedures usage**

```cypher
DENY EXECUTE PROCEDURE db.* ON DBMS TO PUBLIC
```

**Deny with immutable**

```cypher
DENY IMMUTABLE EXECUTE PROCEDURE db.* ON DBMS TO PUBLIC
```