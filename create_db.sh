#!/bin/bash
echo "Creating database and tables"
psql -U ecoinvent -d template1 -c "DROP DATABASE eigeo;" -q -n -o create_db.log
psql -U ecoinvent -d template1 -c "CREATE DATABASE eigeo WITH OWNER = ecoinvent ENCODING = 'UTF8';" -q -n -o create_db.log
psql -U ecoinvent -d template1 -c "ALTER DATABASE eigeo SET search_path = public, topology;" -q -n -o create_db.log
psql -U ecoinvent -d eigeo -c "CREATE EXTENSION postgis;" -q -n -o create_db.log
psql -U ecoinvent -d eigeo -c "CREATE EXTENSION postgis_topology;" -q -n -o create_db.log
psql -U ecoinvent -d eigeo -c "SELECT CreateTopology('ei_topo', 4326);" -q -n -o create_db.log
psql -U ecoinvent -d eigeo -f sql/create-tables.sql -q -n -o create_db.log
psql -U ecoinvent -d eigeo -f sql/create-functions.sql -q -n -o create_db.log

echo "Importing raw GIS country/province/state data"
psql -U ecoinvent -d eigeo -f sql/ne_countries.sql -q -n -o create_db.log
psql -U ecoinvent -d eigeo -f sql/ne_states.sql -q -n -o create_db.log
psql -U ecoinvent -d eigeo -f sql/ne_provinces.sql -q -n -o create_db.log

echo "Fix problem with one province self-intersecting ring"
psql -U ecoinvent -d eigeo -c "SET client_min_messages TO WARNING;
 update ne_provinces set geom = ST_MakeValid(geom) where ST_IsValid(geom) = False;" -q -n -o create_db.log

echo "Add Baikonur Cosmodrome to Kazakhstan"
psql -U ecoinvent -d eigeo -c "UPDATE ne_countries SET geom = (SELECT ST_Union(t.g) FROM (SELECT geom AS g FROM ne_countries WHERE name = 'Kazakhstan' UNION SELECT ST_Buffer(geom, 0.5) as g FROM ne_countries WHERE name = 'Baikonur') AS t) WHERE name = 'Kazakhstan';" -q -n -o create_db.log
psql -U ecoinvent -d eigeo -c "DELETE FROM ne_countries WHERE name = 'Baikonur';" -q -n -o create_db.log

echo "Creating province topos"
echo "This will take some time; An error will be raised for Paphos - it can be ignored"
psql -U ecoinvent -d eigeo -c "SET client_min_messages TO WARNING;
 SELECT AddTopoGeometry(name, 'ne_provinces', gid) FROM ne_provinces ORDER BY name;" -q -n -o create_db.log
psql -U ecoinvent -d eigeo -c "UPDATE geometries g SET parent = s.admin FROM (SELECT gid, admin from ne_provinces) AS s WHERE g.gid = s.gid AND g.tname = 'ne_provinces';" -q -n -o create_db.log

echo "Add minor islands"
psql -U ecoinvent -d eigeo -c "SET client_min_messages TO WARNING;
 INSERT INTO geometries (topogeom, parent, tname, gid) (SELECT toTopoGeom(geom, 'ei_topo', 1, 0.000001), admin, 'ne_provinces', gid FROM ne_provinces WHERE name is NULL);" -q -n -o create_db.log

echo "Creating country topos"
psql -U ecoinvent -d eigeo -c "SET client_min_messages TO WARNING;
 SELECT AddTopoGeometry(admin, 'ne_countries', gid) FROM ne_countries ORDER BY name;" -q -n -o create_db.log

echo "Creating sovereign state topos"
psql -U ecoinvent -d eigeo -c "SET client_min_messages TO WARNING;
 SELECT AddTopoGeometry(name, 'ne_states', gid) FROM ne_states ORDER BY name;" -q -n -o create_db.log

echo "Getting and processing cutout geometries"
echo "SPP"
ogr2ogr -f PGDump sql/cutouts/spp.sql data/intermediate/spp.gpkg -lco CREATE_TABLE=OFF -lco SRID=4326 -lco GEOMETRY_NAME=geom -lco DIM=2
sed -i '' 's/"public"."spp"/"public"."cutouts"/g' sql/cutouts/spp.sql
ogr2ogr -f PGDump sql/cutouts/spp_texas.sql data/intermediate/spp_texas.gpkg -lco CREATE_TABLE=OFF -lco SRID=4326 -lco GEOMETRY_NAME=geom -lco DIM=2
sed -i '' 's/"public"."spp_texas"/"public"."cutouts"/g' sql/cutouts/spp_texas.sql
sed -i '' 's/Southwest Power Pool/SPP (Texas)/g' sql/cutouts/spp_texas.sql
psql -U ecoinvent -d eigeo -f sql/cutouts/spp.sql -q -n -o create_db.log
psql -U ecoinvent -d eigeo -f sql/cutouts/spp_texas.sql -q -n -o create_db.log

echo "SERC"
ogr2ogr -f PGDump sql/cutouts/serc.sql data/intermediate/serc.gpkg -lco CREATE_TABLE=OFF -lco SRID=4326 -lco GEOMETRY_NAME=geom -lco DIM=2
sed -i '' 's/"public"."serc"/"public"."cutouts"/g' sql/cutouts/serc.sql
psql -U ecoinvent -d eigeo -f sql/cutouts/serc.sql -q -n -o create_db.log

echo "Midwest (MRO)"
ogr2ogr -f PGDump sql/cutouts/mro.sql data/intermediate/mro.gpkg -lco CREATE_TABLE=OFF -lco SRID=4326 -lco GEOMETRY_NAME=geom -lco DIM=2
sed -i '' 's/"public"."mro"/"public"."cutouts"/g' sql/cutouts/mro.sql
psql -U ecoinvent -d eigeo -f sql/cutouts/mro.sql -q -n -o create_db.log

ogr2ogr -f PGDump sql/cutouts/mro_ill.sql data/intermediate/mro_ill.gpkg -lco CREATE_TABLE=OFF -lco SRID=4326 -lco GEOMETRY_NAME=geom -lco DIM=2
sed -i '' 's/"public"."mro_ill"/"public"."cutouts"/g' sql/cutouts/mro_ill.sql
sed -i '' 's/Midwest Reliability Organization/MRO (Illinois)/g' sql/cutouts/mro_ill.sql
psql -U ecoinvent -d eigeo -f sql/cutouts/mro_ill.sql -q -n -o create_db.log

echo "Western"
ogr2ogr -f PGDump sql/cutouts/wecc_texas.sql data/intermediate/wecc_texas.gpkg -lco CREATE_TABLE=OFF -lco SRID=4326 -lco GEOMETRY_NAME=geom -lco DIM=2
sed -i '' 's/"public"."wecc_texas"/"public"."cutouts"/g' sql/cutouts/wecc_texas.sql
sed -i '' 's/Midwest Reliability Organization/MRO (Illinois)/g' sql/cutouts/mro_ill.sql
psql -U ecoinvent -d eigeo -f sql/cutouts/wecc_texas.sql -q -n -o create_db.log

echo "ReliabilityFirst"
ogr2ogr -f PGDump sql/cutouts/rfc.sql data/intermediate/rfc.gpkg -lco CREATE_TABLE=OFF -lco SRID=4326 -lco GEOMETRY_NAME=geom -lco DIM=2
sed -i '' 's/"public"."rfc"/"public"."cutouts"/g' sql/cutouts/rfc.sql
psql -U ecoinvent -d eigeo -f sql/cutouts/rfc.sql -q -n -o create_db.log

echo "Alaska"
ogr2ogr -f PGDump sql/cutouts/ascc.sql data/intermediate/ascc.gpkg -lco CREATE_TABLE=OFF -lco SRID=4326 -lco GEOMETRY_NAME=geom -lco DIM=2
sed -i '' 's/"public"."ascc"/"public"."cutouts"/g' sql/cutouts/ascc.sql
psql -U ecoinvent -d eigeo -f sql/cutouts/ascc.sql -q -n -o create_db.log

echo "Adding cutout topologies"
psql -U ecoinvent -d eigeo -f sql/cutouts/process-cutouts.sql -q -n -o create_db.log

echo "Eliminating duplicate nodes"
python python/eliminate_nodes.py

echo "Testing database integrity"
python python/db_checks.py
rc=$?
if [[ $rc != 0 ]] ; then
    exit $rc
fi

echo "Adding missing province faces to countries"
python python/iterative_add_provinces.py

echo "Dealing with colonial legacies"
psql -U ecoinvent -d eigeo -f sql/colonials.sql -q -n -o create_db.log

echo "Building country geometries"
psql -U ecoinvent -d eigeo -f sql/build_countries.sql -q -n -o create_db.log

echo "Compiling recipes"
python python/parse_recipes.py

echo "Building final geometries"
psql -U ecoinvent -d eigeo -f sql/recipes.sql -q -n -o create_db.log

echo "Add Canadian provinces"
psql -U ecoinvent -d eigeo -c "INSERT INTO final (collection, name, shortname, geom) (SELECT 'states', g.name, n.iso_3166_2, geometry(g.topogeom) FROM geometries g LEFT JOIN ne_provinces n ON g.gid = n.gid WHERE g.tname = 'ne_provinces' AND g.parent = 'Canada' AND g.name IS NOT NULL);" -q -n -o create_db.log

echo "Add Australian states"
psql -U ecoinvent -d eigeo -c "INSERT INTO final (collection, name, shortname, geom) (SELECT 'states', g.name, REPLACE(n.code_hasc, '.', '-'), geometry(g.topogeom) FROM geometries g LEFT JOIN ne_provinces n ON g.gid = n.gid WHERE g.tname = 'ne_provinces' AND g.parent = 'Australia' AND g.name IS NOT NULL AND g.name in ('Northern Territory', 'Western Australia', 'Australian Capital Territory', 'New South Wales', 'South Australia', 'Victoria', 'Queensland', 'Tasmania'));" -q -n -o create_db.log

echo "Add Chinese provinces"
psql -U ecoinvent -d eigeo -c "INSERT INTO final (collection, name, shortname, geom) (SELECT 'states', g.name || ' (' || CASE WHEN name_local LIKE '%|%' THEN split_part(name_local, '|', 2) ELSE name_local END || ')', 'CN-' || n.postal, geometry(g.topogeom) FROM geometries g LEFT JOIN ne_provinces n ON g.gid = n.gid WHERE g.tname = 'ne_provinces' AND g.parent = 'China' AND g.name != 'Paracel Islands');" -q -n -o create_db.log
psql -U ecoinvent -d eigeo -c "UPDATE final SET name = 'Qinghai (青海)' WHERE shortname = 'CN-QH';" -q -n -o create_db.log

echo "Adding lat/long to final geometries"
psql -U ecoinvent -d eigeo -c "UPDATE final SET longitude = st_x(st_centroid(geom));" -q -n -o create_db.log
psql -U ecoinvent -d eigeo -c "UPDATE final SET latitude = st_y(st_centroid(geom));" -q -n -o create_db.log

echo "Cleaning up missing attributes"
psql -U ecoinvent -d eigeo -c "UPDATE final SET unregioncode = 0 WHERE unregioncode <= 0;" -q -n -o create_db.log
psql -U ecoinvent -d eigeo -c "UPDATE final SET uncode = 0 WHERE uncode <= 0;" -q -n -o create_db.log

echo "Fixing some names"
psql -U ecoinvent -d eigeo -f sql/fix-names.sql -q -n -o create_db.log

echo "Testing final database integrity"
python python/db_checks_final.py
rc=$?
if [[ $rc != 0 ]] ; then
    exit $rc
fi

echo "Exporting"
python python/export_all.py
psql -U ecoinvent -d eigeo -c "COPY (SELECT uuid, name, shortname, ST_AsKML(geom) as geom, isotwolettercode, longitude, isothreelettercode, latitude FROM final) TO STDOUT WITH CSV;" > output/all.csv

echo "Formatting to Ecospold XML"
python python/write_xml.py
