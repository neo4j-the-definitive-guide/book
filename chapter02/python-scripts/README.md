# Running the python scripts

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

**Run the python scripts when needed**

Example : 

```bash
python 001-cypher-parameters.py
```

