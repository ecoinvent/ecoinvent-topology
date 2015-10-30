# -*- coding: utf-8 -*
import codecs
import itertools
import json
import os


HEADER = u"""SET CLIENT_ENCODING TO UTF8;
SET STANDARD_CONFORMING_STRINGS TO ON;
SET client_min_messages TO WARNING;

BEGIN;\n"""
FOOTER = u"""\nCOMMIT;\n"""

TEMPLATE = u"""UPDATE final SET shortname='{shortname}', uuid='{uuid}' WHERE name = '{name}';"""
CANADA_TEMPLATE = u"""UPDATE final SET shortname='{shortname}', uuid='{uuid}', name='Canada, {name}' WHERE name = '{name}';"""
CHINA_TEMPLATE = u"""UPDATE final SET shortname='{shortname}', uuid='{uuid}', name='China, {name}' WHERE name = '{name}';"""

def format_line(line, row):
    if row == "Chinese provinces":
        template = CHINA_TEMPLATE
    elif row == "Canada":
        template = CANADA_TEMPLATE
    else:
        template = TEMPLATE

    return template.format(**line)


data = json.load(open(os.path.join(os.getcwd(), "data", "config", "uuid-mapping.json")))

sql = "\n".join([format_line(line, row) for row in data for line in data[row]])

with codecs.open(os.path.join(os.getcwd(), "sql", "uuids.sql"), "w", encoding='utf8') as f:
    f.write(HEADER)
    f.write(sql)
    f.write(FOOTER)
