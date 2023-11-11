SET CLIENT_ENCODING TO UTF8;
SET STANDARD_CONFORMING_STRINGS TO ON;
SET client_min_messages TO WARNING;
UPDATE final SET isotwolettercode = NULL WHERE name in (
    'Somaliland', 'Siachen Glacier', 'Spratly Islands', 'Coral Sea Islands',
    'Clipperton Island', 'US Naval Base Guantanamo Bay',
    'Australia, Ashmore and Cartier Islands', 'Crimea'
);
UPDATE final SET isothreelettercode = NULL WHERE name in (
    'Somaliland', 'Siachen Glacier', 'Spratly Islands', 'Coral Sea Islands',
    'Clipperton Island', 'US Naval Base Guantanamo Bay',
    'Australia, Ashmore and Cartier Islands', 'Crimea'
);
BEGIN;
COMMIT;
