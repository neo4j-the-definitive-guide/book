UNWIND range(1,100) AS i
CREATE (n:Test {text: "this is a sample in a longer text " + i});