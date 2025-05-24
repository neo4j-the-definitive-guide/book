# Chapter 8: Setting Up the Database

**WARNING:** Chapter 8 uses two databases. 
You'll start with the large dataset for the sections on subqueries and fine-grained relationship types. 
Before you move on to Modeling resolved entities, you'll need to switch databases (see [the section below](https://github.com/neo4j-the-definitive-guide/book/blob/main/chapter08/README.md#modeling-resolved-entities)).

To get started with this chapter, you need to import the dataset into a fresh Neo4j database. You can either:

### Option 1: Use the Admin Import from Chapter 2
Reimport the full dataset into a new database by following the admin import instructions provided in Chapter 2.

### Option 2: Restore from a Backup
Alternatively, you can download and restore a prebuilt Neo4j backup:

#### Step 1: Download the Backup
```bash
wget https://downloads.graphaware.com/neo4j-the-definitive-guide/neo4j-tdg-backup-20250523.backup
```

#### Step 2: Restore the Backup

If you're running Neo4j without Docker, use the following procedure

Replace `<path/to/downloads/directory>` with the actual path where you downloaded the backup:
```bash
./bin/neo4j-admin database restore --from-path=<path/to/downloads/directory>/neo4j-tdg-backup-20250523.backup chapter8
```

If you're using the Docker compose provided with this repository, use the following procedure : 

1. Move the backup file into the `docker/import` folder of this repository
2. Run the following command : 

```bash
docker exec -it -u neo4j neo4j-tdg ./bin/neo4j-admin database restore --from-path=/import/neo4j-tdg-backup-20250523.backup chapter8
```

#### Step 3: Create the Database in Neo4j
After restoring the backup, create the `chapter8` database using the Neo4j Browser or Cypher shell:
```cypher
CREATE DATABASE chapter8
```
And switch to the database

```cypher
:use chapter8
```

You are now ready to begin Chapter 8.

## Modeling Resolved Entities

This section requires a different database. Follow these steps:

#### Step 1: Download the Backup
```bash
wget https://downloads.graphaware.com/neo4j-the-definitive-guide/neo4j-tdg-fused.backup
```

#### Step 2: Restore the Backup

If you're running Neo4j without Docker, use the following procedure

Replace `<path/to/downloads/directory>` with the actual path where you downloaded the backup:
```bash
./bin/neo4j-admin database restore --from-path=<path/to/downloads/directory>/neo4j-tdg-backup-20250523.backup fused
```

If you're using the Docker compose provided with this repository, use the following procedure :

1. Move the backup file into the `docker/import` folder of this repository
2. Run the following command :

```bash
docker exec -it -u neo4j neo4j-tdg ./bin/neo4j-admin database restore --from-path=/import/neo4j-tdg-backup-20250523.backup fused
```

#### Step 3: Create the Database in Neo4j
After restoring the backup, create the `fused` database using the Neo4j Browser or Cypher shell:
```cypher
CREATE DATABASE fused
```

Now switch to the database

```cypher
:use fused
```

