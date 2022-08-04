#!/bin/bash
if test -f create_db.log; then
    rm create_db.log
fi

echo "Creating database and tables"
echo "Ignore error about eigeo not existing if running for first time"
psql -U ecoinvent -d template1 -c "DROP DATABASE eigeo;" -q -n -o create_db.log
psql -U ecoinvent -d template1 -c "CREATE DATABASE eigeo WITH OWNER = ecoinvent ENCODING = 'UTF8';" -q -n -o create_db.log
psql -U ecoinvent -d template1 -c "ALTER DATABASE eigeo SET search_path = public, topology;" -q -n -o create_db.log
psql -U ecoinvent -d eigeo -c "CREATE EXTENSION postgis;" -q -n -o create_db.log
psql -U ecoinvent -d eigeo -c "CREATE EXTENSION postgis_topology;" -q -n -o create_db.log
psql -U ecoinvent -d eigeo -c "SELECT CreateTopology('ei_topo', 4326);" -q -n -o create_db.log
psql -U ecoinvent -d eigeo -f sql/create-tables.sql -q -n -o create_db.log
psql -U ecoinvent -d eigeo -f sql/create-functions.sql -q -n -o create_db.log

echo "Retrieving latest NERC region data"
if test -f data/intermediate/nerc_regions.gpkg; then
    rm data/intermediate/nerc_regions.gpkg
fi
wget https://github.com/cmutel/nerc-regions/raw/master/data/output/nerc_regions.gpkg -P data/intermediate/

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

echo "Fixing code_hasc columns"
psql -U ecoinvent -d eigeo -c "UPDATE ne_provinces SET code_hasc = REPLACE(code_hasc, '.', '-');" -q -n -o create_db.log

echo "Creating province topos; This will take some time"
psql -U ecoinvent -d eigeo -c "update ne_provinces set geom = st_multi(st_buffer(geom, 0)) where name = 'Paphos';" -q -n -o create_db.log
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

echo "Change or update country names"
psql -U ecoinvent -d eigeo -c "UPDATE geometries SET name = 'Türkiye' WHERE name = 'Turkey';" -q -n -o create_db.log
# Country is correct but not provinces
psql -U ecoinvent -d eigeo -c "UPDATE geometries SET name = 'North Macedonia' WHERE name = 'Macedonia';" -q -n -o create_db.log
psql -U ecoinvent -d eigeo -c "UPDATE geometries SET name = 'Serbia' WHERE name = 'Republic of Serbia';" -q -n -o create_db.log
# Country is correct but not provinces
psql -U ecoinvent -d eigeo -c "UPDATE geometries SET name = 'Czechia' WHERE name = 'Czech Republic';" -q -n -o create_db.log
psql -U ecoinvent -d eigeo -c "update geometries set name = 'Congo, Democratic Republic of the' where name = 'Democratic Republic of the Congo';" -q -n -o create_db.log
psql -U ecoinvent -d eigeo -c "update geometries set name = 'Congo' where name = 'Republic of Congo';" -q -n -o create_db.log
psql -U ecoinvent -d eigeo -c "update geometries set name = 'Micronesia, Federated States of' where name = 'Federated States of Micronesia';" -q -n -o create_db.log
psql -U ecoinvent -d eigeo -c "update geometries set name = 'Tanzania' where name = 'United Republic of Tanzania';" -q -n -o create_db.log
psql -U ecoinvent -d eigeo -c "update geometries set name = 'Aland' where name = 'Åland Islands';" -q -n -o create_db.log
psql -U ecoinvent -d eigeo -c "update geometries set name = 'Australia, Indian Ocean Territories' where name = 'Indian Ocean Territories';" -q -n -o create_db.log
psql -U ecoinvent -d eigeo -c "update geometries set name = 'Australia, Ashmore and Cartier Islands' where name = 'Ashmore and Cartier Islands';" -q -n -o create_db.log

echo "Fixing independent islands"
psql -U ecoinvent -d eigeo -f sql/fix_independent_islands.sql -q -n -o create_db.log

echo "Adding NERC regions"
ogr2ogr -f PGDump sql/nerc.sql data/intermediate/nerc_regions.gpkg -nln nerc -lco SRID=4326 -lco GEOMETRY_NAME=geom -lco DIM=2 -s_srs "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs" -t_srs "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs" -dim 2 -unsetFid
psql -U ecoinvent -d eigeo -f sql/nerc.sql -q -n -o create_db.log

echo "Adding outdated NERC regions"
ogr2ogr -f PGDump sql/nerc_outdated.sql data/intermediate/nerc_outdated.gpkg -nln nerc_outdated -lco SRID=4326 -lco GEOMETRY_NAME=geom -lco DIM=2 -s_srs "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs" -t_srs "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs" -dim 2 -unsetFid
psql -U ecoinvent -d eigeo -f sql/nerc_outdated.sql -q -n -o create_db.log

# echo "Getting and processing cutout geometries"
# echo "SPP"
# ogr2ogr -f PGDump sql/cutouts/spp.sql data/intermediate/spp.gpkg -lco CREATE_TABLE=OFF -lco SRID=4326 -lco GEOMETRY_NAME=geom -lco DIM=2 -s_srs "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs" -t_srs "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs" -dim 2 -unsetFid
# sed -i '' 's/"public"."spp"/"public"."cutouts"/g' sql/cutouts/spp.sql
# ogr2ogr -f PGDump sql/cutouts/spp_texas.sql data/intermediate/spp_texas.gpkg -lco CREATE_TABLE=OFF -lco SRID=4326 -lco GEOMETRY_NAME=geom -lco DIM=2 -s_srs "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs" -t_srs "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs" -dim 2 -unsetFid
# sed -i '' 's/"public"."spp_texas"/"public"."cutouts"/g' sql/cutouts/spp_texas.sql
# sed -i '' 's/Southwest Power Pool/SPP (Texas)/g' sql/cutouts/spp_texas.sql
# psql -U ecoinvent -d eigeo -f sql/cutouts/spp.sql -q -n -o create_db.log
# psql -U ecoinvent -d eigeo -f sql/cutouts/spp_texas.sql -q -n -o create_db.log

# echo "SERC"
# ogr2ogr -f PGDump sql/cutouts/serc.sql data/intermediate/serc.gpkg -lco CREATE_TABLE=OFF -lco SRID=4326 -lco GEOMETRY_NAME=geom -lco DIM=2 -s_srs "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs" -t_srs "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs" -dim 2 -unsetFid
# sed -i '' 's/"public"."serc"/"public"."cutouts"/g' sql/cutouts/serc.sql
# psql -U ecoinvent -d eigeo -f sql/cutouts/serc.sql -q -n -o create_db.log

# echo "Midwest (MRO)"
# ogr2ogr -f PGDump sql/cutouts/mro.sql data/intermediate/mro.gpkg -lco CREATE_TABLE=OFF -lco SRID=4326 -lco GEOMETRY_NAME=geom -lco DIM=2 -s_srs "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs" -t_srs "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs" -dim 2 -unsetFid
# sed -i '' 's/"public"."mro"/"public"."cutouts"/g' sql/cutouts/mro.sql
# psql -U ecoinvent -d eigeo -f sql/cutouts/mro.sql -q -n -o create_db.log

# ogr2ogr -f PGDump sql/cutouts/mro_ill.sql data/intermediate/mro_ill.gpkg -lco CREATE_TABLE=OFF -lco SRID=4326 -lco GEOMETRY_NAME=geom -lco DIM=2 -s_srs "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs" -t_srs "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs" -dim 2 -unsetFid
# sed -i '' 's/"public"."mro_ill"/"public"."cutouts"/g' sql/cutouts/mro_ill.sql
# sed -i '' 's/Midwest Reliability Organization/MRO (Illinois)/g' sql/cutouts/mro_ill.sql
# psql -U ecoinvent -d eigeo -f sql/cutouts/mro_ill.sql -q -n -o create_db.log

# echo "Western"
# ogr2ogr -f PGDump sql/cutouts/wecc_texas.sql data/intermediate/wecc_texas.gpkg -lco CREATE_TABLE=OFF -lco SRID=4326 -lco GEOMETRY_NAME=geom -lco DIM=2 -s_srs "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs" -t_srs "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs" -dim 2 -unsetFid
# sed -i '' 's/"public"."wecc_texas"/"public"."cutouts"/g' sql/cutouts/wecc_texas.sql
# sed -i '' 's/Midwest Reliability Organization/MRO (Illinois)/g' sql/cutouts/mro_ill.sql
# psql -U ecoinvent -d eigeo -f sql/cutouts/wecc_texas.sql -q -n -o create_db.log

# echo "ReliabilityFirst"
# ogr2ogr -f PGDump sql/cutouts/rfc.sql data/intermediate/rfc.gpkg -lco CREATE_TABLE=OFF -lco SRID=4326 -lco GEOMETRY_NAME=geom -lco DIM=2 -s_srs "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs" -t_srs "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs" -dim 2 -unsetFid
# sed -i '' 's/"public"."rfc"/"public"."cutouts"/g' sql/cutouts/rfc.sql
# psql -U ecoinvent -d eigeo -f sql/cutouts/rfc.sql -q -n -o create_db.log

# echo "Alaska"
# ogr2ogr -f PGDump sql/cutouts/ascc.sql data/intermediate/ascc.gpkg -lco CREATE_TABLE=OFF -lco SRID=4326 -lco GEOMETRY_NAME=geom -lco DIM=2 -s_srs "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs" -t_srs "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs" -dim 2 -unsetFid
# sed -i '' 's/"public"."ascc"/"public"."cutouts"/g' sql/cutouts/ascc.sql
# psql -U ecoinvent -d eigeo -f sql/cutouts/ascc.sql -q -n -o create_db.log

# echo "Adding cutout topologies"
# psql -U ecoinvent -d eigeo -f sql/cutouts/process-cutouts.sql -q -n -o create_db.log

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

echo "Remove Cyprus No Mans Land"
psql -U ecoinvent -d eigeo -f sql/cyprus.sql -q -n -o create_db.log

echo "Dealing with colonial legacies"
psql -U ecoinvent -d eigeo -f sql/colonials.sql -q -n -o create_db.log

echo "Add missing ISO codes & substitutes"
psql -U ecoinvent -d eigeo -f sql/missing-codes.sql -q -n -o create_db.log

echo "Fixing Chinese province names"
psql -U ecoinvent -d eigeo -c "UPDATE ne_provinces SET name_local = '黑龙江省' WHERE name = 'Heilongjiang';" -q -n -o create_db.log
psql -U ecoinvent -d eigeo -c "UPDATE ne_provinces SET name_local = '青海' WHERE name = 'Qinghai';" -q -n -o create_db.log

echo "Building countries and recipes"
source build_recipes.sh
