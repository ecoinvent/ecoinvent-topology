Ecoinvent geography definitions
===============================

.. note:: This is a draft report.

Details of geographic locations in Ecospold2
Outline for geography report

Purpose of location descriptions in ecoinvent

- Not a political statement
- Statement on geographical controversies

Methodology

Input data sources

- NE
- Custom drawn geometries

List of locations in ecoinvent

    Separate by type

Changes from previous versions

Notes on specific geometries

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
Statement on geographical controversies
Neither the EcoSpold 2 data format, nor its authors, take any position on geographical areas of controversy. The geographical shapes presented in the EcoSpold 2 base data file should not be taken as absolute definitions of country or region borders. Rather, they are approximations consistent with common understanding of these countries and regions. If subjective judgments have to be made, we have made choices based on our understanding of what would be best for clear and understandable life cycle inventories. If you find a error or discrepancy in the base data file, please let us know by filing a bug.
Rest of world dataset
The “rest of world” dataset is a dynamic concept that exists in the situation when both a global dataset and one or more non-global datasets are available for the same activity, time period, and macro-economic scenario. The definitions is specific to each activity and depends on what defined geographies are available for the specific activity name. It is defined as the difference between the global reference dataset and the datasets with defined geographies. The “rest of world” dataset does not have a set KML description.
Difference between Europe, Asia, and the UN regions Europe and Asia
EcoSpold 2 differentiates between the UN definitions of Europe and Asia (which are constrained to including or excluding entire countries), and the common understanding of the border between Europe and Asia. There is no consensus where Europe ends and Asia begins (or vice-versa), but it is commonly understood that the Russian Federation, Kazakhstan, Azerbaijan, Georgia, and Turkey straddle this border.

Figure 1: “Europe” (left) includes parts of the Russian Federation, Kazakhstan, Azerbaijan, Georgia, and Turkey. “Europe, UN region” (right) includes the Russian Federation, but excludes the other countries.

Adaptation of existing EcoSpold regions
The first version of EcoSpold defined a number of non-country regions. All of these regions which were used in a previous version of the Ecoinvent database will be included in the new base file. The following table has specifics on the disposition of these geographies:
