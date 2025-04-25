
```bash
./bin/neo4j-admin database import full book \
  --nodes=:Track=import/full/track_cleaned_headers.csv,import/full/track_cleaned.csv \
  --nodes=:Playlist=import/full/playlist_cleaned_headers.csv,import/full/playlist_cleaned.csv \
  --nodes=:Artist=import/full/artist_cleaned_headers.csv,import/full/artist_cleaned.csv \
  --nodes=:Album=import/full/album_headers.csv,import/full/album_cleaned.csv \
  --relationships=ARTIST=import/full/track_artist_headers.csv,import/full/track_artist_cleaned.csv \
  --relationships=HAS_TRACK=import/full/track_playlist_headers.csv,import/full/track_playlist_cleaned.csv \
  --relationships=HAS_TRACK=import/full/album_track_headers.csv,import/full/track_album.csv \
  --skip-duplicate-nodes \
  --multiline-fields=true \
  --skip-bad-relationships=true \
  --overwrite-destination=true \
  --verbose
```