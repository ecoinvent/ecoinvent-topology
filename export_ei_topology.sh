#!/bin/bash
echo "Creating new topology and topology column"
psql -U ecoinvent -d eigeo -c "SELECT topology.DropTopology('ei_final');" -q -n -o create_db.log
psql -U ecoinvent -d eigeo -c "VACUUM FULL;" -q -n -o create_db.log
psql -U ecoinvent -d eigeo -c "SELECT CreateTopology('ei_final', 4326);" -q -n -o create_db.log
psql -U ecoinvent -d eigeo -c "SELECT AddTopoGeometryColumn('ei_final', 'public', 'final', 'topogeom', 'MULTIPOLYGON');" -q -n -o create_db.log

echo "Adding final topographies... this will take a long time"
python python/final_topology.py

echo "Dumping all topology faces"
ogr2ogr -f GPKG output/faces.gpkg "PG:host=localhost dbname=eigeo user=ecoinvent" -sql "select face_id as id, ST_GetFaceGeometry('ei_final', face_id) as geom from ei_final.face where face_id > 0" -nln all_faces

echo "Export face ids and processing"
psql -U ecoinvent -d eigeo -c "COPY (SELECT name, GetTopoGeomElementArray(topogeom) as faces FROM final) TO STDOUT WITH CSV;" > output/faces.csv
python python/process_face_ids.py

echo "Created the following files:"
echo "output/faces.gpkg. The Geopackage of all faces in ecoinvent."
echo "output/faces.json. The file linking ecoinvent geometries to face ids."
