CREATE INDEX playlist_id FOR (n:Playlist) ON n.id;
CREATE INDEX user_id FOR (n:User) ON n.id;
CREATE INDEX track_id FOR (n:Track) ON n.id;
CREATE INDEX album_id FOR (n:Album) ON n.id;
CREATE INDEX artist_id FOR (n:Artist) ON n.id;