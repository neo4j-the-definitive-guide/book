//Stage 3
//Step 2
:auto
MATCH ()-[r:TRACK_ITEM_TEMP]-()
CALL(r) {
  DELETE r
}
IN TRANSACTIONS