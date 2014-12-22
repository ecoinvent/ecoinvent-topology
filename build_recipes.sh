#!/bin/bash
# This script deletes the 'final' geometries table and rebuilds all recipes,
# then exports everything.

echo "Resetting 'final' database table"
psql -U ecoinvent -d eigeo -f sql/reset-final.sql -q -n -o create_db.log

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
psql -U ecoinvent -d eigeo -c "UPDATE final SET name = 'Heilongjiang (黑龙江省)' WHERE name = 'Heilongjiang (黑龍江省)';" -q -n -o create_db.log

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

echo "Formatting to Ecospold XML"
psql -U ecoinvent -d eigeo -c "COPY (SELECT uuid, name, shortname, ST_AsKML(geom) as geom, isotwolettercode, longitude, isothreelettercode, latitude FROM final) TO STDOUT WITH CSV;" > output/all.csv
python python/write_xml.py