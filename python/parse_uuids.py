# -*- coding: utf-8 -*
import codecs
import json
import os


HEADER = """SET CLIENT_ENCODING TO UTF8;
SET STANDARD_CONFORMING_STRINGS TO ON;
SET client_min_messages TO WARNING;

BEGIN;\n"""
FOOTER = """\nCOMMIT;\n"""

TEMPLATE = (
    """UPDATE final SET shortname='{shortname}', uuid='{uuid}' WHERE name = '{name}';"""
)

data = json.load(open(os.path.join(os.getcwd(), "data", "config", "uuid-mapping.json")))

def escaper(dct):
    _ = lambda s: s.replace("'", "''")
    return {key: _(value) for key, value in dct.items()}

sql = "\n".join([TEMPLATE.format(**escaper(line)) for row in data for line in data[row]])

with codecs.open(
    os.path.join(os.getcwd(), "sql", "uuids.sql"), "w", encoding="utf8"
) as f:
    f.write(HEADER)
    f.write(sql)
    f.write(FOOTER)
