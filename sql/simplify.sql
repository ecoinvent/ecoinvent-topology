SET CLIENT_ENCODING TO UTF8;
SET STANDARD_CONFORMING_STRINGS TO ON;
BEGIN;

CREATE OR REPLACE FUNCTION SimplifyEdgeGeom(atopo varchar, anedge int, maxtolerance float8)
RETURNS float8 AS $$
DECLARE
  tol float8;
  sql varchar;
BEGIN
  tol := maxtolerance;
  LOOP
    sql := 'SELECT topology.ST_ChangeEdgeGeom(' || quote_literal(atopo) || ', ' || anedge
      || ', ST_Simplify(geom, ' || tol || ')) FROM '
      || quote_ident(atopo) || '.edge_data WHERE edge_id = ' || anedge;
    BEGIN
      RAISE DEBUG 'Running %', sql;
      EXECUTE sql;
      RETURN tol;
    EXCEPTION
     WHEN OTHERS THEN
      -- RAISE WARNING 'Simplification of edge % with tolerance % failed: %', anedge, tol, SQLERRM;
      tol := round( (tol/2.0) * 1e8 ) / 1e8; -- round to get to zero quicker
      -- IF tol = 0 THEN RAISE EXCEPTION '%', SQLERRM; END IF;
      IF tol = 0 THEN RAISE WARNING '%', SQLERRM; RETURN 0.0; END IF;
    END;
  END LOOP;
END
$$ LANGUAGE 'plpgsql' STABLE STRICT;
COMMIT;

BEGIN;
select SimplifyEdgeGeom('ei_topo', edge_id, 0.01) from ei_topo.edge_data where edge_id not in (
  -- Skip very small faces where a 'coincident edge' error would be raised
  -- Probably they should be deleted, but it is not trivial, so just skip for now.
  select abs(t1.edge)
    from (
        select (ST_GetFaceEdges('ei_topo', face_id)).*
            from ei_topo.face
            where ST_Area(ST_GetFaceGeometry('ei_topo', face_id)) < 1e-13
            and face_id > 0
    ) as t1);
COMMIT;

