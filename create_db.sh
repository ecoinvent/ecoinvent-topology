#!/bin/bash
if test -f create_db.log; then
    rm create_db.log
fi

echo "Creating database and tables"
psql -U ecoinvent -d template1 -f sql/reset_database.sql -q -n -o create_db.log
psql -U ecoinvent -d eigeo -f sql/create-tables.sql -q -n -o create_db.log
psql -U ecoinvent -d eigeo -f sql/create-functions.sql -q -n -o create_db.log

echo "Retrieving latest NERC region data"
if test -f data/intermediate/nerc_regions.gpkg; then
    rm data/intermediate/nerc_regions.gpkg
fi
wget -q https://github.com/cmutel/nerc-regions/raw/master/data/output/nerc_regions.gpkg -P data/intermediate/

echo "Importing raw GIS country/province/state data"
psql -U ecoinvent -d eigeo -f sql/ne_countries.sql -q -n -o create_db.log
psql -U ecoinvent -d eigeo -f sql/ne_provinces.sql -q -n -o create_db.log

# echo "Adding 'skip' column to provinces table"
# psql -U ecoinvent -d eigeo -c "ALTER TABLE ne_provinces ADD COLUMN \"skip\" BOOLEAN DEFAULT false;" -q -n -o create_db.log

# In cases where provinces or dependencies have ISO codes, we generally separate
# them out as separate entries in the ne_countries table.
echo "Fixing province mismatches with countries"
psql -U ecoinvent -d eigeo -v ON_ERROR_STOP=1 -f sql/province_country_mismatchs.sql -q -n -o create_db.log

echo "Change or update country names"
psql -U ecoinvent -d eigeo -f sql/update_names.sql -q -n -o create_db.log

echo "Add missing ISO codes & substitutes"
psql -U ecoinvent -d eigeo -f sql/missing-codes.sql -q -n -o create_db.log

echo "Adding US NERC regions"
ogr2ogr -f PGDump sql/nerc.sql data/intermediate/nerc_regions.gpkg -nln nerc -lco SRID=4326 -lco GEOMETRY_NAME=geom -lco DIM=2 -s_srs "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs" -t_srs "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs" -dim 2 -unsetFid
echo "SET client_min_messages TO WARNING;
$(cat sql/nerc.sql)" > sql/nerc.sql
psql -U ecoinvent -d eigeo -f sql/nerc.sql -q -n -o create_db.log

echo "Creating topo geometries"
psql -U ecoinvent -d eigeo -f sql/to_topological_geometries.sql -q -n -o create_db.log

echo "Eliminating duplicate nodes"
python python/eliminate_nodes.py

# echo "Adding outdated NERC regions"
# ogr2ogr -f PGDump sql/nerc_outdated.sql data/intermediate/nerc_outdated.gpkg -nln nerc_outdated -lco SRID=4326 -lco GEOMETRY_NAME=geom -lco DIM=2 -s_srs "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs" -t_srs "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs" -dim 2 -unsetFid
# psql -U ecoinvent -d eigeo -f sql/nerc_outdated.sql -q -n -o create_db.log

echo "Testing database integrity"
python python/db_checks.py
rc=$?
if [[ $rc != 0 ]] ; then
    exit $rc
fi

echo "Building countries and recipes"
source build_recipes.sh
