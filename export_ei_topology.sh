#!/bin/bash
echo "Dumping all topology faces"
ogr2ogr -f GPKG output/faces.gpkg "PG:host=localhost dbname=eigeo user=ecoinvent" -sql "select face_id as id, ST_GetFaceGeometry('ei_topo', face_id) as geom from ei_topo.face where face_id > 0 order by face_id" -nln all_faces

echo "Export face ids and processing"
psql -U ecoinvent -d eigeo -c "COPY (SELECT shortname, faces FROM final) TO STDOUT WITH CSV;" > output/faces.csv
python python/process_face_ids.py

echo "Created the following files:"
echo "output/faces.gpkg. The Geopackage of all faces in ecoinvent."
echo "output/faces.json. The file linking ecoinvent geometries to face ids."
