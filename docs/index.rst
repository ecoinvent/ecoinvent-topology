Ecoinvent geography definitions
===============================

.. note:: This is a draft report.

Details of geographic locations in Ecospold2
Outline for geography report

Introduction
------------

The ecoinvent centre provide consistent and comprehensive geodata for the locations used in the ecoinvent database. This document describes how these location geometries are created and processed, and gives details on particular locations that may be confusing.

Purpose of location descriptions in ecoinvent
---------------------------------------------

Statement on geographical controversies
---------------------------------------

Neither the EcoSpold 2 data format, nor its authors, take any position on geographical areas of controversy. The geographical shapes presented in the EcoSpold 2 data files should not be taken as absolute definitions of country or region borders. Rather, they are approximations consistent with common understanding of these countries and regions, for use in a life cycle inventory database. If subjective judgments have to be made, we have made choices based on our understanding of what would be best for clear and understandable life cycle inventories. If you find a error or discrepancy in the base data file, please let us know by `filing a bug <https://bitbucket.org/cmutel/constructive-geometries/issues/new>`_.

Data formats
------------

+------------------------------------------+---------------------------------------------------------------------------------------+-----------------------------------------------------------------------------------+---------------------------------------------------------------------------+--------------------------------------------------------------------------------------------+
| Description                              | `GeoJSON <http://geojson.org/>`__                                                     | `Geopackage <http://www.geopackage.org/>`__                                       | `KMZ <http://en.wikipedia.org/wiki/Keyhole_Markup_Language>`__            | `ESRI Shapefile <http://en.wikipedia.org/wiki/Shapefile>`__                                |
+==========================================+=======================================================================================+===================================================================================+===========================================================================+============================================================================================+
| All locations                            | `GeoJSON <http://geography.ecoinvent.org/report/files/all.geojson.bz2>`__             | `Geopackage <http://geography.ecoinvent.org/report/files/all.gpkg>`__             | `KMZ <http://geography.ecoinvent.org/report/files/all.kmz>`__             | `ESRI Shapefile <http://geography.ecoinvent.org/report/files/all.zip>`__                   |
+------------------------------------------+---------------------------------------------------------------------------------------+-----------------------------------------------------------------------------------+---------------------------------------------------------------------------+--------------------------------------------------------------------------------------------+
| Countries                                | `GeoJSON <http://geography.ecoinvent.org/report/files/countries.geojson.bz2>`__       | `Geopackage <http://geography.ecoinvent.org/report/files/countries.gpkg>`__       | `KMZ <http://geography.ecoinvent.org/report/files/countries.kmz>`__       | `ESRI Shapefile <http://geography.ecoinvent.org/report/files/countries.zip>`__             |
+------------------------------------------+---------------------------------------------------------------------------------------+-----------------------------------------------------------------------------------+---------------------------------------------------------------------------+--------------------------------------------------------------------------------------------+
| UN regions                               | `GeoJSON <http://geography.ecoinvent.org/report/files/un-regions.geojson.bz2>`__      | `Geopackage <http://geography.ecoinvent.org/report/files/un-regions.gpkg>`__      | `KMZ <http://geography.ecoinvent.org/report/files/un-regions.kmz>`__      | `ESRI Shapefile <http://geography.ecoinvent.org/report/files/un-subregions.geojson.bz2>`__ |
+------------------------------------------+---------------------------------------------------------------------------------------+-----------------------------------------------------------------------------------+---------------------------------------------------------------------------+--------------------------------------------------------------------------------------------+
| UN subregions                            | `GeoJSON <http://geography.ecoinvent.org/report/files/un-subregions.gpkg>`__          | `Geopackage <http://geography.ecoinvent.org/report/files/un-subregions.kmz>`__    | `KMZ <http://geography.ecoinvent.org/report/files/un_regions.zip>`__      | `ESRI Shapefile <http://geography.ecoinvent.org/report/files/un_subregions.zip>`__         |
+------------------------------------------+---------------------------------------------------------------------------------------+-----------------------------------------------------------------------------------+---------------------------------------------------------------------------+--------------------------------------------------------------------------------------------+
| Electricity networks                     | `GeoJSON <http://geography.ecoinvent.org/report/files/electricity.geojson.bz2>`__     | `Geopackage <http://geography.ecoinvent.org/report/files/electricity.gpkg>`__     | `KMZ <http://geography.ecoinvent.org/report/files/electricity.kmz>`__     | `ESRI Shapefile <http://geography.ecoinvent.org/report/files/electricity.zip>`__           |
+------------------------------------------+---------------------------------------------------------------------------------------+-----------------------------------------------------------------------------------+---------------------------------------------------------------------------+--------------------------------------------------------------------------------------------+
| Legacy Electricity networks              | `GeoJSON <http://geography.ecoinvent.org/report/files/legacy.geojson.bz2>`__          | `Geopackage <http://geography.ecoinvent.org/report/files/legacy.gpkg>`__          | `KMZ <http://geography.ecoinvent.org/report/files/legacy.kmz>`__          | `ESRI Shapefile <http://geography.ecoinvent.org/report/files/legacy.zip>`__                |
+------------------------------------------+---------------------------------------------------------------------------------------+-----------------------------------------------------------------------------------+---------------------------------------------------------------------------+--------------------------------------------------------------------------------------------+
| Electricity networks (USA only)          | `GeoJSON <http://geography.ecoinvent.org/report/files/usa-electricity.geojson.bz2>`__ | `Geopackage <http://geography.ecoinvent.org/report/files/usa-electricity.gpkg>`__ | `KMZ <http://geography.ecoinvent.org/report/files/usa-electricity.kmz>`__ | `ESRI Shapefile <http://geography.ecoinvent.org/report/files/usa_electricity.zip>`__       |
+------------------------------------------+---------------------------------------------------------------------------------------+-----------------------------------------------------------------------------------+---------------------------------------------------------------------------+--------------------------------------------------------------------------------------------+
| Aluminium-producing regions              | `GeoJSON <http://geography.ecoinvent.org/report/files/aluminium.geojson.bz2>`__       | `Geopackage <http://geography.ecoinvent.org/report/files/aluminium.gpkg>`__       | `KMZ <http://geography.ecoinvent.org/report/files/aluminium.kmz>`__       | `ESRI Shapefile <http://geography.ecoinvent.org/report/files/aluminium.zip>`__             |
+------------------------------------------+---------------------------------------------------------------------------------------+-----------------------------------------------------------------------------------+---------------------------------------------------------------------------+--------------------------------------------------------------------------------------------+
| Europe/Asia                              | `GeoJSON <http://geography.ecoinvent.org/report/files/only-europe.geojson.bz2>`__     | `Geopackage <http://geography.ecoinvent.org/report/files/only-europe.gpkg>`__     | `KMZ <http://geography.ecoinvent.org/report/files/only-europe.kmz>`__     | `ESRI Shapefile <http://geography.ecoinvent.org/report/files/only_europe.zip>`__           |
+------------------------------------------+---------------------------------------------------------------------------------------+-----------------------------------------------------------------------------------+---------------------------------------------------------------------------+--------------------------------------------------------------------------------------------+
| Russia                                   | `GeoJSON <http://geography.ecoinvent.org/report/files/russia.geojson.bz2>`__          | `Geopackage <http://geography.ecoinvent.org/report/files/russia.gpkg>`__          | `KMZ <http://geography.ecoinvent.org/report/files/russia.kmz>`__          | `ESRI Shapefile <http://geography.ecoinvent.org/report/files/russia.zip>`__                |
+------------------------------------------+---------------------------------------------------------------------------------------+-----------------------------------------------------------------------------------+---------------------------------------------------------------------------+--------------------------------------------------------------------------------------------+
| Ecoinvent special                        | `GeoJSON <http://geography.ecoinvent.org/report/files/special.geojson.bz2>`__         | `Geopackage <http://geography.ecoinvent.org/report/files/special.gpkg>`__         | `KMZ <http://geography.ecoinvent.org/report/files/special.kmz>`__         | `ESRI Shapefile <http://geography.ecoinvent.org/report/files/special.zip>`__               |
+------------------------------------------+---------------------------------------------------------------------------------------+-----------------------------------------------------------------------------------+---------------------------------------------------------------------------+--------------------------------------------------------------------------------------------+
| Canadian provinces and Australian states | `GeoJSON <http://geography.ecoinvent.org/report/files/states.geojson.bz2>`__          | `Geopackage <http://geography.ecoinvent.org/report/files/states.gpkg>`__          | `KMZ <http://geography.ecoinvent.org/report/files/states.kmz>`__          | `ESRI Shapefile <http://geography.ecoinvent.org/report/files/states.zip>`__                |
+------------------------------------------+---------------------------------------------------------------------------------------+-----------------------------------------------------------------------------------+---------------------------------------------------------------------------+--------------------------------------------------------------------------------------------+

Methdology
----------

The primary data source for the ecoinvent geodata is the `Natural Earth data <http://www.naturalearthdata.com/>`_, and in particular the `1:10 million cultural vectors, including boundary lakes <http://www.naturalearthdata.com/downloads/10m-cultural-vectors/>`_.

- Custom drawn geometries

List of locations in ecoinvent
------------------------------

Changelog
---------

Version 2.0 (ecoinvent 3.2)
+++++++++++++++++++++++++++

The following locations were added:

* `Akrotiri Sovereign Base Area <http://en.wikipedia.org/wiki/Akrotiri_and_Dhekelia>`__
* `Ashmore and Cartier Islands <http://en.wikipedia.org/wiki/Ashmore_and_Cartier_Islands>`__
* `Bajo Nuevo Bank (Petrel Is.) <http://en.wikipedia.org/wiki/Bajo_Nuevo_Bank>`__
* Caribbean (UN subregion)
* `Clipperton Island <http://en.wikipedia.org/wiki/Clipperton_Island>`__
* `Coral Sea Islands <http://en.wikipedia.org/wiki/Coral_Sea_Islands>`__
* `Cyprus No Mans Area <http://en.wikipedia.org/wiki/United_Nations_Buffer_Zone_in_Cyprus>`__
* `Dhekelia Sovereign Base Area <http://en.wikipedia.org/wiki/Akrotiri_and_Dhekelia>`__
* `Indian Ocean Territories <http://en.wikipedia.org/wiki/Australian_Indian_Ocean_Territories>`__
* `Kosovo <http://en.wikipedia.org/wiki/Kosovo>`__
* `Northern Cyprus <http://en.wikipedia.org/wiki/Northern_Cyprus>`__
* Russia (Asia)
* Russia (Europe)
* `Scarborough Reef <http://en.wikipedia.org/wiki/Scarborough_Shoal>`__
* `Serranilla Bank <http://en.wikipedia.org/wiki/Serranilla_Bank>`__
* `Siachen Glacier <http://en.wikipedia.org/wiki/Siachen_Glacier>`__
* `Somaliland <http://en.wikipedia.org/wiki/Somaliland>`__
* `US Naval Base Guantanamo Bay <http://en.wikipedia.org/wiki/Guantanamo_Bay_Naval_Base>`__

The following names were changed, mostly due to changes in the source data, or to choose the common instead of formal names:

+------------------------------------------+---------------------------------------------------------+
| New name                                 | Old name                                                |
+==========================================+=========================================================+
| Al producing Area 8, Gulf Region         | Al producing Area 8, Gulf-Aluminium Council/Gulf Region |
+------------------------------------------+---------------------------------------------------------+
| Aland                                    | Åland Islands                                           |
+------------------------------------------+---------------------------------------------------------+
| Bolivia                                  | Bolivia, Plurinational State of                         |
+------------------------------------------+---------------------------------------------------------+
| Bonaire, Saint Eustatius and Saba        | Bonaire, Sint Eustatius, and Saba                       |
+------------------------------------------+---------------------------------------------------------+
| British Virgin Islands                   | Virgin Islands, British                                 |
+------------------------------------------+---------------------------------------------------------+
| Brunei                                   | Brunei Darussalam                                       |
+------------------------------------------+---------------------------------------------------------+
| East Timor                               | Timor-Leste                                             |
+------------------------------------------+---------------------------------------------------------+
| Falkland Islands                         | Falkland Islands (Malvinas)                             |
+------------------------------------------+---------------------------------------------------------+
| French Southern and Antarctic Lands      | French Southern Territories                             |
+------------------------------------------+---------------------------------------------------------+
| Guinea Bissau                            | Guinea-Bissau                                           |
+------------------------------------------+---------------------------------------------------------+
| Hong Kong S.A.R.                         | Hong Kong                                               |
+------------------------------------------+---------------------------------------------------------+
| Iran                                     | Iran (Islamic Republic of)                              |
+------------------------------------------+---------------------------------------------------------+
| Ivory Coast                              | Cote d'Ivoire                                           |
+------------------------------------------+---------------------------------------------------------+
| Laos                                     | Lao People's Democratic Republic                        |
+------------------------------------------+---------------------------------------------------------+
| Macao S.A.R                              | Macau                                                   |
+------------------------------------------+---------------------------------------------------------+
| Macedonia                                | Macedonia, the Former Yugoslav Republic of              |
+------------------------------------------+---------------------------------------------------------+
| Moldova                                  | Moldova, Republic of                                    |
+------------------------------------------+---------------------------------------------------------+
| North Korea                              | Korea, Democratic People's Republic of                  |
+------------------------------------------+---------------------------------------------------------+
| Palestine                                | Palestinian Territory, Occupied                         |
+------------------------------------------+---------------------------------------------------------+
| Pitcairn Islands                         | Pitcairn                                                |
+------------------------------------------+---------------------------------------------------------+
| Réunion                                  | Reunion                                                 |
+------------------------------------------+---------------------------------------------------------+
| Russia                                   | Russian Federation                                      |
+------------------------------------------+---------------------------------------------------------+
| South Georgia and South Sandwich Islands | South Georgia and the South Sandwich Islands            |
+------------------------------------------+---------------------------------------------------------+
| South Korea                              | Korea, Republic of                                      |
+------------------------------------------+---------------------------------------------------------+
| Southern Asia                            | South Asia                                              |
+------------------------------------------+---------------------------------------------------------+
| Syria                                    | Syrian Arab Republic                                    |
+------------------------------------------+---------------------------------------------------------+
| Taiwan                                   | Taiwan, Province of China                               |
+------------------------------------------+---------------------------------------------------------+
| Tanzania                                 | Tanzania, United Republic Of                            |
+------------------------------------------+---------------------------------------------------------+
| The Bahamas                              | Bahamas                                                 |
+------------------------------------------+---------------------------------------------------------+
| United States of America                 | United States                                           |
+------------------------------------------+---------------------------------------------------------+
| United States Virgin Islands             | Virgin Islands, U.S.                                    |
+------------------------------------------+---------------------------------------------------------+
| Vatican                                  | Holy See (Vatican City State)                           |
+------------------------------------------+---------------------------------------------------------+
| Vietnam                                  | Viet Nam                                                |
+------------------------------------------+---------------------------------------------------------+
| Yukon                                    | Yukon Territory                                         |
+------------------------------------------+---------------------------------------------------------+

The following locations have been removed:

+----------------------------------------+----------------------------------------------------------------------------------------------------+
| Location                               | Comment                                                                                            |
+========================================+====================================================================================================+
| Bouvet Island                          | Now included in Norway                                                                             |
+----------------------------------------+----------------------------------------------------------------------------------------------------+
| Central and Eastern Europe             | Not used                                                                                           |
+----------------------------------------+----------------------------------------------------------------------------------------------------+
| Christmas Island                       | Now included in Indian Ocean Territories                                                           |
+----------------------------------------+----------------------------------------------------------------------------------------------------+
| Cocos (Keeling) Islands                | Now included in "Indian Ocean Territories"                                                         |
+----------------------------------------+----------------------------------------------------------------------------------------------------+
| France, including overseas territories | Should not have been included. France is given separately from French Guiana, Reunion, etc.        |
+----------------------------------------+----------------------------------------------------------------------------------------------------+
| Spain, including overseas territories  | Should not have been included. It is easier to always include Spain's exclaves in Africa in Spain. |
+----------------------------------------+----------------------------------------------------------------------------------------------------+
| Svalbard and Jan Mayen                 | Now included in Norway                                                                             |
+----------------------------------------+----------------------------------------------------------------------------------------------------+
| Tokelau                                | Now included in New Zealand                                                                        |
+----------------------------------------+----------------------------------------------------------------------------------------------------+


.. note:: Kosovo is not yet `completely internationally recognized <en.wikipedia.org/wiki/International_recognition_of_Kosovo>`__

.. note:: Version 1 did not include sovereign military bases, but they are necessary in version 2 for a consistent topology.

Version 1.0 (ecoinvent 3.01 & 3.1)
++++++++++++++++++++++++++++++++++

Initial development. Removal of locations no longer used in the ecoinvent database.

Notes on specific geometries
----------------------------

Some images are large, and can be opened in a separate tab to be seen in full detail.

UN Regions
++++++++++

UN regions and subregions follow the `UN macro geographical regions`_ definitions.

UN regions
^^^^^^^^^^

.. note:: Taiwan is included in the UN region Asia and the UN subregion Eastern Asia, even though it is not officially listed in the UN definitions.

.. image:: images/UN-regions.png
    :align: center

UN subregions
^^^^^^^^^^^^^

The UN subregion ``Latin America and the Caribbean``, not shown, includes the Caribbean, and Central and South America.

.. image:: images/UN-subregions.png
    :align: center

Europe and Asia
+++++++++++++++

The following locations are given:

* ``Europe`` (short name ``RER``)
* ``Asia`` (short name ``RAS``)
* ``Europe, UN Region`` (short name ``UN-EUROPE``)
* ``Asia, UN Region`` (short name ``UN-ASIA``)

We differentiate between the UN definitions of Europe and Asia (which are constrained to including or excluding entire countries), and the common understanding of the border between Europe and Asia. There is no clear line dividing Europe and Asia. The UN regions are defined following the `UN macro geographical regions`_. Russia is split by federal subjects, with the following federal subjects in Europe:

+------------------------+--------------+------------+---------------+
| Adygey                 | Arkhangel'sk | Astrakhan' | Bashkortostan |
+------------------------+--------------+------------+---------------+
| Belgorod               | Bryansk      | Chechnya   | Chuvash       |
+------------------------+--------------+------------+---------------+
| City of St. Petersburg | Dagestan     | Ingush     | Ivanovo       |
+------------------------+--------------+------------+---------------+
| Kabardin-Balkar        | Kaliningrad  | Kalmyk     | Kaluga        |
+------------------------+--------------+------------+---------------+
| Karachay-Cherkess      | Karelia      | Kirov      | Komi          |
+------------------------+--------------+------------+---------------+
| Kostroma               | Krasnodar    | Kursk      | Leningrad     |
+------------------------+--------------+------------+---------------+
| Lipetsk                | Mariy-El     | Mordovia   | Moskovsskaya  |
+------------------------+--------------+------------+---------------+
| Moskva                 | Murmansk     | Nenets     | Nizhegorod    |
+------------------------+--------------+------------+---------------+
| North Ossetia          | Novgorod     | Orel       | Orenburg      |
+------------------------+--------------+------------+---------------+
| Penza                  | Perm'        | Pskov      | Rostov        |
+------------------------+--------------+------------+---------------+
| Ryazan'                | Samara       | Saratov    | Smolensk      |
+------------------------+--------------+------------+---------------+
| Stavropol'             | Tambov       | Tatarstan  | Tula          |
+------------------------+--------------+------------+---------------+
| Tver'                  | Udmurt       | Ul'yanovsk | Vladimir      |
+------------------------+--------------+------------+---------------+
| Volgograd              | Vologda      | Voronezh   | Yaroslavl'    |
+------------------------+--------------+------------+---------------+

The following Russian federal subjects are in Asia:

+---------------+--------------------------+-------------+-----------------+
| Altay         | Amur                     | Buryat      | Chelyabinsk     |
+---------------+--------------------------+-------------+-----------------+
| Chita         | Chukchi Autonomous Okrug | Gorno-Altay | Irkutsk         |
+---------------+--------------------------+-------------+-----------------+
| Kamchatka     | Kemerovo                 | Khabarovsk  | Khakass         |
+---------------+--------------------------+-------------+-----------------+
| Khanty-Mansiy | Krasnoyarsk              | Kurgan      | Maga Buryatdan  |
+---------------+--------------------------+-------------+-----------------+
| Novosibirsk   | Omsk                     | Primor'ye   | Sakha (Yakutia) |
+---------------+--------------------------+-------------+-----------------+
| Sakhalin      | Sverdlovsk               | Tomsk       | Tuva            |
+---------------+--------------------------+-------------+-----------------+
| Tyumen'       | Yamal-Nenets             | Yevrey      |                 |
+---------------+--------------------------+-------------+-----------------+

.. note:: The definition of ``Europe`` and ``Asia`` have changed in version 2.0, to match Russian federal subject borders. In version 1.0, ``Europe`` also included parts of Kazakhstan, Azerbaijan, Georgia, and Turkey - these countries are now completely inside ``Asia``.

.. note:: Both ``Europe`` and ``Europe, UN Region`` include all of Spain, including the Canary Islands and a few small exclaves in Africa.

.. image:: images/Asia-Europe.png
    :align: center

In addition to the country ``Russia``, the regions ``Russia (Asia)`` and ``Russia (Europe)`` are given, following the federal subject boundaries given above.

.. image:: images/Russia.png
    :align: center

Aluminium-producing regions
+++++++++++++++++++++++++++

Aluminium is not produced in every country in the world, and the following producing regions are given:

* Al producing Area 1, Africa
* Al producing Area 2, North America
* Al producing Area 2, North America, without Quebec
* Al producing Area 3, South America
* Al producing Area 4 and 5, South and East Asia, without China
* Al producing Area 6A&B, West, East, and Central Europe
* Al producing Area 8, Gulf Region

Note that there an overlap between ``North America`` and ``North America, without Quebec``.

.. image:: images/Aluminium.png
    :align: center

Electricity networks
++++++++++++++++++++

The following networks are in Europe and North America are provided:

* European Network of Transmission Systems Operators for Electricity
* Florida Reliability Coordinating Council
* HICC
* Midwest Reliability Organization
* Northeast Power Coordinating Council
* ReliabilityFirst Corporation
* SERC Reliability Corporation
* Southwest Power Pool
* Texas Regional Entity
* Western Electricity Coordinating Council
* Alaska Systems Coordinating Council

North American networks
^^^^^^^^^^^^^^^^^^^^^^^

In Europe, ENTSO-E is made up of countries. In the United States and Canada, the boundaries between NERC regions is made up of state/province boundaries and hand-drawn boundaries traced from NERC maps.

.. image:: images/NA.png
    :align: center

USA-only subnetworks
^^^^^^^^^^^^^^^^^^^^

NERC regions which cross the Canadian border have also been split into USA-only networks for market reasons.

.. image:: images/USA.png
    :align: center

Legacy networks
^^^^^^^^^^^^^^^

In addition to these current networks, the following legacy European networks are provided:

* Nordic Countries Power Association
* Union for the Co-ordination of Electricity
* Baltic System Operator

.. image:: images/UCTE.png
    :align: center

* Central European Power Association

.. image:: images/Central-European.png
    :align: center



- Rest of world dataset

Geographical locations
The EcoSpold2 master file “Geographies.xml” defines geographical locations for all countries in the world and a number of political or economic geographical groupings. Each geography can have the following information:
Name and Description (required)
ISO 2-letter code, 3-letter code, and (UN) numeric code
UN region and subregion code
Centroid latitude and longitude (required)
KML geographic shape description (required)
KML geographical shape descriptions
KML was chosen KML is an open, well-defined standard, and is more widely known and understood than the other geographic standards because of its use in Google Earth and Google Maps. This makes the barrier to entry for people defining their own geographies very small. However, KML is not a Google-only standard. It is an official standard, approved by the Open Geospatial Consortium, and is implemented in many other software programs. KML includes other meta-data that might be useful to data developers - they can include descriptions, pictures, or simply different border colors and widths for different areas, making working with geographic data easier. Note that this extra meta-data will only be used by data developers, and should be automatically removed when geographic data is included in ecospold.
Countries or regions covered by the master file
246 countries
30 UN regions and subregions
North American Free Trade Agreement (NAFTA) and the Commonwealth of Independent States (CIS)
Asia and Europe, as commonly understood (see discussion below)
European electricity grid operators: the Baltic System Operator, the Central European Power Association, the European Network of Transmission Systems Operators for Electricity (ENTSO-E), the Nordic Countries Power Association, and the Union for the Co-ordination of Transmission of Electricity (UCTE)
North American Electricity Reliability Corporation (NERC) regions: Alaska Systems Coordinating Council, Florida Reliability Coordinating Council, Midwest Reliability Organization, Northeast Power Coordinating Council, ReliabilityFirst Corporation, SERC Reliability Corporation, Southwest Power Pool, Texas Regional Entity, Western Electricity Coordinating Council, and the Hawaiian systems operator (HICC)
Custom EcoSpold geographies used in Ecoinvent versions 1 & 2
Notes on specific features of the master EcoSpold2 geographies file
The country geographical definitions come from the Natural Earth dataset (the 1:10m Admin 0 cultural vectors). Natural Earth provides boundaries for 240 countries, and some of these are broken apart in the EcoSpold 2 base file to form the 246 countries recognized in ISO 3166 . Some additional notes on specific geographies:
The “global” dataset does not have a KML description.
The following countries are considered one country in the Natural Earth dataset, but are separated into two countries in the ISO standard and the EcoSpold 2 base file: Denmark & the Faroe Island, France & French Guiana, France & Reunion, France & Guadeloupe, France & Martinique, New Zealand & Niue.
Country names follow the ISO official short list. In some cases, this means that the names are separated by commas, e.g. “Tanzania, United Republic of.”
Military bases present in the natural earth dataset were not included in the EcoSpold 2 base file.
Kosovo is included as a separate country, though it is not yet officially recognized by the UN or the ISO.
The distinction between country and oversea territory follows the guidance in ISO. Note that France considers its overseas territories an integral part of France, while the ISO has assigned them country codes.
Taiwan is included in the UN region Asia and the UN subregion Eastern Asia, even though it is not officially listed in the UN definitions.

Rest of world dataset
The “rest of world” dataset is a dynamic concept that exists in the situation when both a global dataset and one or more non-global datasets are available for the same activity, time period, and macro-economic scenario. The definitions is specific to each activity and depends on what defined geographies are available for the specific activity name. It is defined as the difference between the global reference dataset and the datasets with defined geographies. The “rest of world” dataset does not have a set KML description.


Adaptation of existing EcoSpold regions
The first version of EcoSpold defined a number of non-country regions. All of these regions which were used in a previous version of the Ecoinvent database will be included in the new base file. The following table has specifics on the disposition of these geographies:

.. _`UN macro geographical regions`: http://unstats.un.org/unsd/methods/m49/m49regin.htm
