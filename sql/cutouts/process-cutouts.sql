SET CLIENT_ENCODING TO UTF8;
SET STANDARD_CONFORMING_STRINGS TO ON;
BEGIN;
insert into geometries (name, tname, topogeom)
    values ('mro', 'cutouts',
        toTopoGeom(ST_Intersection(
            (select ST_Union(geometry(topogeom)) from geometries where tname = 'ne_provinces' and name in ('Montana', 'South Dakota', 'Nebraska', 'Michigan', 'Wisconsin')),
            (select geom from cutouts where name = 'Midwest Reliability Organization')),
            'ei_topo', 1, 0.000001
    ));
insert into geometries (name, tname, topogeom)
    values ('mro-ill', 'cutouts',
        toTopoGeom(ST_Intersection(
            (select geometry(topogeom) from geometries where tname = 'ne_provinces' and name = 'Illinois'),
            (select geom from cutouts where name = 'MRO (Illinois)')),
            'ei_topo', 1, 0.000001
    ));
insert into geometries (name, tname, topogeom)
    values ('serc', 'cutouts',
        toTopoGeom(ST_Intersection(
            (select ST_Union(geometry(topogeom)) from geometries where tname = 'ne_provinces' and name in ('Virginia', 'Texas', 'Florida', 'Kentucky', 'Illinois')),
            (select geom from cutouts where name = 'SERC Reliability Corporation')),
            'ei_topo', 1, 0.000001
    ));
insert into geometries (name, tname, topogeom)
    values ('spp-east', 'cutouts',
        toTopoGeom(ST_Intersection(
            (select ST_Union(geometry(topogeom)) from geometries where tname = 'ne_provinces' and name in ('Missouri', 'Arkansas', 'Louisiana')),
            (select geom from cutouts where name = 'Southwest Power Pool')),
            'ei_topo', 1, 0.000001
    ));
insert into geometries (name, tname, topogeom)
    values ('spp-nm', 'cutouts',
        toTopoGeom(ST_Intersection(
            (select geometry(topogeom) from geometries where tname = 'ne_provinces' and name = 'New Mexico'),
            (select geom from cutouts where name = 'Southwest Power Pool')),
            'ei_topo', 1, 0.000001
    ));
insert into geometries (name, tname, topogeom)
    values ('spp-texas', 'cutouts',
        toTopoGeom(ST_Intersection(
            (select geometry(topogeom) from geometries where tname = 'ne_provinces' and name = 'Texas'),
            (select geom from cutouts where name = 'SPP (Texas)')),
            'ei_topo', 1, 0.000001
    ));
insert into geometries (name, tname, topogeom)
    select 'serc-west', 'cutouts',
        toTopoGeom(
            ST_Union(
                ST_GetFaceGeometry(
                    'ei_topo',
                    GetFaceByPoint('ei_topo', t1.str, 0)
                    )
            ), 'ei_topo', 1, 0.000001)
from (select
    (select ST_GeomFromEWKT('SRID=4326;POINT(-91.41 38.08)') as str) union
    (select ST_GeomFromEWKT('SRID=4326;POINT(-91.82 34.91)') as str) union
    (select ST_GeomFromEWKT('SRID=4326;POINT(-91.82 32.45)') as str) union
    (select ST_GeomFromEWKT('SRID=4326;POINT(-91.11 30.19)') as str) union
    (select ST_GeomFromEWKT('SRID=4326;POINT(-91.883 29.573)') as str)
) as t1;
insert into geometries (name, tname, topogeom)
    select 'wecc-east', 'cutouts',
        toTopoGeom(
            ST_Union(
                ST_GetFaceGeometry(
                    'ei_topo',
                    GetFaceByPoint('ei_topo', t1.str, 0)
                    )
            ), 'ei_topo', 1, 0.000001)
from (select
    (select ST_GeomFromEWKT('SRID=4326;POINT(-110.03 47.19)') as str) union
    (select ST_GeomFromEWKT('SRID=4326;POINT(-103.71 44.28)') as str) union
    (select ST_GeomFromEWKT('SRID=4326;POINT(-103.56 42.83)') as str) union
    (select ST_GeomFromEWKT('SRID=4326;POINT(-103.52 41.49)') as str)
) as t1;
insert into geometries (name, tname, topogeom)
    values ('rfc-ill', 'cutouts',
        toTopoGeom(
            ST_GetFaceGeometry('ei_topo', GetFaceByPoint(
                'ei_topo', ST_GeomFromEWKT('SRID=4326;POINT(-88.50 42.06)'), 0
                )
            ), 'ei_topo', 1, 0.000001)
);
insert into geometries (name, tname, topogeom)
values ('frcc', 'cutouts',
    toTopoGeom(
        ST_GetFaceGeometry('ei_topo', GetFaceByPoint(
            'ei_topo', ST_GeomFromEWKT('SRID=4326;POINT(-81.38 27.557)'), 0
            )
        ), 'ei_topo', 1, 0.000001)
);
insert into geometries (name, tname, topogeom)
    values ('wecc-texas', 'cutouts',
        toTopoGeom(ST_Intersection(
            (select geometry(topogeom) from geometries where tname = 'ne_provinces' and name = 'Texas'),
            (select geom from cutouts where name = 'Western Electricity Coordinating Council')),
            'ei_topo', 1, 0.000001
    ));
insert into geometries (name, tname, topogeom)
    values ('tre', 'cutouts',
        toTopoGeom(
            ST_GetFaceGeometry('ei_topo', GetFaceByPoint(
                'ei_topo', ST_GeomFromEWKT('SRID=4326;POINT(-99.62 31.82)'), 0
                )
            ), 'ei_topo', 1, 0.000001)
);
insert into geometries (name, tname, topogeom)
    values ('wecc-nm', 'cutouts',
        toTopoGeom(
            ST_GetFaceGeometry('ei_topo', GetFaceByPoint(
                'ei_topo', ST_GeomFromEWKT('SRID=4326;POINT(-106.82 34.77)'), 0
                )
            ), 'ei_topo', 1, 0.000001)
);
insert into geometries (name, tname, topogeom)
    select 'rfc-va', 'cutouts',
        toTopoGeom(
            ST_Union(
                ST_GetFaceGeometry(
                    'ei_topo',
                    GetFaceByPoint('ei_topo', t1.str, 0)
                    )
            ), 'ei_topo', 1, 0.000001)
from (select
    (select ST_GeomFromEWKT('SRID=4326;POINT(-82.39 37.56)') as str) union
    (select ST_GeomFromEWKT('SRID=4326;POINT(-80.86 37.0)') as str) union
    (select ST_GeomFromEWKT('SRID=4326;POINT(-78.23 38.8)') as str)
) as t1;
insert into geometries (name, tname, topogeom)
    values ('rfc', 'cutouts',
        toTopoGeom(ST_Intersection(
            (select ST_Union(geometry(topogeom)) from geometries where tname = 'ne_provinces' and name in ('Michigan', 'Wisconsin')),
            (select geom from cutouts where name = 'ReliabilityFirst Corporation')),
            'ei_topo', 1, 0.000001
    ));
insert into geometries (name, tname, topogeom)
    values ('ascc', 'cutouts',
        toTopoGeom(ST_Intersection(
            (select geometry(topogeom) from geometries where tname = 'ne_provinces' and name = 'Alaska'),
            (select geom from cutouts where name = 'Alaska Systems Coordinating Council')),
            'ei_topo', 1, 0.000001
    ));

COMMIT;
