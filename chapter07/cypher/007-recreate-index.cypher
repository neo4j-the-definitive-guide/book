DROP INDEX track_name;
CREATE TEXT INDEX track_name FOR (n:Track) ON n.name;