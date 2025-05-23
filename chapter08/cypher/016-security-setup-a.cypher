CREATE ROLE marketing_europe IF NOT EXISTS;
CREATE ROLE sales_latam IF NOT EXISTS;
CREATE ROLE senior_customer_support IF NOT EXISTS;
CREATE ROLE junior_customer_support IF NOT EXISTS;
CREATE ROLE music_info IF NOT EXISTS;


CREATE USER alice IF NOT EXISTS SET PASSWORD 'password' CHANGE NOT REQUIRED;
CREATE USER bob IF NOT EXISTS SET PASSWORD 'password' CHANGE NOT REQUIRED;
CREATE USER charlie IF NOT EXISTS SET PASSWORD 'password' CHANGE NOT REQUIRED;
CREATE USER drew IF NOT EXISTS SET PASSWORD 'password' CHANGE NOT REQUIRED;


GRANT ROLE marketing_europe TO alice;
GRANT ROLE music_info TO alice;
GRANT ROLE sales_latam TO bob;
GRANT ROLE music_info TO bob;
GRANT ROLE senior_customer_support TO charlie;
GRANT ROLE music_info TO charlie;
GRANT ROLE junior_customer_support TO drew;
GRANT ROLE music_info TO drew;



GRANT ACCESS ON DATABASE electric_harmony TO music_info;


GRANT MATCH {*} ON GRAPH electric_harmony NODES Playlist, Track TO music_info;
GRANT MATCH {*} ON GRAPH electric_harmony RELATIONSHIPS * TO music_info;

GRANT MATCH {*} ON GRAPH electric_harmony NODES Europe TO marketing_europe;

GRANT MATCH {*} ON GRAPH electric_harmony FOR (n:CustomerLatam) 
WHERE n.subscriptionRenewal <= date('2025-04-01') TO sales_latam;

GRANT MATCH {*} 
ON GRAPH electric_harmony 
FOR (n:SupportRequest) 
WHERE n.securityLevel <= 3 TO junior_customer_support;

GRANT MATCH {*} 
ON GRAPH electric_harmony 
FOR (n:SupportRequest) 
WHERE n.securityLevel <= 4 
TO senior_customer_support;

CREATE CONSTRAINT customer_renewal_date_exist 
FOR (n:Customer) 
REQUIRE n.subscriptionRenewal IS NOT NULL;


CREATE CONSTRAINT support_request_security_level_exist
FOR (n:SupportRequest) 
REQUIRE n.securityLevel IS NOT NULL;