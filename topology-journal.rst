TODO
====

- Finish recipes

I have what I hope is a simple requests. A few years ago, I had asked you to create aluminium-producing regions, something you didn't like then. Could you please merge two areas (IAI Area 6A and IAI Area 6B). The new area name would be:
Short name: IAI Area 6A/6B
Long name: IAI Producing Area 6A/6B, Europe

Changes
=======

* Removed Churchill Falls generating station (shouldn't have been included in the first place)
* Simplified
* Merged IAI regions 6A & B at request of Pascal Lesage (location 957d3a44-9ec2-4829-b5fe-17ba975a45da is therefore deleted)
* Made IAI regions names and shortnames more consistent
* "Sint Maarten, Dutch Part" was changed to "Sint Maarten". The French part is "Saint Martin".
* Europe no longer includes parts of Turkey, Azerbaijan, and Georgia. The "European" and "Asian" parts of Russia are now defined by Russian oblast (province).

Problem geometries
==================

France, including overseas territories
Spain, including overseas territories

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

Procedure
=========

#. Import country geometries from natural earth into table "ne_countries"
#. Import province geometries from natural earth into table "ne_provinces"
#. Import sovereign state geometries from natural earth into table "ne_states"
#. Create topology
#. Import cutout shapes from geopackage into table "cutouts"
#. Edit cutout shapes to fit into existing borders
#. Create topologies from all three tables
#. Write ecoinvent geographies into new table "ecoinvent" (translate topology to geometry, edit field names)
#. Export geopackage in qgis

Ecoinvent-required fields
=========================

* ISOTwoLetterCode
* UNCode
* longitude
* ISOThreeLetterCode
* UNSubregionCode
* latitude
* UNRegionCode
* uuid
* shortname
* name (multiple languages)

Setup
=====

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

update public.ne_geometry set geom = geometry(topogeom);

Eliminate non-branching nodes
-----------------------------

Should be run several times:

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
