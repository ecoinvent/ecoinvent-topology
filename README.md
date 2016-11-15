# Constructive Geometries #

This repository contains the scripts and data needed to build a consistent topology of the world (provinces, countries, and states), needed for the ecoinvent life cycle inventory database. It also includes the ability to define recipes to generate custom locations.

The repository is a mix of SQL, bash scripts, and Python. See the file "topology-journal.rst" for instructions and journal of what was done and why.

## Python requirements

The Python code is compatible with Python >= 3.4. It requires the following libraries:

* lxml
* fastkml
* fiona
* shapely
* pyprind
* babel

## Setting up the Postgresql database

Make sure you have a recent version of Postgresql and the Postgis extension installed, and then create the `ecoinvent` user:

    createuser --superuser ecoinvent -U postgres

You are then ready to run the `create_db.sh` script, which create the postgis-enable database and build all recipes.

## Exporting selected geometries

Modify this command to get the names you want:

    psql -U ecoinvent -d eigeo -c "COPY (SELECT uuid, name, shortname, ST_AsKML(geom) as geom, isotwolettercode, longitude, isothreelettercode, latitude FROM final WHERE name in ('foo', 'bar')) TO STDOUT WITH CSV;" > output/all.csv

Then run:

    python python/write_xml.py
