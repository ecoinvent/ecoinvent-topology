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
]

command = """ogr2ogr -f {format} output/{collection}.{extension} "PG:host=localhost dbname=eigeo user=ecoinvent" -sql "select * from final where collection = '{collection}'" -nln {layername} """

shp_command = """ogr2ogr -f "ESRI Shapefile" output/{layername}/{collection}.shp "PG:host=localhost dbname=eigeo user=ecoinvent" -sql "select * from final where collection = '{collection}'" -nln {layername} """

bz2_command = "bzip2 {path}"

shutil.rmtree("output")
os.mkdir("output")

formats = [
    ("GeoJSON", "geojson"),
    ("GPKG", "gpkg"),
]


for format, extension in formats:
    for collection in collections:
        subprocess.check_call(command.format(
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
    subprocess.check_call(shp_command.format(
            format=format,
            collection=collection,
            layername=layername,
        ), shell=True, stderr=open(os.devnull, 'wb')
    )
    subprocess.check_call("cd output && zip -q -r {d}.zip {d}".format(d=layername), shell=True)
    shutil.rmtree("output/{d}".format(d=layername))
