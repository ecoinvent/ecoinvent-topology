SET CLIENT_ENCODING TO UTF8;
SET STANDARD_CONFORMING_STRINGS TO ON;
SET client_min_messages TO WARNING;

BEGIN;
insert into final (
  gid,
  collection,
  name,
  ISOTwoLetterCode,
  ISOThreeLetterCode,
  UNSubregion,
  UNRegion,
  uuid,
  shortname,
  geom,
  faces
)
select
    nc.gid,
    'countries',
    nc."name",
    nc.iso_a2,
    nc.iso_a3,
    nc.subregion,
    nc.region_un,
    null,
    nc.iso_a2,
    ST_Multi(geometry(g.topogeom)),
    vector_dammit(GetTopoGeomElementArray(g.topogeom)::int[])
from geometries g
left join ne_countries nc on g.gid = nc.gid
where g.tname = 'ne_countries';
COMMIT;
