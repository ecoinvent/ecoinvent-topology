SET CLIENT_ENCODING TO UTF8;
SET STANDARD_CONFORMING_STRINGS TO ON;
SET client_min_messages TO WARNING;

BEGIN;

-- Svalbard and Bouvet aren't part of ISO-code Norway
update geometries set topogeom = CreateTopoGeom('ei_topo', 3, 1, (
    select TopoElementArray_Agg(elem) from (
        select GetTopoGeomElements(topogeom) as elem
            from geometries
            where name = 'Norway'
            and tname = 'ne_countries'
        ) as t1
        where elem not in (
            select GetTopoGeomElements(topogeom) as foo
                from geometries
                where name in ('Svalbard', 'Bouvet Island')
                and tname = 'ne_provinces'
        ))
    )
    where name = 'Norway'
    and tname = 'ne_countries';

-- Tokelau has an ISO code, and therefore not in ISO New Zealand
update geometries set topogeom = CreateTopoGeom('ei_topo', 3, 1, (
    select TopoElementArray_Agg(elem) from (
        select GetTopoGeomElements(topogeom) as elem
            from geometries
            where name = 'New Zealand'
            and tname = 'ne_countries'
        ) as t1
        where elem not in (
            select GetTopoGeomElements(topogeom) as foo
                from geometries
                where name = 'Tokelau'
                and tname = 'ne_provinces'
        ))
    )
    where name = 'New Zealand'
    and tname = 'ne_countries';

COMMIT;
