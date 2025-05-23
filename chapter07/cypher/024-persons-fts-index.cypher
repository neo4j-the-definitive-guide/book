CREATE FULLTEXT INDEX test
FOR (n:Person)
ON EACH [n.email]
OPTIONS {
  indexConfig: {
    `fulltext.analyzer`: 'stop',
    `fulltext.eventually_consistent`: false
  }
}