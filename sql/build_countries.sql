SET CLIENT_ENCODING TO UTF8;
SET STANDARD_CONFORMING_STRINGS TO ON;
SET client_min_messages TO WARNING;

BEGIN;
insert into final (gid, collection, name, shortname, isotwolettercode, isothreelettercode, uncode, unregioncode, geom)
    select g.gid, 'countries', g.name, c.iso_a2, c.iso_a2, c.iso_a3, un_a3::int, null, geometry(g.topogeom)
    from geometries g
    left join ne_countries c on g.gid = c.gid
    where g.tname = 'ne_countries';
COMMIT;
