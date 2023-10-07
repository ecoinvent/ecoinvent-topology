SET CLIENT_ENCODING TO UTF8;
SET STANDARD_CONFORMING_STRINGS TO ON;
SET client_min_messages TO WARNING;

BEGIN;
INSERT INTO final (collection, name, shortname, geom)
(
    SELECT 'states', 'Canada, ' || g.name, n.iso_3166_2, geometry(g.topogeom)
    FROM geometries g
    LEFT JOIN ne_provinces n ON g.gid = n.gid
    WHERE g.tname = 'ne_provinces'
    AND g.parent = 'Canada'
    AND g.name IS NOT NULL
);
INSERT INTO final (collection, name, shortname, geom)
(
    SELECT 'states', 'United States of America, ' || g.name, n.iso_3166_2, geometry(g.topogeom)
    FROM geometries g
    LEFT JOIN ne_provinces n ON g.gid = n.gid
    WHERE g.tname = 'ne_provinces'
    AND g.parent = 'United States of America'
    AND g.name IS NOT NULL
);
INSERT INTO final (collection, name, shortname, geom)
(
    SELECT 'states', 'Australia, ' || g.name, n.code_hasc, geometry(g.topogeom)
    FROM geometries g
    LEFT JOIN ne_provinces n ON g.gid = n.gid
    WHERE g.tname = 'ne_provinces'
    AND g.parent = 'Australia'
    AND g.name in (
        'Northern Territory',
        'Western Australia',
        'Australian Capital Territory',
        'New South Wales',
        'South Australia',
        'Victoria',
        'Queensland',
        'Tasmania'
    )
);
INSERT INTO final (collection, name, shortname, geom)
(
    SELECT 'states', 'Brazil, ' || g.name, n.code_hasc, geometry(g.topogeom)
    FROM geometries g
    LEFT JOIN ne_provinces n ON g.gid = n.gid
    WHERE g.tname = 'ne_provinces'
    AND g.parent = 'Brazil'
    AND g.name IS NOT NULL
);
INSERT INTO final (collection, name, shortname, geom)
(
    SELECT 'states', 'India, ' || g.name, n.code_hasc, geometry(g.topogeom)
    FROM geometries g
    LEFT JOIN ne_provinces n ON g.gid = n.gid
    WHERE g.tname = 'ne_provinces'
    AND g.parent = 'India'
    AND g.name IS NOT NULL
);
INSERT INTO final (collection, name, shortname, geom)
(
    SELECT 'states', 'China, ' || g.name || ' (' || CASE WHEN name_local LIKE '%|%' THEN split_part(name_local, '|', 2) ELSE name_local END || ')', 'CN-' || n.postal, geometry(g.topogeom)
    FROM geometries g
    LEFT JOIN ne_provinces n ON g.gid = n.gid
    WHERE g.tname = 'ne_provinces'
    AND g.parent = 'China'
    AND g.name != 'Paracel Islands'
);
COMMIT;
