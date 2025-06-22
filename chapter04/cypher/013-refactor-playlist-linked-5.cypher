//Stage 4
:auto
MATCH ()-[r:ON_PLAYLIST]-()
CALL(r) {
  DELETE r
}
IN TRANSACTIONS