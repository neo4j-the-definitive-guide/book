MATCH (n:Playlist)
  WHERE n.followers = 5574 AND n.name STARTS WITH "Sound"
RETURN n