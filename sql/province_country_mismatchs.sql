SET CLIENT_ENCODING TO UTF8;
SET STANDARD_CONFORMING_STRINGS TO ON;
SET client_min_messages TO WARNING;

BEGIN;
ALTER TABLE ne_countries ALTER COLUMN "name" TYPE text;

-- Add Baikonur to Qyzylorda
UPDATE ne_provinces SET geom = (
    SELECT ST_Multi(ST_Union(t.g)) FROM (
        SELECT geom AS g FROM ne_provinces WHERE name = 'Qyzylorda'
        UNION SELECT ST_Buffer(geom, 0.5) as g FROM ne_provinces WHERE name = 'Baykonur lease in Qyzylorda'
    ) AS t
) WHERE name = 'Qyzylorda';
DELETE FROM ne_provinces WHERE name = 'Baykonur lease in Qyzylorda';

UPDATE ne_provinces SET iso_a2 = 'AU' WHERE name in ('Christmas Island', 'Cocos (Keeling) Islands');

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
    name,
    iso_a2,
    iso_a3,
    subregion,
    region_un
) VALUES (
    100000,
    'Tokelau',
    'TK',
    'TKL',
    'Australia and New Zealand',
    'Oceania'
);

UPDATE ne_provinces SET iso_a2 = 'SJ' WHERE name = 'Svalbard';
INSERT INTO ne_countries (
    gid,
    name,
    iso_a2,
    iso_a3,
    subregion,
    region_un
) VALUES (
    100001,
    'Svalbard and Jan Mayen',
    'SJ',
    'SJM',
    'Northern Europe',
    'Europe'
);

UPDATE ne_provinces SET iso_a2 = 'BV' WHERE name = 'Bouvet Island';
INSERT INTO ne_countries (
    gid,
    name,
    iso_a2,
    iso_a3,
    subregion,
    region_un
) VALUES (
    100002,
    'Bouvet Island',
    'BV',
    'BVT',
    'Northern Europe',
    'Europe'
);

UPDATE ne_provinces SET iso_a2 = 'BQ' WHERE name IN ('Bonaire', 'St. Eustatius', 'Saba');
INSERT INTO ne_countries (
    gid,
    name,
    iso_a2,
    iso_a3,
    subregion,
    region_un
) VALUES (
    100003,
    'Bonaire, Saint Eustatius and Saba',
    'BQ',
    'BES',
    'Caribbean',
    'Americas'
);

UPDATE ne_provinces SET iso_a2 = 'GP' WHERE name = 'Guadeloupe';
INSERT INTO ne_countries (
    gid,
    name,
    iso_a2,
    iso_a3,
    subregion,
    region_un
) VALUES (
    100004,
    'Guadeloupe',
    'GP',
    'GLP',
    'Caribbean',
    'Americas'
);

UPDATE ne_provinces SET iso_a2 = 'RE' WHERE name = 'La Réunion';
INSERT INTO ne_countries (
    gid,
    name,
    iso_a2,
    iso_a3,
    subregion,
    region_un
) VALUES (
    100005,
    'Réunion',
    'RE',
    'REU',
    'Eastern Africa',
    'Africa'
);

UPDATE ne_provinces SET iso_a2 = 'MQ' WHERE name = 'Martinique';
INSERT INTO ne_countries (
    gid,
    name,
    iso_a2,
    iso_a3,
    subregion,
    region_un
) VALUES (
    100006,
    'Martinique',
    'MQ',
    'MTQ',
    'Caribbean',
    'Americas'
);

UPDATE ne_provinces SET iso_a2 = 'YT' WHERE name = 'Mayotte';
INSERT INTO ne_countries (
    gid,
    name,
    iso_a2,
    iso_a3,
    subregion,
    region_un
) VALUES (
    100007,
    'Mayotte',
    'YT',
    'MYT',
    'Eastern Africa',
    'Africa'
);

UPDATE ne_provinces SET iso_a2 = 'GF' WHERE name = 'Guyane française';
INSERT INTO ne_countries (
    gid,
    name,
    iso_a2,
    iso_a3,
    subregion,
    region_un
) VALUES (
    100008,
    'French Guiana',
    'GF',
    'GUF',
    'South America',
    'Americas'
);

COMMIT;
