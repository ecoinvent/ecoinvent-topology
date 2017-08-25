SET CLIENT_ENCODING TO UTF8;
SET STANDARD_CONFORMING_STRINGS TO ON;
SET client_min_messages TO WARNING;

BEGIN;

-- Cyprus doesn't include no man's land (no economic activity)
update geometries set topogeom = CreateTopoGeom('ei_topo', 3, 1, (
    select TopoElementArray_Agg(elem) from (
        select GetTopoGeomElements(topogeom) as elem
            from geometries
            where name = 'Cyprus'
            and tname = 'ne_countries'
        ) as t1
        where elem not in (
            select GetTopoGeomElements(topogeom) as foo
                from geometries
                where name = 'Cyprus No Mans Area'
                and tname = 'ne_countries'
        ))
    )
    where name = 'Cyprus'
    and tname = 'ne_countries';

COMMIT;
