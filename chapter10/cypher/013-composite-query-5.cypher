CALL {
    USE composed.songs
    MATCH (t:Track {name: "Patience"})
    MATCH p=(t)-->(a:Artist)<--(t2)
    RETURN a, p
}
WITH a.id AS artistId, p
CALL(artistId) {
    USE composed.erfacts
    MATCH (a2:Artist {id: artistId})
    MATCH fp=(a2)--(f:Fact)
    RETURN fp
}
RETURN p, fp