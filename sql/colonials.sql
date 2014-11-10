SET CLIENT_ENCODING TO UTF8;
SET STANDARD_CONFORMING_STRINGS TO ON;
SET client_min_messages TO WARNING;

BEGIN;
insert into final (collection, name, shortname, geom) values ('special', 'Netherlands (Caribbean)', 'NL (Caribbean)', (
    select ST_Union(geometry(topogeom))
        from geometries
        where parent = 'Netherlands'
        and tname = 'ne_provinces'
        and name in ('Saba', 'St. Eustatius', 'Bonaire')
));
insert into final (collection, name, shortname, geom) values ('special', 'French Guiana', 'French Guiana', (
    select geometry(topogeom)
        from geometries
        where parent = 'France'
        and tname = 'ne_provinces'
        and name = 'Guyane française'
));
insert into final (collection, name, shortname, geom) values ('special', 'Guadeloupe', 'Guadeloupe', (
    select geometry(topogeom)
        from geometries
        where parent = 'France'
        and tname = 'ne_provinces'
        and name = 'Guadeloupe'
));
insert into final (collection, name, shortname, geom) values ('special', 'Martinique', 'Martinique', (
    select geometry(topogeom)
        from geometries
        where parent = 'France'
        and tname = 'ne_provinces'
        and name = 'Martinique'
));
insert into final (collection, name, shortname, geom) values ('special', 'Mayotte', 'Mayotte', (
    select geometry(topogeom)
        from geometries
        where parent = 'France'
        and tname = 'ne_provinces'
        and name = 'Mayotte'
));
insert into final (collection, name, shortname, geom) values ('special', 'Réunion', 'Réunion', (
    select geometry(topogeom)
        from geometries
        where parent = 'France'
        and tname = 'ne_provinces'
        and name = 'La Réunion'
));
COMMIT;
