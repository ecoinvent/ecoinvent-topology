from lxml.builder import ElementMaker
from lxml.etree import tostring, fromstring
import babel
import csv
import os
import sys

csv.field_size_limit(sys.maxsize)


XML_NS = "http://www.w3.org/XML/1998/namespace"

# CSV column names:
# 0: uuid
# 1: name
# 2: shortname
# 3: geom
# 4: isotwolettercode
# 5: longitude
# 6: isothreelettercode
# 7: latitude


class Ecospold2GeoExporter(object):
    """Read in a CSV export from Postgresql and write out an Ecospold XML file."""

    def __init__(
        self, output="Geographies.xml", languages=("es", "ja", "fr", "de", "zh")
    ):
        self.output_fp = os.path.realpath(
            os.path.join(
                os.path.abspath(os.path.dirname(__file__)), "..", "output", output
            )
        )
        self.input_fp = os.path.realpath(
            os.path.join(
                os.path.abspath(os.path.dirname(__file__)), "..", "output", "all.csv"
            )
        )
        self.languages = languages
        self.language_dictionary = {}
        for language in self.languages:
            # TODO: Can split string based on en-US, etc.
            locale = babel.Locale(language)
            self.language_dictionary[language] = locale.territories

        self.columns = [
            "id",
            "name",
            "shortname",
            "kml",
            "ISOTwoLetterCode",
            "longitude",
            "ISOThreeLetterCode",
            "latitude",
        ]

        self.input_reader = csv.reader(open(self.input_fp, encoding="utf-8"))
        self.create_document()  # Creates self.doc
        self.write_document()

    def create_document(self):
        G = ElementMaker(
            namespace="http://www.EcoInvent.org/EcoSpold02",
            nsmap={None: "http://www.EcoInvent.org/EcoSpold02"},
        )
        ROOT_ATTRS = {
            "contextId": "DE659012-50C4-4e96-B54A-FC781BF987AB",
            "majorRelease": "3",
            "minorRelease": "0",
        }
        self.doc = G.validGeographies(
            G.contextName("ecoinvent", {"{%s}lang" % XML_NS: "en"}),
            *[self.get_element(line, G) for line in list(self.input_reader)],
            **ROOT_ATTRS
        )

    def get_element(self, geo, G):
        data = dict(zip(self.columns, geo))

        NON_LANGUAGE_KEYS = {
            "id",
            "ISOTwoLetterCode",
            "UNCode",
            "longitude",
            "ISOThreeLetterCode",
            "latitude",
        }
        GEO_ATTRS = {
            key: value for key, value in data.items() if key in NON_LANGUAGE_KEYS
        }

        ELEMS = []

        # Get name in all other languages
        for language in self.languages:
            if data["ISOTwoLetterCode"] in self.language_dictionary[language]:
                ELEMS.append(
                    G.name(
                        self.language_dictionary[language][data["ISOTwoLetterCode"]],
                        {"{%s}lang" % XML_NS: language},
                    )
                )

        ELEMS += [
            G.name(data["name"], {"{%s}lang" % XML_NS: "en"}),
            G.shortname(data["shortname"], {"{%s}lang" % XML_NS: "en"}),
        ]

        # Add description if available
        # if geo.description:
        #     ELEMS.append(
        #         G.comment(
        #             G.text(geo.description,
        #                 {"{%s}lang" % XML_NS: "en", 'index': "0"}
        #         )))

        # Add KML fragment to names
        if getattr(data, "kml", None):
            ELEMS.append(
                G.kml(
                    G.Document(G.name(data["name"]), G.Placemark(fromstring(data["kml"])))
                )
            )
        else:
            print(f"No GIS coordinates for {data['name']}")
        return G.geography(*ELEMS, **GEO_ATTRS)

    # TODO: Add RoW and Global

    def write_document(self):
        with open(self.output_fp, "wb") as f:
            f.write(tostring(self.doc, encoding="utf8"))


if __name__ == "__main__":
    es = Ecospold2GeoExporter()
