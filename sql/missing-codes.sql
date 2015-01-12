SET CLIENT_ENCODING TO UTF8;
SET STANDARD_CONFORMING_STRINGS TO ON;
SET client_min_messages TO WARNING;

BEGIN;
UPDATE ne_countries SET iso_a2 = 'NO', iso_a3 = 'NOR' WHERE name = 'Norway';
UPDATE ne_countries SET iso_a2 = 'FR', iso_a3 = 'FRA' WHERE name = 'France';
UPDATE ne_countries SET iso_a2 = 'XK' WHERE name = 'Kosovo';
UPDATE ne_countries SET iso_a2 = NULL, iso_a3 = NULL WHERE iso_a2 = '-99';
COMMIT;
