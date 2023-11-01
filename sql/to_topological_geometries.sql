SET CLIENT_ENCODING TO UTF8;
SET STANDARD_CONFORMING_STRINGS TO ON;
SET client_min_messages TO WARNING;

BEGIN;
SELECT AddTopoGeometry(name, 'ne_provinces', gid) FROM ne_provinces ORDER BY name;
UPDATE geometries g
    SET parent = s.admin
    FROM (SELECT gid, admin from ne_provinces) AS s
    WHERE g.gid = s.gid
    AND g.tname = 'ne_provinces';

SELECT AddTopoGeometry(name, 'ne_countries', gid)
    FROM ne_countries
    WHERE name IN (
        'Akrotiri Sovereign Base Area',
        'Dhekelia Sovereign Base Area',
        'Cyprus No Mans Area',
        'Northern Cyprus',
        'Spratly Islands'
    );

INSERT INTO "geometries" ("gid", "name", "tname", "topogeom")
    SELECT
        nc.gid,
        nc.name,
        'ne_countries',
        toTopoGeom(ST_Multi(ST_Union(geometry(g.topogeom))), 'ei_topo', 1, 0.000001)
    from geometries g
    left join ne_provinces np on g.gid = np.gid
    left join ne_countries nc on np.iso_a2 = nc.iso_a2
    where g.tname = 'ne_provinces'
    group by (nc.name, nc.gid);

INSERT INTO "geometries" ("gid", "name", "tname", "topogeom")
    SELECT
        n.ogc_fid,
        n.name,
        'nerc',
        toTopoGeom(n.geom, 'ei_topo', 1, 0.000001)
    from nerc n;
COMMIT;
