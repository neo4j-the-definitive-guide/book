PROFILE
MATCH (n:Playlist)
  WHERE n.followers > 5000 AND n.name STARTS WITH "Sound"
RETURN n