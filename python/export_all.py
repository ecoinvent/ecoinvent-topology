import subprocess
import shutil
import os

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

shutil.rmtree("output")
os.mkdir("output")

for collection in collections:
    subprocess.Popen(command.format(
            format="GPKG",
            collection=collection,
            extension='gpkg',
            layername=collection.replace("-", "_").replace(" ", "_"),
        ), shell=True
    )

# print command.format(format="GeoJSON", collection=collection, extension='json')
# formats = [
#     # ogr format, extension
#     ("GeoJSON", "geojson"),
#     ("GPKG", "gpkg"),
#     ("GPKG", "ESRI Shapefile"),
# ]

