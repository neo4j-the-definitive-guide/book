# Commands from Chapter 11

**Content of server-logs.xml**

```bash
docker exec -it neo4j-tdg cat /var/lib/neo4j/conf/server-logs.xml
```

**Content of user-logs.xml**

```bash
docker exec -it neo4j-tdg cat /var/lib/neo4j/conf/user-logs.xml
```

**Show running Neo4j logs**

```bash
docker logs neo4j-tdg
```

**View content of the neo4j.log file**

```bash
docker exec -it neo4j-tdg cat /var/lib/neo4j/logs/neo4j.log
```

**View content of the security.log file**

```bash
docker exec -it neo4j-tdg tail -n 10 /var/lib/neo4j/logs/security.log
```

**Create observer role**

```cypher
CREATE ROLE observer;
GRANT ACCESS ON DATABASE neo4j TO observer;
```

**Inspect debug logs**

```bash
docker exec -it neo4j-tdg tail -n 0 -f /var/lib/neo4j/logs/debug.log
```

**Create observability database**

```cypher
CREATE DATABASE observability WAIT;
```

**Inspect query logs**

```bash
docker exec -it neo4j-tdg tail -n 3 logs/query.log
```

**Some Neo4j query**

```cypher
MATCH (n:Playlist) RETURN count(n);
```

**Find query above in the query logs**

```bash
docker exec -it neo4j-tdg cat /var/lib/neo4j/logs/query.log | grep 'MATCH (n:Playlist)'
```

**Find in query logs queries that took more than 5 seconds**

```bash
docker exec -it neo4j-tdg cat /var/lib/neo4j/logs/query.log | grep -E ' ([5-9][0-9]{3}|[1-9][0-9]{4,}) ms:'
```

**Inspect heap used metrics**

```bash
curl http://localhost:2004 | grep 'neo4j_dbms_vm_heap_used'
```

**Inspect GC metrics**

```bash
curl http://localhost:2004 | grep 'vm_gc_time'
```

**Inspect Pagecache metrics**

```bash
curl http://localhost:2004 | grep 'page_cache'
```

**Inspect bolt metrics**

```bash
curl http://localhost:2004 | grep 'connections_running'
```

**Inspect object count metrics**

```bash
curl -s http://localhost:2004 | grep 'count.node'
```

**Inspect latency metrics**

```bash
curl -s  http://localhost:2004 | grep 'execution_latency_millis' | grep 'neo4j_db'
```

**Start up observability stack**

```bash
docker compose -f docker-compose.yml -f docker-compose-observability.yml up -d
```

**Create some nodes**

```cypher
UNWIND range(1,5000) AS i CREATE (n:TestNode);
// wait a minute or two
MATCH (n:TestNode) WITH n LIMIT 1000 DELETE n;
```

**Loki query for all logs**

```
{job="neo4j", filename="/logs/query.log"} | json
```

**Loki query for filtering logs for neo4j db only**

```
{job="neo4j", filename="/logs/query.log"} | json | database="neo4j"
```

**Loki query for filtering logs for application**

```
{job="neo4j", filename="/logs/query.log"} | json | database="neo4j" | annotationData_app="electric_harmony"
```

**Loki query filtering by query time**

```
{job="neo4j", filename="/logs/query.log"} | json | database="neo4j" | elapsedTimeMs >= 3000
```

**Loki query combined**

```
{job="neo4j", filename="/logs/query.log"} | json | database="neo4j" | queryParameters =~ ".*thunder.*"
```

