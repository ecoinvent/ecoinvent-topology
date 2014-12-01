import bz2
import os
import shutil
import subprocess
import time

cwd = os.getcwd()

collections = [
    "aluminium",
    "countries",
    "electricity",
    "legacy",
    "only-europe",
    "russia",
    "special",
    "states",
    "un-regions",
    "un-subregions",
    "usa-electricity",
    "all",
]

command = """ogr2ogr -f {format} output/{collection}.{extension} "PG:host=localhost dbname=eigeo user=ecoinvent" -sql "select * from final where collection = '{collection}'" -nln {layername} """

all_command = """ogr2ogr -f {format} output/{collection}.{extension} "PG:host=localhost dbname=eigeo user=ecoinvent" -sql "select * from final" -nln allgeos """

shp_command = """ogr2ogr -f "ESRI Shapefile" output/{layername}/{collection}.shp "PG:host=localhost dbname=eigeo user=ecoinvent" -sql "select * from final where collection = '{collection}'" -nln {layername} """

all_shp_command = """ogr2ogr -f "ESRI Shapefile" output/{layername}/{collection}.shp "PG:host=localhost dbname=eigeo user=ecoinvent" -sql "select * from final" -nln allgeos """

bz2_command = "bzip2 {path}"

if "output" in os.listdir("."):
    shutil.rmtree("output")
os.mkdir("output")

formats = [
    ("GeoJSON", "geojson"),
    ("GPKG", "gpkg"),
    ("KML", "kmz"),
]


for format, extension in formats:
    for collection in collections:
        if collection == "all":
            cmnd = all_command
        else:
            cmnd = command
        subprocess.check_call(cmnd.format(
                format=format,
                collection=collection,
                extension=extension,
                layername=collection.replace("-", "_").replace(" ", "_"),
            ), shell=True
        )
        if extension == 'geojson':
            subprocess.Popen(bz2_command.format(path="output/" + collection + ".geojson"), shell=True)


for collection in collections:
    layername = collection.replace("-", "_").replace(" ", "_")
    os.mkdir("output/" + layername)
    if collection == "all":
        cmnd = all_shp_command
    else:
        cmnd = shp_command
    subprocess.check_call(cmnd.format(
            format=format,
            collection=collection,
            layername=layername,
        ), shell=True, stderr=open(os.devnull, 'wb')
    )
    subprocess.check_call("cd output && zip -q -r {d}.zip {d}".format(d=layername), shell=True)
    shutil.rmtree("output/{d}".format(d=layername))
