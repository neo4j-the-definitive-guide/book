CREATE CONSTRAINT has_track_position_integer
FOR ()-[r:HAS_TRACK]-()
REQUIRE r.position IS TYPED INTEGER