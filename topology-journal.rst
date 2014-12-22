TODO
====

* Add uuids
* Separate out Bouvet and Svalbard and Jan Mayen (have ISO codes) and Tokelau
* Serbia or republic of serbia?
* Report Cyprus

Changes
=======

* Removed Churchill Falls generating station (shouldn't have been included in the first place)
* Merged IAI regions 6A & B at request of Pascal Lesage (location 957d3a44-9ec2-4829-b5fe-17ba975a45da is therefore deleted)
* Made IAI region names and shortnames more consistent
* "Sint Maarten, Dutch Part" was changed to "Sint Maarten". The French part is "Saint Martin".
* Europe no longer includes parts of Turkey, Azerbaijan, and Georgia. The "European" and "Asian" parts of Russia are now defined by Russian oblast (province).
* The location "Central and Eastern Europe", which was marked as obsolete in 2009 and is not used by any datasets in 3.1, is now removed.

Problem geometries
==================

Southwest Power Pool
Florida Reliability Coordinating Council
Texas Regional Entity
ReliabilityFirst Corporation
SERC Reliability Corporation
Western Electricity Coordinating Council
Northeast Power Coordinating Council
Midwest Reliability Organization
Alaska Systems Coordinating Council

Midwest Reliability Organization, US part only
Northeast Power Coordinating Council, US part only
Western Electricity Coordinating Council, US part only

.. note: Ignore spain for now - not worth dealing with African exclaves.

Procedure
=========

#. Import country geometries from natural earth into table "ne_countries"
#. Import province geometries from natural earth into table "ne_provinces"
#. Import sovereign state geometries from natural earth into table "ne_states"
#. Create "ei_topo" topology
#. Import cutout shapes from geopackage into table "cutouts"
#. Edit cutout shapes to fit into existing borders
#. Create topologies from all four tables in new table "geometries"
#. Write ecoinvent geographies into new table "final" (translate topology to geometry, edit field names)
#. Add metadata from JSON config scripts and Natural Earth tables
#. Export geopackage using ogr2ogr

Ecoinvent-required fields - mapping with ne_countries
=====================================================

* ISOTwoLetterCode
* UNCode
* longitude
* ISOThreeLetterCode: su_a3
* UNSubregionCode
* latitude
* UNRegionCode
* uuid
* shortname:
* name (multiple languages): name

Recipes file format
===================

Each recipe has the following format:


  [
    name,
    collection,
    {
      geometry tablename: [list of constituent names]
    }
  ]

This generic recipe would generate the following SQL:

    INSERT INTO final (name, collection, geom)
        select name, collection, ST_Union(geometry(t1.topogeom))
        FROM (
            SELECT topogeom FROM geometries g
            where g.tname = geometry tablename
            and g.name in (list of constituent names)
        ) as t1;

If there are two tablenames, the recipe would be:

  [
    name,
    collection,
    {
      tablename one: [list one],
      tablename two: [list two]
    }
  ]

And the SQL:

    INSERT INTO final (name, collection, geom)
        select name, collection, ST_Union(geometry(t1.topogeom))
        FROM (
            SELECT topogeom FROM geometries g
            where g.tname = tablename one
            and g.name in (list one)
            UNION
            select topogeom
            FROM geometries g
            where g.tname = tablename two
            and g.name in (list two)
        ) as t1;

One special case is for provinces, where we need to also include the country:

  [
    "Northeast Power Coordinating Council",
    "americas-electricity",
    {
      "ne_provinces": [
        "Canada", ["Québec", ...]],
        "United States", ["New York", ...]]
      ]
    }
  ]

Note the syntax change: ``ne_provinces`` is now a list, with steps of ``country, [list of provinces]``.

In this case, the SQL would also include filtering by parent:

    INSERT INTO final (name, collection, geom)
        SELECT 'Northeast Power Coordinating Council', 'americas-electricity', ST_Union(geometry(t1.topogeom))
        FROM (
            SELECT topogeom
            FROM geometries g
            where g.tname = 'ne_provinces'
            AND g.parent = 'Canada'
            and g.name IN ('Québec', ...)
            UNION
            SELECT topogeom
            FROM geometries g
            where g.tname = 'ne_provinces'
            AND g.parent = 'United States'
            and g.name IN ('New York', ...)
        ) as t1;

Shell script
============

Shell script is ``create-db.sh``.

It assumes the following:

1. You have python installed on your machine
2. You have Postgresql and PostGIS installed on your machine
3. You have a Postgresql user named "ecoinvent" who can create tables

Shell script takes a few hours to run.

Setup
=====

Python packages
---------------

* argparse
* babel
* fastkml
* lxml
* sphinx
* unicodecsv

General reading
---------------

http://postgis.net/docs/Topology.html
http://strk.keybit.net/blog/tag/topology/


Database config
---------------

Set up database:

    CREATE EXTENSION postgis;
    CREATE EXTENSION postgis_topology;

Create topology:

    SELECT CreateTopology('ne_topo', 4326);

We now have a *topology* called ``ne_topo``.

If this doesn't work:

    1. Try adding postigs_topolgy again (!?)
    2. Make sure topology is in "select postgis_full_version();"
    3. Make sure topology is in "SHOW search_path;"
    4. Refresh database connection in pgadmin.

Add data
--------

Convert to SQL:

    shp2pgsql -s 4326 ne_10m_admin_0_countries.shp ne_geometry > ne.sql

See also : http://www.bostongis.com/pgsql2shp_shp2pgsql_quickguide.bqg

Import into database:

    psql -d natural-earth -U cmutel -f ne.sql

3. Check in qgis

Setup topo geometry column
--------------------------

Add topo column:

    SELECT AddTopoGeometryColumn('ne_topo', 'public', 'ne_geometry', 'topogeom', 'MULTIPOLYGON');

Parameters are:

    * topo name
    * schema
    * table
    * column
    * feature type

See also: http://www.postgis.org/documentation/manual-svn/AddTopoGeometryColumn.html

Create topo geometries
----------------------

Turn existing geometries into topo geometries:

    UPDATE ne_geometry SET topogeom = toTopoGeom(geom, 'ne_topo', 1, 0.000001);

Takes ~ 5 minutes.

See also: http://postgis.net/docs/toTopoGeom.html

Check results in qgis
---------------------

Load the following tables:

    * ne_topo.edge_data
    * ne_topo.node

Simplification
==============

**Note**: We don't use simplification for now.

Find optimum simplifcation tolerance
------------------------------------

    * SELECT 1 as id, st_simplify(geom, 0.001) as geom FROM ne_topo.edge where edge_id = 3827
    * SELECT 1 as id, st_simplify(geom, 0.01) as geom FROM ne_topo.edge where edge_id = 3827
    * SELECT 1 as id, st_simplify(geom, 0.1) as geom FROM ne_topo.edge where edge_id = 3827
    * SELECT 1 as id, st_simplify(geom, 1.0) as geom FROM ne_topo.edge where edge_id = 3827

0.01 seems like the best for now.

Create simplification function
------------------------------

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
      || quote_ident(atopo) || '.edge WHERE edge_id = ' || anedge;
    BEGIN
      RAISE DEBUG 'Running %', sql;
      EXECUTE sql;
      RETURN tol;
    EXCEPTION
     WHEN OTHERS THEN
      RAISE WARNING 'Simplification of edge % with tolerance % failed: %', anedge, tol, SQLERRM;
      tol := round( (tol/2.0) * 1e8 ) / 1e8; -- round to get to zero quicker
      IF tol = 0 THEN RAISE EXCEPTION '%', SQLERRM; END IF;
    END;
  END LOOP;
END
$$ LANGUAGE 'plpgsql' STABLE STRICT;

Usage:

    select SimplifyEdgeGeom("ne_topo", edge_id, 0.01) from ne_topo.edge_data;

Turn topographies back into normal geographies
----------------------------------------------

geometry(topogeom)

Eliminate non-branching nodes
-----------------------------

Defined in sql/create-functions.sql, and run in python/eliminate_nodes.py:

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

Utility functions
-----------------

Defined in sql/create-functions.sql:

CREATE OR REPLACE FUNCTION ExtractOnlyPolygons(geom geometry)
RETURNS geometry AS $$
    SELECT ST_MakeValid(ST_CollectionExtract(geom, 3))
$$ language 'sql';

TODO::

SQL statements
--------------

To merge topogeometries:

select toTopoGeom(ExtractOnlyPolygons(ST_Union(geometry(topogeom))) from table-name where condition;

Convert existing XML file to geopackage
---------------------------------------

from lxml import objectify, etree
import fastkml
import fiona
import shapely


def remove_namespace(doc, namespace=u"{http://www.EcoInvent.org/EcoSpold02}"):
    """Remove namespace in the passed document in place."""
    ns = u'{}'.format(namespace)
    nsl = len(ns)
    for elem in doc.getiterator():
        if elem.tag.startswith(ns):
            elem.tag = elem.tag[nsl:]


def xml_to_geopackage(filepath="Geographies.xml"):
    xml = objectify.parse(open(filepath))
    root = xml.getroot()
    remove_namespace(root)
    objectify.deannotate(root, cleanup_namespaces=True)

    meta = {
        'crs': {'no_defs': True, 'ellps': 'WGS84', 'datum': 'WGS84', 'proj': 'longlat'},
        'driver': 'GPKG',
        'schema': {
            'geometry': 'MultiPolygon',
            'properties': {'name': 'str', 'uuid': 'str', 'code': 'float'}
        }
    }

    with fiona.drivers():
        with fiona.open("ecoinvent-geographies.gpkg", "w", **meta) as dest:
            for el in root.geography:
                try:
                    parsed = fastkml.kml.KML()
                    parsed.from_string(etree.tostring(getattr(el, "{http://www.opengis.net/kml/2.2}kml"), encoding="utf8"))
                except AttributeError:
                    continue
                dest.write({
                    'geometry': shapely.geometry.mapping(parsed.features().next().features().next().geometry),
                    'properties': {
                        'name': unicode(el.name),
                        'uuid': unicode(el.get('id')),
                        'code': unicode(el.shortname)
                    }
                })

Convert excel spreadsheet of names to JSON
------------------------------------------

from openpyxl import load_workbook
import json

wb = load_workbook("eiv3_geographies-names_coordinates_shortcuts_20130904.xlsx")
sheet = wb.get_sheet_by_name("geographies_0904")

data = []

for row in sheet.rows[1:]:
    data.append({
        'name': row[0].value,
        'shortname': row[1].value,
        'uuid': row[2].value
    })

with open("country-uuid.json", "w") as f:
    f.write(json.dumps(data, ensure_ascii=False, indent=2).encode('utf8'))

Add small polygons from provinces to their countries
====================================================

Function to create union of two polygon topologies:

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

Identify missing faces:

    select ST_GetFaceGeometry('ei_topo', t1.faces[1]),
        row_number() OVER () as rnum -- Need unique id for Qgis
        from (
            (select GetTopoGeomElements(topogeom) as faces from geometries where tname = 'ne_provinces') except
            (select GetTopoGeomElements(topogeom) as faces from geometries where tname = 'ne_countries')
        ) as t1

Add missing faces to country:

    update geometries gg set topogeom = PolygonTopoUnion('ei_topo', 1, f.p, f.c) from (
        select p.name as province_name, p.admin as province_admin, c.name as country_name, c.admin as country_admin, g.id as province_id, g2.id as country_id, g.topogeom as p, g2.topogeom as c
            from geometries g
            left join ne_provinces p on g.gid = p.gid
            left join ne_countries c on c.admin = p.admin
            left join geometries g2 on g2.gid = c.gid
            where g.tname = 'ne_provinces'
            and g2.tname = 'ne_countries'
            and not topocontains(g2.topogeom, g.topogeom)
            order by g.name, g2.name
    ) as f
    where gg.id = f.country_id;

However, because of some weird race condition (maybe c.topogeom is not being updated automatically), we use the python script iterative_add_process, which does one at a time until there are no problems left.

.. warning:: This is not perfect - there are still missing parts in the Spratley islands and South Georgia islands, but they don't really matter for now. Hopefully...

Backup SQL data
===============

See: http://mattmakesmaps.com/blog/2014/01/15/using-pg-dump-with-postgis-topology/#.VCNBTQBjre0.twitter

pg_dump --schema=topology --schema=public --schema=ei_topo --file=output/ei_topo.sql -U ecoinvent eigeo

Changed:

    SET search_path = topology, pg_catalog;

    --
    -- Data for Name: layer; Type: TABLE DATA; Schema: topology; Owner: ecoinvent
    --

    COPY layer (topology_id, layer_id, schema_name, table_name, feature_column, feature_type, level, child_id) FROM stdin;
    1   1   public  geometries  topogeom    3   0   \N
    \.


    --
    -- Data for Name: topology; Type: TABLE DATA; Schema: topology; Owner: ecoinvent
    --

    COPY topology (id, name, srid, "precision", hasz) FROM stdin;
    1   ei_topo 4326    0   f
    \.

To:

    SET search_path = topology, pg_catalog;

    --
    -- Data for Name: topology; Type: TABLE DATA; Schema: topology; Owner: ecoinvent
    --

    COPY topology (id, name, srid, "precision", hasz) FROM stdin;
    1   ei_topo 4326    0   f
    \.

    --
    -- Data for Name: layer; Type: TABLE DATA; Schema: topology; Owner: ecoinvent
    --

    COPY layer (topology_id, layer_id, schema_name, table_name, feature_column, feature_type, level, child_id) FROM stdin;
    1   1   public  geometries  topogeom    3   0   \N
    \.


Processing for intersected areas
--------------------------------

.. code-block:: python

    import json
    data = json.load(open("all2.json"))
    as_sets = {k:v for k, v in {frozenset(o[:2]): o[2] / 1e6 for o in data}.iteritems()}
    len(as_sets), len(data)
    as_list = sorted([[sorted(k), v] for k, v in {frozenset(o[:2]): o[2] / 1e6 for o in data}.iteritems()])
    with open("intersections.json", "w") as f:
        f.write(json.dumps(as_list, ensure_ascii=False, indent=2).encode('utf8'))
