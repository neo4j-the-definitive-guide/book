USE composed.songs
MATCH (t:Track {name: "Patience"})
MATCH p=(t)-->(a:Artist)<--(t2)
RETURN p
