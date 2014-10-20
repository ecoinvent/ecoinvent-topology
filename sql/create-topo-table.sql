SET CLIENT_ENCODING TO UTF8;
SET STANDARD_CONFORMING_STRINGS TO ON;
BEGIN;
CREATE TABLE public.geometries (
  id SERIAL PRIMARY KEY,
  name text,
  tname text,
  geom geometry(MultiPolygon,4326)
);
ALTER TABLE public.geometries
  OWNER TO ecoinvent;
SELECT AddTopoGeometryColumn('ei_topo', 'public', 'geometries', 'topogeom', 'MULTIPOLYGON');

CREATE OR REPLACE FUNCTION AddTopoGeometry(name varchar, tname varchar, gid int)
RETURNS varchar AS $$
DECLARE
  sql varchar;
BEGIN
    sql := 'INSERT INTO "geometries" ("name", "tname", "topogeom") VALUES (' || quote_literal(name) || ', ' || quote_literal(tname) || ', toTopoGeom((SELECT geom from ' || quote_ident(tname) || ' where gid = ' || quote_literal(gid) || E'), \'ei_topo\' , 1, 0.000001))';
    BEGIN
      EXECUTE sql;
      RETURN name;
    EXCEPTION
     WHEN OTHERS THEN
      RAISE WARNING 'Problem with geometry of %: %', name, SQLERRM;
      RETURN name;
    END;
END
$$ LANGUAGE 'plpgsql' VOLATILE STRICT;

COMMIT;
