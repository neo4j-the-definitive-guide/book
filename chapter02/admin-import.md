```bash
./bin/neo4j-admin database import full book \ 
  --nodes=:Track=import/full/track_headers.csv,import/full/track.csv \
  --nodes=:Playlist=import/full/playlist_headers.csv,import/full/playlist.csv \
  --nodes=:Artist=import/full/artist_headers.csv,import/full/artist.csv \
  --nodes=:Album=import/full/album_headers.csv,import/full/album.csv \
  --relationships=ARTIST=import/full/track_artist_headers.csv,import/full/track_artist.csv \
  --relationships=HAS_TRACK=import/full/track_playlist_headers.csv,import/full/track_playlist.csv \
  --relationships=HAS_TRACK=import/full/track_album_headers.csv,import/full/track_album.csv \
  --skip-duplicate-nodes --multiline-fields=true --verbose
```