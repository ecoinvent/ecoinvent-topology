SET CLIENT_ENCODING TO UTF8;
SET STANDARD_CONFORMING_STRINGS TO ON;
BEGIN;
CREATE TABLE public.geometries (
  id SERIAL PRIMARY KEY,
  gid int,
  name text,
  parent text,
  tname text
);
ALTER TABLE public.geometries
  OWNER TO ecoinvent;
SELECT AddTopoGeometryColumn('ei_topo', 'public', 'geometries', 'topogeom', 'MULTIPOLYGON');

CREATE TABLE public.cutouts (
  id SERIAL PRIMARY KEY,
  name text,
  code real, -- Not used, but present in input geopackage
  uuid text, -- Not used, but present in input geopackage
  geom geometry(MultiPolygon,4326)
);
ALTER TABLE public.cutouts
  OWNER TO ecoinvent;

CREATE TABLE public.final (
  id SERIAL PRIMARY KEY,
  gid int,
  collection text,
  name text,
  ISOTwoLetterCode text,
  UNCode int,
  longitude double precision,
  ISOThreeLetterCode text,
  UNSubregionCode text,
  latitude double precision,
  UNRegionCode int,
  uuid text,
  shortname text,
  geom geometry(MultiPolygon,4326)
);
ALTER TABLE public.cutouts
  OWNER TO ecoinvent;

CREATE INDEX ON public.final (collection, name);
CREATE UNIQUE INDEX unique_names_final_idx ON public.final (name);

COMMIT;
