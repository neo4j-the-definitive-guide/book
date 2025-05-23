// Switch back to the book db before running this query
CALL {
    CALL db.index.fulltext.queryNodes('Track', '#highwayToHell')
    YIELD node
    RETURN node AS track

    UNION DISTINCT
    // DISTINCT ensures the same node
    // found by the two queries will be returned
    // only once

    MATCH (n:Track)
    WHERE n.name CONTAINS '#highwayToHell'
    RETURN n AS track
}
RETURN track
