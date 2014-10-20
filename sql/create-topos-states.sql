SET CLIENT_ENCODING TO UTF8;
SET STANDARD_CONFORMING_STRINGS TO ON;
SET client_min_messages TO WARNING;
BEGIN;
SELECT AddTopoGeometry(name, 'ne_states', gid) FROM ne_states ORDER BY name;
COMMIT;
