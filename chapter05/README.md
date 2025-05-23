# Chapter 5: Setting Up the Database

To get started with this chapter, you need to import the dataset into a fresh Neo4j database. You can either:

### Option 1: Use the Admin Import from Chapter 3
Reimport the full dataset into a new database by following the admin import instructions provided in Chapter 3.

### Option 2: Restore from a Backup
Alternatively, you can download and restore a prebuilt Neo4j backup:

#### Step 1: Download the Backup
```bash
wget https://downloads.graphaware.com/neo4j-the-definitive-guide/neo4j-tdg-backup-20250523.backup
```

#### Step 2: Restore the Backup
Replace `<path/to/downloads/directory>` with the actual path where you downloaded the backup:
```bash
./bin/neo4j-admin database restore --from-path=<path/to/downloads/directory>/neo4j-tdg-backup-20250523.backup chapter5
```

#### Step 3: Create the Database in Neo4j
After restoring the backup, create the `chapter5` database using the Neo4j Browser or Cypher shell:
```cypher
CREATE DATABASE chapter5
```

You are now ready to begin Chapter 5.
