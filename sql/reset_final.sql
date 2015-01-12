SET CLIENT_ENCODING TO UTF8;
SET STANDARD_CONFORMING_STRINGS TO ON;
BEGIN;
DROP TABLE public.final;

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
CREATE UNIQUE INDEX unique_shortnames_final_idx ON public.final (shortname);

COMMIT;
