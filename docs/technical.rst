Technical guide to working with the ``Constructive Geometries`` package
=======================================================================

Operating systems
-----------------

OS X and Any-nix should be fine; bash shell scripts are used extensively, so considerable work would be needed to get everything running on Windows.

Installation requirements
-------------------------

Python dependencies
```````````````````

CG is currently only compatible with Python 2.7

* babel
* fastkml
* fiona
* lxml
* progressbar
* shapely
* unicodecsv

PostGIS
```````

PostgreSQL >= 9.4, Postgis >= 2.1, with ``postgis`` and ``postgis_topology`` extensions installed.

You must have a Postgresql user named "ecoinvent" who can create tables.

Shell scripts
-------------

``create_db.sh`` should do everything. This is the default, and it will call the the other scripts listed below.

