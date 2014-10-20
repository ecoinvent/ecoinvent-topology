Create the ecoinvent world in the command line
==============================================

These assume the following:

1. You have python installed on your machine
2. You have Postgresql and PostGIS installed on your machine
3. You have a Postgresql user named "ecoinvent" who can create tables

The following commands, run in sequence, should create the ecoinvent geographies database.

unzip data/raw/ne_10m_admin_0_countries.zip -d data/countries
unzip data/raw/ne_10m_admin_0_sovereignty.zip -d data/states
unzip data/raw/ne_10m_admin_1_states_provinces.zip -d data/provinces
shp2pgsql -s 4326 data/countries/ne_10m_admin_0_countries.shp ne_countries > sql/ne_countries.sql
shp2pgsql -s 4326 data/states/ne_10m_admin_0_sovereignty.shp ne_states > sql/ne_states.sql
shp2pgsql -s 4326 data/provinces/ne_10m_admin_1_states_provinces.shp ne_provinces > sql/ne_provinces.sql

psql -U ecoinvent -d template1 -c "DROP DATABASE eigeo;"
psql -U ecoinvent -d template1 -c "CREATE DATABASE eigeo WITH OWNER = ecoinvent ENCODING = 'UTF8';"
psql -U ecoinvent -d template1 -c "ALTER DATABASE eigeo SET search_path = public, topology;"
psql -U ecoinvent -d eigeo -c "CREATE EXTENSION postgis;"
psql -U ecoinvent -d eigeo -c "CREATE EXTENSION postgis_topology;"
psql -U ecoinvent -d eigeo -c "SELECT CreateTopology('ei_topo', 4326);"

psql -U ecoinvent -d eigeo -f sql/ne_countries.sql -q
psql -U ecoinvent -d eigeo -f sql/ne_states.sql -q
psql -U ecoinvent -d eigeo -f sql/ne_provinces.sql -q

echo "Fix problem with one province self-intersecting ring"
psql -U ecoinvent -d eigeo -c "update ne_provinces set geom = ST_MakeValid(geom) where ST_IsValid(geom) = False;"

echo "Create geometries table"
psql -U ecoinvent -d eigeo -f sql/create-topo-table.sql -q

echo "This will take some time; An error will be raised for Paphos - it can be ignored"
psql -U ecoinvent -d eigeo -f sql/create-topos-provinces.sql -q
psql -U ecoinvent -d eigeo -f sql/create-topos-countries.sql -q
psql -U ecoinvent -d eigeo -f sql/create-topos-states.sql -q

echo "Getting and processing cutout geometries"
psql -U ecoinvent -d eigeo -f sql/create-cutouts-table.sql -q

echo "Processing individual cutouts"

echo "SPP"
ogr2ogr -f PGDump sql/cutouts/spp.sql data/intermediate/spp.gpkg -lco CREATE_TABLE=OFF -lco SRID=4326 -lco GEOMETRY_NAME=geom -lco DIM=2
sed -i '' 's/"public"."spp"/"public"."cutouts"/g' sql/cutouts/spp.sql
ogr2ogr -f PGDump sql/cutouts/spp_texas.sql data/intermediate/spp_texas.gpkg -lco CREATE_TABLE=OFF -lco SRID=4326 -lco GEOMETRY_NAME=geom -lco DIM=2
sed -i '' 's/"public"."spp_texas"/"public"."cutouts"/g' sql/cutouts/spp_texas.sql
sed -i '' 's/Southwest Power Pool/SPP (Texas)/g' sql/cutouts/spp_texas.sql
psql -U ecoinvent -d eigeo -f sql/cutouts/spp.sql -q
psql -U ecoinvent -d eigeo -f sql/cutouts/spp_texas.sql -q

echo "SERC"
ogr2ogr -f PGDump sql/cutouts/serc.sql data/intermediate/serc.gpkg -lco CREATE_TABLE=OFF -lco SRID=4326 -lco GEOMETRY_NAME=geom -lco DIM=2
sed -i '' 's/"public"."serc"/"public"."cutouts"/g' sql/cutouts/serc.sql
psql -U ecoinvent -d eigeo -f sql/cutouts/serc.sql -q

echo "Midwest (MRO)"
ogr2ogr -f PGDump sql/cutouts/mro.sql data/intermediate/mro.gpkg -lco CREATE_TABLE=OFF -lco SRID=4326 -lco GEOMETRY_NAME=geom -lco DIM=2
sed -i '' 's/"public"."mro"/"public"."cutouts"/g' sql/cutouts/mro.sql
psql -U ecoinvent -d eigeo -f sql/cutouts/mro.sql -q

ogr2ogr -f PGDump sql/cutouts/mro_ill.sql data/intermediate/mro_ill.gpkg -lco CREATE_TABLE=OFF -lco SRID=4326 -lco GEOMETRY_NAME=geom -lco DIM=2
sed -i '' 's/"public"."mro_ill"/"public"."cutouts"/g' sql/cutouts/mro_ill.sql
sed -i '' 's/Midwest Reliability Organization/MRO (Illinois)/g' sql/cutouts/mro_ill.sql
psql -U ecoinvent -d eigeo -f sql/cutouts/mro_ill.sql -q

echo "Western"
ogr2ogr -f PGDump sql/cutouts/wecc_texas.sql data/intermediate/wecc_texas.gpkg -lco CREATE_TABLE=OFF -lco SRID=4326 -lco GEOMETRY_NAME=geom -lco DIM=2
sed -i '' 's/"public"."wecc_texas"/"public"."cutouts"/g' sql/cutouts/wecc_texas.sql
sed -i '' 's/Midwest Reliability Organization/MRO (Illinois)/g' sql/cutouts/mro_ill.sql
psql -U ecoinvent -d eigeo -f sql/cutouts/wecc_texas.sql -q

echo "ReliabilityFirst"
ogr2ogr -f PGDump sql/cutouts/rfc.sql data/intermediate/rfc.gpkg -lco CREATE_TABLE=OFF -lco SRID=4326 -lco GEOMETRY_NAME=geom -lco DIM=2
sed -i '' 's/"public"."rfc"/"public"."cutouts"/g' sql/cutouts/rfc.sql
psql -U ecoinvent -d eigeo -f sql/cutouts/rfc.sql -q

echo "Alaska"
ogr2ogr -f PGDump sql/cutouts/ascc.sql data/intermediate/ascc.gpkg -lco CREATE_TABLE=OFF -lco SRID=4326 -lco GEOMETRY_NAME=geom -lco DIM=2
sed -i '' 's/"public"."ascc"/"public"."cutouts"/g' sql/cutouts/ascc.sql
psql -U ecoinvent -d eigeo -f sql/cutouts/ascc.sql -q

psql -U ecoinvent -d eigeo -c "SELECT EliminateNonBranchingNodes();"

python python/eliminate_nodes.py

psql -U ecoinvent -d eigeo -f sql/simplify.sql -q
