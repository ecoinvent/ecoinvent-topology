SET CLIENT_ENCODING TO UTF8;
SET STANDARD_CONFORMING_STRINGS TO ON;
BEGIN;

CREATE OR REPLACE FUNCTION MergeProvinces(a text, b text)
RETURNS VOID AS
$$
BEGIN
UPDATE ne_provinces SET geom = (SELECT ST_UNION(geom) from ne_provinces WHERE name IN ($1, $2)) WHERE name = $1;
DELETE FROM ne_provinces WHERE name = $2;
END;
$$ LANGUAGE 'plpgsql' VOLATILE STRICT;

CREATE OR REPLACE FUNCTION SingleProvince(a text)
RETURNS VOID AS
$$
  BEGIN
    ASSERT (SELECT count(*) FROM ne_provinces WHERE ne_provinces.name = $1) = 1, 'Not single province';
  END;
$$ LANGUAGE 'plpgsql' VOLATILE STRICT;

CREATE OR REPLACE FUNCTION SingleCountry(a text)
RETURNS VOID AS
$$
  BEGIN
    ASSERT (SELECT count(*) FROM ne_countries WHERE ne_countries.name = $1) = 1, 'Not single country';
  END;
$$ LANGUAGE 'plpgsql' VOLATILE STRICT;

CREATE OR REPLACE FUNCTION AddTopoGeometry(name varchar, tname varchar, gid int)
RETURNS varchar AS $$
DECLARE
  sql varchar;
BEGIN
    sql := 'INSERT INTO "geometries" ("gid", "name", "tname", "topogeom")
      VALUES (
          ' || quote_literal(gid) || ',
          ' || quote_literal(name) || ',
          ' || quote_literal(tname) || ',
          toTopoGeom((SELECT geom from ' || quote_ident(tname) || ' where gid = ' || quote_literal(gid) || E'), \'ei_topo\' , 1, 0.000001)
          )';
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


CREATE OR REPLACE FUNCTION AddTopoGeometry2(name varchar, tname varchar, gid_column_name varchar, gid int)
RETURNS varchar AS $$
DECLARE
  sql varchar;
BEGIN
    sql := 'INSERT INTO "geometries" ("gid", "name", "tname", "topogeom")
      VALUES ($1, $2, $3, toTopoGeom((SELECT geom from ' || quote_ident(tname) || ' where ' || quote_ident(gid_column_name) || E' = $1), \'ei_topo\' , 1, 0.000001)
          )';
    BEGIN
      EXECUTE sql USING gid, name, tname;
      RETURN name;
    EXCEPTION
     WHEN OTHERS THEN
      RAISE WARNING 'Problem with geometry of %: %', name, SQLERRM;
      RETURN name;
    END;
END
$$ LANGUAGE 'plpgsql' VOLATILE STRICT;


CREATE OR REPLACE FUNCTION EliminateNonBranchingNodes()
RETURNS int AS $$
    select ST_ModEdgeHeal('ei_topo', outr.lft, outr.rght) from (
        select distinct
            (case when edge1.edge_id < edge2.edge_id then edge1.edge_id else edge2.edge_id end) as lft,
            (case when edge1.edge_id < edge2.edge_id then edge2.edge_id else edge1.edge_id end) as rght
            from (
                select node_id as nid
                    from ei_topo.node
                    left join ei_topo.edge_data as foo1 on foo1.start_node = node_id
                    left join ei_topo.edge_data as foo2 on foo2.end_node = node_id
                    where foo1.edge_id != foo2.edge_id
                    group by node_id
                    having count(*) = 1
            ) as innr
        left join ei_topo.edge_data as edge1 on edge1.start_node = innr.nid
        left join ei_topo.edge_data as edge2 on edge2.end_node = innr.nid
        group by lft, rght
    ) as outr
    where ((select count(*) from ei_topo.edge_data where edge_id = lft) + (select count(*) from ei_topo.edge_data where edge_id = rght)) > 1
    limit 1;
$$ language 'sql';


CREATE OR REPLACE FUNCTION TopoContains(outside topogeometry, inside topogeometry)
RETURNS boolean AS $$
  select count(*) = 0 from (
    (select GetTopoGeomElements(inside)) except (select GetTopoGeomElements(outside))
  ) as t1;
$$ language 'sql' stable;


CREATE OR REPLACE FUNCTION PolygonTopoUnion(topo varchar, layer int, topo1 topogeometry, topo2 topogeometry)
RETURNS topogeometry as $$
  SELECT CreateTopoGeom(topo, 3, layer, TopoElementArray_Agg(t2.element)) as geom from (
      select distinct element from (
          (select GetTopoGeomElements(topo1) as element) union
          (select GetTopoGeomElements(topo2) as element)
      ) as t1
      order by t1.element
  ) as t2
$$ language 'sql' volatile;


CREATE OR REPLACE FUNCTION TopoContainsWarning(inside varchar, outside varchar)
  RETURNS boolean AS
$$
DECLARE
BEGIN
    IF TopoContains(inside, outside) THEN
        RETURN TRUE;
    ELSE
        RAISE NOTICE 'Not contained: % is not contained by %', inside, outside;
        RETURN FALSE;
    END IF;
END;
$$
LANGUAGE 'plpgsql' stable strict;


CREATE OR REPLACE FUNCTION ExtractOnlyPolygons(geom geometry)
RETURNS geometry AS $$
    SELECT ST_MakeValid(ST_CollectionExtract(geom, 3))
$$ language 'sql';


create or replace function vector_dammit (integer[])
returns integer[] language sql
as $$
    select array(select unnest($1[:][:1]));
$$;


CREATE or replace AGGREGATE intarrays_cat(integer[]) (
  SFUNC=array_cat,
  STYPE=integer[],
  finalfunc=vector_dammit
);

COMMIT;
