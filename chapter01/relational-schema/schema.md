Use DBML to define your database structure
Docs: https://dbml.dbdiagram.io/docs

```
Table Track {
 id integer [primary key]
 name varchar
 duration int
 popularity double
 explicit varchar
 preview_url varchar
 uri varchar
 album_id varchar
}

Table Album {
 id integer [primary key]
 name varchar
}

Table Artist {
 id varchar [primary key]
 uri varchar
 name varchar
}

Table Track_Artist {
 track_id integer
 artist_id integer
}

Table Playlist {
    id varchar [primary key]
    name varchar
    followers int
    uri varchar
    total_tracks int
}

Table Playlist_Track {
    track_id varchar
    playlist_id varchar
}


Ref: Track_Artist.track_id > Track.id 

Ref: Track_Artist.artist_id > Artist.id 

Ref: Track.album_id > Album.id 

Ref: Playlist_Track.track_id > Track.id

Ref: Playlist_Track.playlist_id > Playlist.id
```