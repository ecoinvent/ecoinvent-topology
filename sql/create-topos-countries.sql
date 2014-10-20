SET CLIENT_ENCODING TO UTF8;
SET STANDARD_CONFORMING_STRINGS TO ON;
SET client_min_messages TO WARNING;
BEGIN;
SELECT AddTopoGeometry(name, 'ne_countries', gid) FROM ne_countries ORDER BY name;
COMMIT;
