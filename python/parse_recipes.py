# -*- coding: utf-8 -*
import codecs
import json
import os


HEADER = u"""SET CLIENT_ENCODING TO UTF8;
SET STANDARD_CONFORMING_STRINGS TO ON;
SET client_min_messages TO WARNING;

BEGIN;\n"""
FOOTER = u"""\nCOMMIT;\n"""

TEMPLATE_SIMPLE = u"""INSERT INTO final (name, collection, geom) select %s, 'recipes', ST_Union(geometry(g.topogeom)) FROM geometries g where g.tname = %s and g.name = %s;"""
TEMPLATE_SINGLE = u"""INSERT INTO final (name, collection, geom) select %s, 'recipes', ST_Union(geometry(g.topogeom)) FROM geometries g where g.tname = %s and g.name in (%s);"""
# TEMPLATE_MULTI = u""""""

data = json.load(open(os.path.join(os.getcwd(), "data", "config", "recipes.json")))

sql = []

def _(s):
    return u"'%s'" % s.replace("'", "''")

for name, components in data:
    if len(components) == 1 and len(components.values()[0]) == 1:
        sql.append(TEMPLATE_SIMPLE % (_(name), _(components.keys()[0]), _(components.values()[0][0])))
    elif len(components) == 1:
        sql.append(TEMPLATE_SINGLE % (_(name), _(components.keys()[0]), ", ".join([_(x) for x in components.values()[0]])))

    # s = u", ".join([u"('%s', '%s')" % (tname, name) for tname, values in components.items() for name in values])
    # print (template_multi % s).encode('utf8')



with codecs.open(os.path.join(os.getcwd(), "sql", "recipes.sql"), "w", encoding='utf8') as f:
    f.write(HEADER)
    f.write("\n".join(sql))
    f.write(FOOTER)
