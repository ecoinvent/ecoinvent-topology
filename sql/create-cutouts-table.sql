SET CLIENT_ENCODING TO UTF8;
SET STANDARD_CONFORMING_STRINGS TO ON;
BEGIN;
CREATE TABLE public.cutouts (
  id SERIAL PRIMARY KEY,
  name text,
  code real,
  uuid text,
  geom geometry(MultiPolygon,4326)
);

ALTER TABLE public.cutouts
  OWNER TO ecoinvent;
COMMIT;
