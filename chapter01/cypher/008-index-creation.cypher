// The NODE KEY constraint ensures the id property is present and unique
CREATE CONSTRAINT playlist_id FOR (n:Playlist) REQUIRE n.id IS NODE KEY;
CREATE CONSTRAINT user_id FOR (n:User) REQUIRE n.id IS NODE KEY;
CREATE CONSTRAINT track_id FOR (n:Track) REQUIRE n.id IS NODE KEY;
CREATE CONSTRAINT album_id FOR (n:Album) REQUIRE n.id IS NODE KEY;
CREATE CONSTRAINT artist_id FOR (n:Artist) REQUIRE n.id IS NODE KEY;