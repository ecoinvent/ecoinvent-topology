# Constructive Geometries #

This repository contains the scripts and data needed to build a consistent topology of the world (provinces, countries, and states), needed for the ecoinvent life cycle inventory database. It also includes the ability to define recipes to generate custom locations.

The repository is a mix of SQL, bash scripts, and Python. See the file "topology-journal.rst" for instructions and journal of what was done and why.

This repository is **not** the `constructive_geometries` Python library! That one [lives here](https://github.com/cmutel/constructive_geometries).

## Python requirements

The Python code is compatible with Python >= 3.4. It requires the following libraries:

* lxml
* fastkml
* fiona
* shapely
* tqdm
* babel

## Setting up the Postgresql database

Make sure you have a recent version of Postgresql installed, and `postgis` is available (it will be activated automatically). Create the `ecoinvent` user:

    createuser --superuser ecoinvent -U postgres

Then import the base data:

    ./create_db.sh

## Creating ecoinvent geoemetries

Run the script `./build_recipes.sh`. Note that this is called automatically when running `create_db.sh`.

## Adding a new geometry

#. You need the short and long name. Create if not provided.
#. Create a new UUID: `python python/new_uuid.py`
#. Edit the file `data/config/uuid-mapping.json`, and add your new location to an appropriate section. Follow the existing style, you will provide the name, shortname, and UUID you just generated. Check to make sure you included a comma at the end of the new section.
#. Run the script `python python/reindent_uuids.py` to make sure you got the syntax correct. Fix any errors.
#. Edit the file `data/config/recipes.json`, and add your new recipe using the `name` (not the `shortname`), and the list of *included* regions. Make sure to include states in cases where only part of the country should be included (like Russia, China, Brazil, India). You can include the whole country if appropriate.
#. Run the script `python python/reindent_recipes.py` to make sure you got the syntax correct. Fix any errors.
#. Run the script `build_recipes.sh`.
#. Update the documentation in `docs/index.rst` as appropriate. Make sure to note changes in the changelog. Build the docuementation (`make html`), and sync to webserver (`sync.sh`).
#. Export selected geometries. Modify this command to get the names you want:

    psql -U ecoinvent -d eigeo -c "COPY (SELECT uuid, name, shortname, ST_AsKML(geom) as geom, isotwolettercode, longitude, isothreelettercode, latitude FROM final WHERE name = 'Europe without Switzerland and Austria') TO STDOUT WITH CSV;" > output/all.csv

#. Convert export to XML:

    python python/write_xml.py

#. Email the `Geographies.xml` file to ecoinvent database manager.
