#!/bin/bash
# This script deletes the 'final' geometries table and rebuilds all recipes,
# then exports everything.

echo "Testing consistency between recipe and UUID config files"
python python/recipe_mapping_consistency.py
rc=$?
if [[ $rc != 0 ]] ; then
    exit $rc
fi

echo "Resetting 'final' database table"
psql -U ecoinvent -d eigeo -f sql/reset_final.sql -q -n -o create_db.log

echo "Building country geometries"
psql -U ecoinvent -d eigeo -f sql/build_countries.sql -q -n -o create_db.log

echo "Add Canadian provinces"
echo "Add American states"
echo "Add Australian states"
echo "Add Brazilian states"
echo "Add Indian states and union territories"
echo "Add Chinese provinces"
psql -U ecoinvent -d eigeo -f sql/add_states_provinces.sql -q -n -o create_db.log

echo "Compiling recipes"
python python/parse_recipes.py

echo "Building final geometries"
psql -U ecoinvent -d eigeo -f sql/recipes.sql -q -n -o create_db.log

echo "Adding lat/long to final geometries"
psql -U ecoinvent -d eigeo -c "UPDATE final SET longitude = st_x(st_centroid(geom));" -q -n -o create_db.log
psql -U ecoinvent -d eigeo -c "UPDATE final SET latitude = st_y(st_centroid(geom));" -q -n -o create_db.log

echo "Adding shortnames and UUIDS"
python python/parse_uuids.py
psql -U ecoinvent -d eigeo -f sql/uuids.sql -q -n -o create_db.log

mkdir -p output

echo "Testing final database integrity"
psql -U ecoinvent -d eigeo -c "COPY (SELECT name, GetTopoGeomElementArray(topogeom) as faces FROM geometries WHERE tname = 'ne_countries') TO STDOUT WITH CSV;" > output/faces-check.csv
python python/db_checks_final.py
rc=$?
if [[ $rc != 0 ]] ; then
    exit $rc
fi
rm output/faces-check.csv

echo "Exporting"
python python/export_all.py

echo "Formatting to Ecospold XML"
psql -U ecoinvent -d eigeo -c "COPY (SELECT uuid, name, shortname, ST_AsKML(geom) as geom, isotwolettercode, longitude, isothreelettercode, latitude FROM final) TO STDOUT WITH CSV;" > output/all.csv
python python/write_xml.py
bzip2 -f output/Geographies.xml
