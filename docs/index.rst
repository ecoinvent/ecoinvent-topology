Ecoinvent geography definitions
===============================

.. warning:: This is a draft report.

Table of Contents
-----------------

.. contents::

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

Methodology
-----------

The primary data source for the ecoinvent geodata is the `Natural Earth data <http://www.naturalearthdata.com/>`_, and in particular the `1:10 million cultural vectors, including boundary lakes <http://www.naturalearthdata.com/downloads/10m-cultural-vectors/>`_. In addition to Natural Earth, custom geometries were drawn for NERC regions in the United States of America which split individual states.

Processing begins by entering all state/province level regions into a `PostGIS topological database <http://postgis.net/docs/Topology.html>`__. A topology is different from a normal geometry because it tries to store only one copy of each face edge and node, and a state or province would be defined by which common edges it bordered. For example, the boundary between France and Germany would be stored only once, and the topology of both France and Germany would reference that border. Topology is a rahter complex subject which is not explained in detail here; interested readers should go through `this presentation by Sandro Santilli <http://strk.keybit.net/projects/postgis/Paris2011_TopologyWithPostGIS_2_0.pdf>`__. The use of topologies give several nice advantages:

* Consistency: Each border is only defined once. Modifications to border edges apply to all affected regions automatically.
* Integrity: All regions are automatically valid.
* Explicit relationships: It is fast and simple to determine spatial relationships among regions by comparing their topological faces. There is no potential for floating-point errors, as no geometry math is needed.

After state/province-level data is imported, country data is imported. Country borders are automatically snapped to province borders by the database. A series of data cleaning steps is then applied.

The basic topological units in the database are usually state/province-level regions, as in this visualization of Madagascar:

.. image:: images/Madagascar.png
    :align: center

However, in some regions states are broken up, as in this visualization of the combination of NERC regions and state boundaries in the United States of America:

.. image:: images/NERC.png
    :align: center

Ecoinvent regions are defined constructively, i.e. they are built up by adding different topological faces together.

After a consistent topology is constructed, only the regions necessary for ecoinvent are extracted, and the final ecoinvent topology of the world looks like this:

.. image:: images/ecoinvent-world.png
    :align: center

The input data and scripts to process, combine, and export all location data, as well as this manual, are open source and `freely available for download <https://bitbucket.org/cmutel/constructive-geometries>`__.

- Custom drawn geometries

List of locations in ecoinvent
------------------------------

Countries
+++++++++

259 entities listed in `ISO 3166-1`_:

+-----------------------------------+------------------------------------------+-------------------------------------+------------------------------+
| Afghanistan                       | Akrotiri Sovereign Base Area             | Aland                               | Albania                      |
+-----------------------------------+------------------------------------------+-------------------------------------+------------------------------+
| Algeria                           | American Samoa                           | Andorra                             | Angola                       |
+-----------------------------------+------------------------------------------+-------------------------------------+------------------------------+
| Anguilla                          | Antarctica                               | Antigua and Barbuda                 | Argentina                    |
+-----------------------------------+------------------------------------------+-------------------------------------+------------------------------+
| Armenia                           | Aruba                                    | Ashmore and Cartier Islands         | Australia                    |
+-----------------------------------+------------------------------------------+-------------------------------------+------------------------------+
| Austria                           | Azerbaijan                               | Bahrain                             | Bajo Nuevo Bank (Petrel Is.) |
+-----------------------------------+------------------------------------------+-------------------------------------+------------------------------+
| Bangladesh                        | Barbados                                 | Belarus                             | Belgium                      |
+-----------------------------------+------------------------------------------+-------------------------------------+------------------------------+
| Belize                            | Benin                                    | Bermuda                             | Bhutan                       |
+-----------------------------------+------------------------------------------+-------------------------------------+------------------------------+
| Bolivia                           | Bonaire, Saint Eustatius and Saba        | Bosnia and Herzegovina              | Botswana                     |
+-----------------------------------+------------------------------------------+-------------------------------------+------------------------------+
| Bouvet Island                     | Brazil                                   | British Indian Ocean Territory      | British Virgin Islands       |
+-----------------------------------+------------------------------------------+-------------------------------------+------------------------------+
| Brunei                            | Bulgaria                                 | Burkina Faso                        | Burundi                      |
+-----------------------------------+------------------------------------------+-------------------------------------+------------------------------+
| Cambodia                          | Cameroon                                 | Canada                              | Cape Verde                   |
+-----------------------------------+------------------------------------------+-------------------------------------+------------------------------+
| Cayman Islands                    | Central African Republic                 | Chad                                | Chile                        |
+-----------------------------------+------------------------------------------+-------------------------------------+------------------------------+
| China                             | Clipperton Island                        | Colombia                            | Comoros                      |
+-----------------------------------+------------------------------------------+-------------------------------------+------------------------------+
| Congo                             | Congo, Democratic Republic of the        | Cook Islands                        | Costa Rica                   |
+-----------------------------------+------------------------------------------+-------------------------------------+------------------------------+
| Croatia                           | Cuba                                     | Curaçao                             | Cyprus                       |
+-----------------------------------+------------------------------------------+-------------------------------------+------------------------------+
| Cyprus No Mans Area               | Czech Republic                           | Denmark                             | Dhekelia Sovereign Base Area |
+-----------------------------------+------------------------------------------+-------------------------------------+------------------------------+
| Djibouti                          | Dominica                                 | Dominican Republic                  | East Timor                   |
+-----------------------------------+------------------------------------------+-------------------------------------+------------------------------+
| Ecuador                           | Egypt                                    | El Salvador                         | Equatorial Guinea            |
+-----------------------------------+------------------------------------------+-------------------------------------+------------------------------+
| Eritrea                           | Estonia                                  | Ethiopia                            | Falkland Islands             |
+-----------------------------------+------------------------------------------+-------------------------------------+------------------------------+
| Faroe Islands                     | Fiji                                     | Finland                             | France                       |
+-----------------------------------+------------------------------------------+-------------------------------------+------------------------------+
| French Guiana                     | French Polynesia                         | French Southern and Antarctic Lands | Gabon                        |
+-----------------------------------+------------------------------------------+-------------------------------------+------------------------------+
| Gambia                            | Georgia                                  | Germany                             | Ghana                        |
+-----------------------------------+------------------------------------------+-------------------------------------+------------------------------+
| Gibraltar                         | Greece                                   | Greenland                           | Grenada                      |
+-----------------------------------+------------------------------------------+-------------------------------------+------------------------------+
| Guadeloupe                        | Guam                                     | Guatemala                           | Guernsey                     |
+-----------------------------------+------------------------------------------+-------------------------------------+------------------------------+
| Guinea                            | Guinea Bissau                            | Guyana                              | Haiti                        |
+-----------------------------------+------------------------------------------+-------------------------------------+------------------------------+
| Heard Island and McDonald Islands | Honduras                                 | Hong Kong S.A.R.                    | Hungary                      |
+-----------------------------------+------------------------------------------+-------------------------------------+------------------------------+
| Iceland                           | India                                    | Indonesia                           | Iran                         |
+-----------------------------------+------------------------------------------+-------------------------------------+------------------------------+
| Iraq                              | Ireland                                  | Isle of Man                         | Israel                       |
+-----------------------------------+------------------------------------------+-------------------------------------+------------------------------+
| Italy                             | Ivory Coast                              | Jamaica                             | Japan                        |
+-----------------------------------+------------------------------------------+-------------------------------------+------------------------------+
| Jersey                            | Jordan                                   | Kazakhstan                          | Kenya                        |
+-----------------------------------+------------------------------------------+-------------------------------------+------------------------------+
| Kiribati                          | Kuwait                                   | Kyrgyzstan                          | Laos                         |
+-----------------------------------+------------------------------------------+-------------------------------------+------------------------------+
| Latvia                            | Lebanon                                  | Lesotho                             | Liberia                      |
+-----------------------------------+------------------------------------------+-------------------------------------+------------------------------+
| Libya                             | Liechtenstein                            | Lithuania                           | Luxembourg                   |
+-----------------------------------+------------------------------------------+-------------------------------------+------------------------------+
| Macao S.A.R                       | Macedonia                                | Madagascar                          | Malawi                       |
+-----------------------------------+------------------------------------------+-------------------------------------+------------------------------+
| Malaysia                          | Maldives                                 | Mali                                | Malta                        |
+-----------------------------------+------------------------------------------+-------------------------------------+------------------------------+
| Marshall Islands                  | Martinique                               | Mauritania                          | Mauritius                    |
+-----------------------------------+------------------------------------------+-------------------------------------+------------------------------+
| Mayotte                           | Mexico                                   | Micronesia, Federated States of     | Moldova                      |
+-----------------------------------+------------------------------------------+-------------------------------------+------------------------------+
| Monaco                            | Mongolia                                 | Montenegro                          | Montserrat                   |
+-----------------------------------+------------------------------------------+-------------------------------------+------------------------------+
| Morocco                           | Mozambique                               | Myanmar                             | Namibia                      |
+-----------------------------------+------------------------------------------+-------------------------------------+------------------------------+
| Nauru                             | Nepal                                    | Netherlands                         | New Caledonia                |
+-----------------------------------+------------------------------------------+-------------------------------------+------------------------------+
| New Zealand                       | Nicaragua                                | Niger                               | Nigeria                      |
+-----------------------------------+------------------------------------------+-------------------------------------+------------------------------+
| Niue                              | Norfolk Island                           | North Korea                         | Northern Cyprus              |
+-----------------------------------+------------------------------------------+-------------------------------------+------------------------------+
| Northern Mariana Islands          | Norway                                   | Oman                                | Pakistan                     |
+-----------------------------------+------------------------------------------+-------------------------------------+------------------------------+
| Palau                             | Palestine                                | Panama                              | Papua New Guinea             |
+-----------------------------------+------------------------------------------+-------------------------------------+------------------------------+
| Paraguay                          | Peru                                     | Philippines                         | Pitcairn Islands             |
+-----------------------------------+------------------------------------------+-------------------------------------+------------------------------+
| Poland                            | Portugal                                 | Puerto Rico                         | Qatar                        |
+-----------------------------------+------------------------------------------+-------------------------------------+------------------------------+
| Romania                           | Russia                                   | Rwanda                              | Réunion                      |
+-----------------------------------+------------------------------------------+-------------------------------------+------------------------------+
| Saint Barthelemy                  | Saint Helena                             | Saint Kitts and Nevis               | Saint Lucia                  |
+-----------------------------------+------------------------------------------+-------------------------------------+------------------------------+
| Saint Martin                      | Saint Pierre and Miquelon                | Saint Vincent and the Grenadines    | Samoa                        |
+-----------------------------------+------------------------------------------+-------------------------------------+------------------------------+
| San Marino                        | Sao Tome and Principe                    | Saudi Arabia                        | Scarborough Reef             |
+-----------------------------------+------------------------------------------+-------------------------------------+------------------------------+
| Senegal                           | Serbia                                   | Serranilla Bank                     | Seychelles                   |
+-----------------------------------+------------------------------------------+-------------------------------------+------------------------------+
| Siachen Glacier                   | Sierra Leone                             | Singapore                           | Sint Maarten                 |
+-----------------------------------+------------------------------------------+-------------------------------------+------------------------------+
| Slovakia                          | Slovenia                                 | Solomon Islands                     | Somalia                      |
+-----------------------------------+------------------------------------------+-------------------------------------+------------------------------+
| South Africa                      | South Georgia and South Sandwich Islands | South Korea                         | South Sudan                  |
+-----------------------------------+------------------------------------------+-------------------------------------+------------------------------+
| Spain                             | Spratly Islands                          | Sri Lanka                           | Sudan                        |
+-----------------------------------+------------------------------------------+-------------------------------------+------------------------------+
| Suriname                          | Svalbard and Jan Mayen                   | Swaziland                           | Sweden                       |
+-----------------------------------+------------------------------------------+-------------------------------------+------------------------------+
| Switzerland                       | Syria                                    | Taiwan                              | Tajikistan                   |
+-----------------------------------+------------------------------------------+-------------------------------------+------------------------------+
| Tanzania                          | Thailand                                 | The Bahamas                         | Togo                         |
+-----------------------------------+------------------------------------------+-------------------------------------+------------------------------+
| Tokelau                           | Tonga                                    | Trinidad and Tobago                 | Tunisia                      |
+-----------------------------------+------------------------------------------+-------------------------------------+------------------------------+
| Turkey                            | Turkmenistan                             | Turks and Caicos Islands            | Tuvalu                       |
+-----------------------------------+------------------------------------------+-------------------------------------+------------------------------+
| US Naval Base Guantanamo Bay      | Uganda                                   | Ukraine                             | United Arab Emirates         |
+-----------------------------------+------------------------------------------+-------------------------------------+------------------------------+
| United Kingdom                    | United States Minor Outlying Islands     | United States Virgin Islands        | United States of America     |
+-----------------------------------+------------------------------------------+-------------------------------------+------------------------------+
| Uruguay                           | Uzbekistan                               | Vanuatu                             | Vatican                      |
+-----------------------------------+------------------------------------------+-------------------------------------+------------------------------+
| Venezuela                         | Vietnam                                  | Wallis and Futuna                   | Western Sahara               |
+-----------------------------------+------------------------------------------+-------------------------------------+------------------------------+
| Yemen                             | Zambia                                   | Zimbabwe                            |                              |
+-----------------------------------+------------------------------------------+-------------------------------------+------------------------------+

De facto independent countries
++++++++++++++++++++++++++++++

The country of ``Kosovo`` is included, although it is not yet `completely internationally recognized <en.wikipedia.org/wiki/International_recognition_of_Kosovo>`__.

``Somaliland`` (`Wikipedia <http://en.wikipedia.org/wiki/Somaliland>`__) is included as a separate location. ``Somalia`` does not include ``Somaliland``.

Disputed areas and indepedent military bases
++++++++++++++++++++++++++++++++++++++++++++

* `Akrotiri Sovereign Base Area <http://en.wikipedia.org/wiki/Akrotiri_and_Dhekelia>`__
* `Bajo Nuevo Bank (Petrel Is.) <http://en.wikipedia.org/wiki/Bajo_Nuevo_Bank>`__
* `Cyprus No Mans Area <http://en.wikipedia.org/wiki/United_Nations_Buffer_Zone_in_Cyprus>`__
* `Dhekelia Sovereign Base Area <http://en.wikipedia.org/wiki/Akrotiri_and_Dhekelia>`__
* `Scarborough Reef <http://en.wikipedia.org/wiki/Scarborough_Shoal>`__
* `Serranilla Bank <http://en.wikipedia.org/wiki/Serranilla_Bank>`__
* `Siachen Glacier <http://en.wikipedia.org/wiki/Siachen_Glacier>`__
* `Spratly Islands <http://en.wikipedia.org/wiki/Spratly_Islands>`__
* `US Naval Base Guantanamo Bay <http://en.wikipedia.org/wiki/Guantanamo_Bay_Naval_Base>`__

International Aluminium Institute regions
+++++++++++++++++++++++++++++++++++++++++

The `International Aluminium Institute <http://www.world-aluminium.org/statistics/>`__ regions are roughly followed, although wiht some ecoinvent-specific modifications.

.. note:: See the :ref:`detailed notes on aluminium-producting regions <aluminium>`.

* IAI producing Area 1, Africa
* IAI producing Area 2, North America
* IAI producing Area 2, North America, without Quebec
* IAI producing Area 3, South America
* IAI producing Area 4 and 5, South and East Asia, without China
* IAI producing Area 6A&B, West, East, and Central Europe
* IAI producing Area 8, Gulf Region

UN regions and subregions
+++++++++++++++++++++++++

All `UN macro geographical regions`_ and subregions are included.

.. note:: See also geographic descriptions of :ref:`regions` and :ref:`subregions`.

UN regions
^^^^^^^^^^

* Africa
* Americas
* Asia, UN Region
* Europe, UN Region
* Oceania

UN subregions
^^^^^^^^^^^^^

* Australia and New Zealand
* Caribbean
* Central America
* Central Asia
* Eastern Africa
* Eastern Asia
* Eastern Europe
* Latin America and the Caribbean
* Melanesia
* Micronesia
* Middle Africa
* Northern Africa
* Northern America
* Northern Europe
* Polynesia
* South America
* South-Eastern Asia
* Southern Africa
* Southern Asia
* Southern Europe
* Western Africa
* Western Asia
* Western Europe

Electricity networks
++++++++++++++++++++

North America
^^^^^^^^^^^^^

.. note:: See also specific comments on :ref:`elecna` and :ref:`elecusa`.

* Alaska Systems Coordinating Council
* Florida Reliability Coordinating Council
* HICC (Hawaii)
* Midwest Reliability Organization
* Midwest Reliability Organization, US part only
* Northeast Power Coordinating Council
* Northeast Power Coordinating Council, US part only
* ReliabilityFirst Corporation
* SERC Reliability Corporation
* Southwest Power Pool
* Texas Regional Entity
* Western Electricity Coordinating Council
* Western Electricity Coordinating Council, US part only

Europe
^^^^^^

.. note:: See also specific comments on European :ref:`eleceu`.

* Baltic System Operator
* Central European Power Association
* European Network of Transmission Systems Operators for Electricity
* Nordic Countries Power Association
* Union for the Co-ordination of Transmission of Electricity

Ecoinvent special locations
+++++++++++++++++++++++++++

"Cut-out" locations
^^^^^^^^^^^^^^^^^^^

Due to the way markets are linked, it is sometimes necessary to create regions without specific states or countries. The following are current included:

* Asia without China
* Canada without Alberta
* Canada without Alberta and Quebec
* Europe without Austria, Belgium, France, Germany, Italy, Liechtenstein, Monaco, San Marino, Switzerland, and the Vatican
* Europe without Germany and Switzerland
* Europe without Germany, the Netherlands, and Norway
* Europe without NORDEL (NCPA)
* Europe without Switzerland
* Europe, without Russia and Turkey
* UCTE without France
* UCTE without Germany
* UCTE without Germany and France

Trading blocks
^^^^^^^^^^^^^^

* Commonwealth of Independent States
* North American Free Trade Agreement

Miscellaneous
^^^^^^^^^^^^^

* Canary Islands (:ref:`Spain` also includes the Canary Islands)
* France, including overseas territories (See :ref:`france`)
* Middle East (Iran, Iraq, Kuwait, Saudi Arabia, and the United Arab Emirates)
* Québec, Hydro-Québec distribution network
* Serbia and Montenegro (Legacy location; Both ``Serbia`` and ``Montenegro`` are included as countries)

Australian states and territories
+++++++++++++++++++++++++++++++++

In addition to the country ``Australia``, the Australian states are also provided. As a consequence, the territories *Christmas Island* and *Cocos (Keeling) Islands*, which do possess `ISO 3166-1`_ codes, are included in the location ``Indian Ocean Territories``.

* Australian Capital Territory
* `Coral Sea Islands <http://en.wikipedia.org/wiki/Coral_Sea_Islands>`__
* `Indian Ocean Territories <http://en.wikipedia.org/wiki/Australian_Indian_Ocean_Territories>`__
* New South Wales
* Northern Territory
* Queensland
* South Australia
* Tasmania
* Victoria
* Western Australia

Canadian provinces
++++++++++++++++++

In addition to the country ``Canada``, the Canadian provinces are also provided.

* Alberta
* British Columbia
* Manitoba
* New Brunswick
* Newfoundland and Labrador
* Northwest Territories
* Nova Scotia
* Nunavut
* Ontario
* Prince Edward Island
* Québec
* Saskatchewan
* Yukon

Chinese provinces
+++++++++++++++++

In addition to the country ``China``, the Chinese provinces are also provided.

* Anhui (安徽)
* Beijing (北京)
* Chongqing (重庆)
* Fujian (福建)
* Gansu (甘肃)
* Guangdong (广东)
* Guangxi (广西壮族自治区)
* Guizhou (贵州)
* Hainan (海南)
* Hebei (河北)
* Heilongjiang (黑龙江省)
* Henan (河南)
* Hubei (湖北)
* Hunan (湖南)
* Inner Mongol (内蒙古自治区)
* Jiangsu (江苏)
* Jiangxi (江西)
* Jilin (吉林)
* Liaoning (辽宁)
* Ningxia (宁夏回族自治区)
* Qinghai (青海)
* Shaanxi (陕西)
* Shandong (山东)
* Shanghai (上海)
* Shanxi (山西)
* Sichuan (四川)
* Tianjin (天津)
* Xinjiang (新疆维吾尔自治区)
* Xizang (西藏自治区)
* Yunnan (云南)
* Zhejiang (浙江)

Changelog
---------

Version 2.0 (ecoinvent 3.2)
+++++++++++++++++++++++++++

No locations used in ecoinvent 3.01 or 3.1 have been removed, and no location shortnames or UUIDs have been changed. Ecoinvent geography definitions version 2.0 should therefore be backwards-compatible with version 1.0.

The following locations were added:

* `Akrotiri Sovereign Base Area <http://en.wikipedia.org/wiki/Akrotiri_and_Dhekelia>`__
* `Aluminium producing area, EU27 and EFTA countries`
* `Aluminium producing area, Europe outside EU27 and EFTA`
* `Ashmore and Cartier Islands <http://en.wikipedia.org/wiki/Ashmore_and_Cartier_Islands>`__
* `Bajo Nuevo Bank (Petrel Is.) <http://en.wikipedia.org/wiki/Bajo_Nuevo_Bank>`__
* Caribbean (UN subregion)
* `Clipperton Island <http://en.wikipedia.org/wiki/Clipperton_Island>`__
* `Coral Sea Islands <http://en.wikipedia.org/wiki/Coral_Sea_Islands>`__ (administrative unit of Australia)
* `Cyprus No Mans Area <http://en.wikipedia.org/wiki/United_Nations_Buffer_Zone_in_Cyprus>`__
* `Dhekelia Sovereign Base Area <http://en.wikipedia.org/wiki/Akrotiri_and_Dhekelia>`__
* `Indian Ocean Territories <http://en.wikipedia.org/wiki/Australian_Indian_Ocean_Territories>`__ (administrative unit of Australia)
* `Kosovo <http://en.wikipedia.org/wiki/Kosovo>`__
* `Northern Cyprus <http://en.wikipedia.org/wiki/Northern_Cyprus>`__
* Russia (Asia)
* Russia (Europe)
* `Scarborough Reef <http://en.wikipedia.org/wiki/Scarborough_Shoal>`__
* `Serranilla Bank <http://en.wikipedia.org/wiki/Serranilla_Bank>`__
* `Siachen Glacier <http://en.wikipedia.org/wiki/Siachen_Glacier>`__
* `Somaliland <http://en.wikipedia.org/wiki/Somaliland>`__
* `US Naval Base Guantanamo Bay <http://en.wikipedia.org/wiki/Guantanamo_Bay_Naval_Base>`__

The location ``Al producing Area 6A&B, West, East, and Central Europe``, which was not used in ecoinvent 3.01 or 3.1, has been split into ``Aluminium producing area, EU27 and EFTA countries`` and ``Aluminium producing area, Europe outside EU27 and EFTA``.

.. note:: Sovereign military bases are necessary in version 2 for a consistent world topology.

The following names were changed, mostly due to changes in the source data, or to choose the common instead of formal names:

+------------------------------------------+----------------------------------------------------------+
| New name                                 | Old name                                                 |
+==========================================+==========================================================+
| IAI producing Area 8, Gulf Region        | IAI producing Area 8, Gulf-Aluminium Council/Gulf Region |
+------------------------------------------+----------------------------------------------------------+
| Aland                                    | Åland Islands                                            |
+------------------------------------------+----------------------------------------------------------+
| Bolivia                                  | Bolivia, Plurinational State of                          |
+------------------------------------------+----------------------------------------------------------+
| Bonaire, Saint Eustatius and Saba        | Bonaire, Sint Eustatius, and Saba                        |
+------------------------------------------+----------------------------------------------------------+
| British Virgin Islands                   | Virgin Islands, British                                  |
+------------------------------------------+----------------------------------------------------------+
| Brunei                                   | Brunei Darussalam                                        |
+------------------------------------------+----------------------------------------------------------+
| East Timor                               | Timor-Leste                                              |
+------------------------------------------+----------------------------------------------------------+
| Falkland Islands                         | Falkland Islands (Malvinas)                              |
+------------------------------------------+----------------------------------------------------------+
| French Southern and Antarctic Lands      | French Southern Territories                              |
+------------------------------------------+----------------------------------------------------------+
| Guinea Bissau                            | Guinea-Bissau                                            |
+------------------------------------------+----------------------------------------------------------+
| Hong Kong S.A.R.                         | Hong Kong                                                |
+------------------------------------------+----------------------------------------------------------+
| Iran                                     | Iran (Islamic Republic of)                               |
+------------------------------------------+----------------------------------------------------------+
| Ivory Coast                              | Cote d'Ivoire                                            |
+------------------------------------------+----------------------------------------------------------+
| Laos                                     | Lao People's Democratic Republic                         |
+------------------------------------------+----------------------------------------------------------+
| Macao S.A.R                              | Macau                                                    |
+------------------------------------------+----------------------------------------------------------+
| Macedonia                                | Macedonia, the Former Yugoslav Republic of               |
+------------------------------------------+----------------------------------------------------------+
| Moldova                                  | Moldova, Republic of                                     |
+------------------------------------------+----------------------------------------------------------+
| North Korea                              | Korea, Democratic People's Republic of                   |
+------------------------------------------+----------------------------------------------------------+
| Palestine                                | Palestinian Territory, Occupied                          |
+------------------------------------------+----------------------------------------------------------+
| Pitcairn Islands                         | Pitcairn                                                 |
+------------------------------------------+----------------------------------------------------------+
| Réunion                                  | Reunion                                                  |
+------------------------------------------+----------------------------------------------------------+
| Russia                                   | Russian Federation                                       |
+------------------------------------------+----------------------------------------------------------+
| South Georgia and South Sandwich Islands | South Georgia and the South Sandwich Islands             |
+------------------------------------------+----------------------------------------------------------+
| South Korea                              | Korea, Republic of                                       |
+------------------------------------------+----------------------------------------------------------+
| Southern Asia                            | South Asia                                               |
+------------------------------------------+----------------------------------------------------------+
| Syria                                    | Syrian Arab Republic                                     |
+------------------------------------------+----------------------------------------------------------+
| Taiwan                                   | Taiwan, Province of China                                |
+------------------------------------------+----------------------------------------------------------+
| Tanzania                                 | Tanzania, United Republic Of                             |
+------------------------------------------+----------------------------------------------------------+
| The Bahamas                              | Bahamas                                                  |
+------------------------------------------+----------------------------------------------------------+
| United States of America                 | United States                                            |
+------------------------------------------+----------------------------------------------------------+
| United States Virgin Islands             | Virgin Islands, U.S.                                     |
+------------------------------------------+----------------------------------------------------------+
| Vatican                                  | Holy See (Vatican City State)                            |
+------------------------------------------+----------------------------------------------------------+
| Vietnam                                  | Viet Nam                                                 |
+------------------------------------------+----------------------------------------------------------+
| Yukon                                    | Yukon Territory                                          |
+------------------------------------------+----------------------------------------------------------+

The following unused locations have been removed:

+----------------------------------------+--------------------------------------------+
| Location                               | Comment                                    |
+========================================+============================================+
| Central and Eastern Europe             |                                            |
+----------------------------------------+--------------------------------------------+
| Christmas Island                       | Now included in `Indian Ocean Territories` |
+----------------------------------------+--------------------------------------------+
| Cocos (Keeling) Islands                | Now included in `Indian Ocean Territories` |
+----------------------------------------+--------------------------------------------+
| Spain, including overseas territories  |                                            |
+----------------------------------------+--------------------------------------------+

Version 1.0 (ecoinvent 3.01 & 3.1)
++++++++++++++++++++++++++++++++++

Initial development. Removal of locations no longer used in the ecoinvent database.

Notes on specific geometries
----------------------------

Some images are large, and can be opened in a separate tab to be seen in full detail.

Global and Rest of the World
++++++++++++++++++++++++++++

The ``Global`` dataset does not have a KML description.

The ``Rest of the world`` dataset is a dynamic concept that exists in the situation when both a global dataset and one or more non-global datasets are available for the same activity, time period, and macro-economic scenario. The definitions is specific to each activity and depends on what defined geographies are available for the specific activity name. It is defined as the difference between the global reference dataset and the datasets with defined geographies. The “rest of world” dataset does not have a set KML description.

UN Regions and subregions
+++++++++++++++++++++++++

UN regions and subregions follow the `UN macro geographical regions`_ definitions.

.. _regions:

UN regions
^^^^^^^^^^

.. note:: ``Taiwan`` is included in the UN region Asia and the UN subregion Eastern Asia, even though it is not officially listed in the UN definitions.

.. image:: images/UN-regions.png
    :align: center

.. _subregions:

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

.. _aluminium:

Aluminium-producing regions
+++++++++++++++++++++++++++

Aluminium is not produced in every country in the world, and the following producing regions are given:

* IAI producing Area 1, Africa
* IAI producing Area 2, North America
* IAI producing Area 2, North America, without Quebec
* IAI producing Area 3, South America
* IAI producing Area 4 and 5, South and East Asia, without China
* Aluminium producing area, EU27 and EFTA countries
* Aluminium producing area, Europe outside EU27 and EFTA
* IAI producing Area 8, Gulf Region

Note that there is an overlap between ``IAI producing Area 2, North America`` and ``IAI producing Area 2, North America, without Quebec``.

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

.. _elecna:

North American networks
^^^^^^^^^^^^^^^^^^^^^^^

In Europe, ENTSO-E is made up of countries. In the United States and Canada, the boundaries between NERC regions is made up of state/province boundaries and hand-drawn boundaries traced from NERC maps.

.. image:: images/NA.png
    :align: center

.. _elecusa:

USA-only subnetworks
^^^^^^^^^^^^^^^^^^^^

NERC regions which cross the Canadian border have also been split into USA-only networks for market reasons.

.. image:: images/USA.png
    :align: center

.. _eleceu:

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

Norway
++++++

``Bouvet Island`` and ``Svalbard and Jan Mayen`` are distinct locations with `ISO 3166-1`_ codes and are not included in ``Norway``.

.. _france:

France
++++++

``France`` is what is commonly called `metropolitan France <http://en.wikipedia.org/wiki/Metropolitan_France>`__. It does not include the following locations which all have `ISO 3166-1`_ codes:

* French Guiana
* French Polynesia
* French Southern and Antarctic Lands
* Guadeloupe
* Martinique
* Mayotte
* New Caledonia
* Réunion
* Saint Barthélemy
* Saint Martin
* Saint Pierre and Miquelon
* Wallis and Futuna

In addition, ``France`` does not include the uninhabited ``Clipperton Island``, which is given as a separate location.

The location ``France, including overseas territories`` includes metropolitan France, as well as ``French Guiana``, ``Guadeloupe``, ``Martinique``, ``Mayotte``, and ``Réunion``.

.. _spain:

Spain
+++++

``Spain`` includes the `Canary Islands <http://en.wikipedia.org/wiki/Canary_Islands>`__, `Ceuta <http://en.wikipedia.org/wiki/Ceuta>`__, `Melilla <http://en.wikipedia.org/wiki/Melilla>`__, and the `Plazas de soberanía <http://en.wikipedia.org/wiki/Plazas_de_soberanía>`__.

Micronesia
++++++++++

The country is called ``Micronesia, Federated States of``. The UN subregion is called ``Micronesia``.

Cyprus
++++++

.. image:: images/Cyprus.png
    :align: center

Due to `ongoing territorial disputes <http://en.wikipedia.org/wiki/Cyprus_dispute>`__, the island of Cyprus is split into the following:

* `Akrotiri Sovereign Base Area <http://en.wikipedia.org/wiki/Akrotiri_and_Dhekelia>`__
* `Cyprus <http://en.wikipedia.org/wiki/Cyprus>`__
* `Cyprus No Mans Area <http://en.wikipedia.org/wiki/United_Nations_Buffer_Zone_in_Cyprus>`__
* `Dhekelia Sovereign Base Area <http://en.wikipedia.org/wiki/Akrotiri_and_Dhekelia>`__
* `Northern Cyprus <http://en.wikipedia.org/wiki/Northern_Cyprus>`__

United States of America
++++++++++++++++++++++++

The location ``United States of America`` includes the 50 states and Washington D.C. The following are given as separate locations:

* American Samoa
* Guam
* Northern Mariana Islands
* Puerto Rico
* United States Minor Outlying Islands
* United States Virgin Islands

.. _`UN macro geographical regions`: http://unstats.un.org/unsd/methods/m49/m49regin.htm

.. _`ISO 3166-1`: http://en.wikipedia.org/wiki/ISO_3166-1
