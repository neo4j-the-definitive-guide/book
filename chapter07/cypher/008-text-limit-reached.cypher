CREATE (t:Track {id: "test_id_large"})
SET t.name = apoc.text.repeat('hello', 10_000)