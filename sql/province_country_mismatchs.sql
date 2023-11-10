SET CLIENT_ENCODING TO UTF8;
SET STANDARD_CONFORMING_STRINGS TO ON;
SET client_min_messages TO WARNING;

BEGIN;
ALTER TABLE ne_countries ALTER COLUMN "name" TYPE text;

UPDATE ne_provinces SET code_hasc = REPLACE(code_hasc, '.', '-');
UPDATE ne_countries SET name = name_long;

-- Add Baikonur to Qyzylorda
UPDATE ne_provinces SET geom = (
    SELECT ST_Multi(ST_Union(t.g)) FROM (
        SELECT geom AS g FROM ne_provinces WHERE name = 'Qyzylorda'
        UNION SELECT ST_Buffer(geom, 0.5) as g FROM ne_provinces WHERE name = 'Baykonur lease in Qyzylorda'
    ) AS t
) WHERE name = 'Qyzylorda';
DELETE FROM ne_provinces WHERE name = 'Baykonur lease in Qyzylorda';

DELETE
    FROM ne_provinces
    WHERE name IN (
        'Paphos',
        'Limassol',
        'Larnaca',
        'Nicosia',
        'Northern Cyprus',
        'Famagusta',
        'Dhekelia',
        'Akrotiri'
    );

INSERT INTO ne_countries (
    gid,
    admin,
    name,
    iso_a2,
    iso_a3,
    subregion,
    region_un
) VALUES (
    100000,
    'Tokelau',
    'Tokelau',
    'TK',
    'TKL',
    'Australia and New Zealand',
    'Oceania'
);

UPDATE ne_provinces SET iso_a2 = 'SJ' WHERE name = 'Svalbard';
INSERT INTO ne_countries (
    gid,
    admin,
    name,
    iso_a2,
    iso_a3,
    subregion,
    region_un
) VALUES (
    100001,
    'Svalbard and Jan Mayen',
    'Svalbard and Jan Mayen',
    'SJ',
    'SJM',
    'Northern Europe',
    'Europe'
);

UPDATE ne_provinces SET iso_a2 = 'BV' WHERE name = 'Bouvet Island';
INSERT INTO ne_countries (
    gid,
    admin,
    name,
    iso_a2,
    iso_a3,
    subregion,
    region_un
) VALUES (
    100002,
    'Bouvet Island',
    'Bouvet Island',
    'BV',
    'BVT',
    'Northern Europe',
    'Europe'
);

UPDATE ne_provinces SET iso_a2 = 'BQ' WHERE name IN ('Bonaire', 'St. Eustatius', 'Saba');
INSERT INTO ne_countries (
    gid,
    admin,
    name,
    iso_a2,
    iso_a3,
    subregion,
    region_un
) VALUES (
    100003,
    'Bonaire, Saint Eustatius and Saba',
    'Bonaire, Saint Eustatius and Saba',
    'BQ',
    'BES',
    'Caribbean',
    'Americas'
);

UPDATE ne_provinces SET iso_a2 = 'GP' WHERE name = 'Guadeloupe';
INSERT INTO ne_countries (
    gid,
    admin,
    name,
    iso_a2,
    iso_a3,
    subregion,
    region_un
) VALUES (
    100004,
    'Guadeloupe',
    'Guadeloupe',
    'GP',
    'GLP',
    'Caribbean',
    'Americas'
);

UPDATE ne_provinces SET iso_a2 = 'RE' WHERE name = 'La Réunion';
INSERT INTO ne_countries (
    gid,
    admin,
    name,
    iso_a2,
    iso_a3,
    subregion,
    region_un
) VALUES (
    100005,
    'Réunion',
    'Réunion',
    'RE',
    'REU',
    'Eastern Africa',
    'Africa'
);

UPDATE ne_provinces SET iso_a2 = 'MQ' WHERE name = 'Martinique';
INSERT INTO ne_countries (
    gid,
    admin,
    name,
    iso_a2,
    iso_a3,
    subregion,
    region_un
) VALUES (
    100006,
    'Martinique',
    'Martinique',
    'MQ',
    'MTQ',
    'Caribbean',
    'Americas'
);

UPDATE ne_provinces SET iso_a2 = 'YT' WHERE name = 'Mayotte';
INSERT INTO ne_countries (
    gid,
    admin,
    name,
    iso_a2,
    iso_a3,
    subregion,
    region_un
) VALUES (
    100007,
    'Mayotte',
    'Mayotte',
    'YT',
    'MYT',
    'Eastern Africa',
    'Africa'
);

UPDATE ne_provinces SET iso_a2 = 'GF' WHERE name = 'Guyane française';
INSERT INTO ne_countries (
    gid,
    admin,
    name,
    iso_a2,
    iso_a3,
    subregion,
    region_un
) VALUES (
    100008,
    'French Guiana',
    'French Guiana',
    'GF',
    'GUF',
    'South America',
    'Americas'
);

-- INSERT INTO ne_countries (
--     gid,
--     admin,
--     name,
--     iso_a2,
--     iso_a3,
--     subregion,
--     region_un
-- ) VALUES (
--     100009,
--     'Macau',
--     'Macau',
--     'MO',
--     'MAC',
--     'Eastern Asia',
--     'Asia'
-- );

-- Australia
UPDATE ne_provinces SET iso_a2 = 'CC' WHERE name = 'Cocos (Keeling) Islands';
INSERT INTO ne_countries (
    gid,
    admin,
    name,
    iso_a2,
    iso_a3,
    subregion,
    region_un
) VALUES (
    100010,
    'Cocos (Keeling) Islands',
    'Cocos (Keeling) Islands',
    'CC',
    'CCK',
    'Australia and New Zealand',
    'Oceania'
);

SELECT SingleProvince('Christmas Island');
UPDATE ne_provinces SET iso_a2 = 'CX' WHERE name = 'Christmas Island';
INSERT INTO ne_countries (
    gid,
    admin,
    name,
    iso_a2,
    iso_a3,
    subregion,
    region_un
) VALUES (
    100011,
    'Christmas Island',
    'Christmas Island',
    'CX',
    'CXR',
    'Australia and New Zealand',
    'Oceania'
);

SELECT SingleProvince('Coral Sea Islands');
UPDATE ne_provinces SET iso_a2 = 'XC' WHERE name = 'Coral Sea Islands';
UPDATE ne_countries SET iso_a2 = 'XC' WHERE name = 'Coral Sea Islands';

SELECT SingleProvince('Clipperton Island');
UPDATE ne_provinces SET iso_a2 = 'XP' WHERE name = 'Clipperton Island';
UPDATE ne_countries SET iso_a2 = 'XP' WHERE name = 'Clipperton Island';

SELECT SingleProvince('Guantanamo Bay USNB');
UPDATE ne_provinces SET iso_a2 = 'XU', name = 'US Naval Base Guantanamo Bay' WHERE name = 'Guantanamo Bay USNB';
UPDATE ne_countries SET iso_a2 = 'XU' WHERE name = 'US Naval Base Guantanamo Bay';

UPDATE ne_provinces SET admin = 'Australia' WHERE name IN (
    'Jervis Bay Territory'
    'Norfolk Island',
    'Christmas Island',
    'Cocos (Keeling) Islands',
    'Coral Sea Islands',
    'Ashmore and Cartier Islands',
    'Heard Island and McDonald Islands'
);

-- No ISO A2 code for somaliland, but we use this to link countries and provinces
-- We will delete it later
UPDATE ne_provinces SET iso_a2 = 'XS' WHERE name = 'Somaliland';
UPDATE ne_countries SET iso_a2 = 'XS' WHERE name = 'Somaliland';

-- No ISO A2 code for somaliland, but we use this to link countries and provinces
-- We will delete it later
UPDATE ne_provinces SET iso_a2 = 'XG', name = 'Siachen Glacier' WHERE admin = 'Siachen Glacier';
UPDATE ne_countries SET iso_a2 = 'XG' WHERE name = 'Siachen Glacier';

-- Not a country, but we keep it separate
UPDATE ne_provinces SET iso_a2 = 'XZ' WHERE name = 'Spratly Islands';
UPDATE ne_countries SET iso_a2 = 'XZ' WHERE name = 'Spratly Islands';

UPDATE ne_provinces SET iso_a2 = 'XA', name = 'Australia, Ashmore and Cartier Islands' WHERE name = 'Ashmore and Cartier Islands';
UPDATE ne_countries SET iso_a2 = 'XA', name = 'Australia, Ashmore and Cartier Islands' WHERE name = 'Ashmore and Cartier Islands';

-- Set to "CN-TW" in source data
UPDATE ne_countries SET iso_a2 = 'TW' WHERE name = 'Taiwan';

-- https://en.wikipedia.org/wiki/Macquarie_Island is listed separately, add to Tasmania
SELECT SingleProvince('Tasmania');
SELECT SingleProvince('Macquarie Island');
SELECT MergeProvinces('Tasmania', 'Macquarie Island');

-- https://en.wikipedia.org/wiki/Lord_Howe_Island is listed separately, add to New South Wales
SELECT SingleProvince('New South Wales');
SELECT SingleProvince('Lord Howe Island');
SELECT MergeProvinces('New South Wales', 'Lord Howe Island');

COMMIT;
