CREATE FULLTEXT INDEX Test FOR (n:Test) ON EACH [n.text];
CREATE (a:Test {text: "this is a sample"});
CREATE (b:Test {text: "this is a sample in a longer text"});