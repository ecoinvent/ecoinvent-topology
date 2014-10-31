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

BEGINNING = u"""INSERT INTO final (name, collection, geom) SELECT {name}, {collection}, ST_Union(geometry(t1.topogeom)) FROM ("""
TEMPLATE = u"""SELECT topogeom FROM geometries g where g.tname = {tablename} {parent}and g.name {name_filter} """


data = json.load(open(os.path.join(os.getcwd(), "data", "config", "recipes.json")))
sql = []

_ = lambda s: u"'%s'" % s.replace("'", "''")
together = lambda values: "UNION ".join(list(values))


def list_or_not(values):
    if isinstance(values, basestring):
        return u"= " + _(values)
    elif len(values) == 1:
        return u"= " + _(values[0])
    else:
        return u"IN (" + u", ".join([_(x) for x in values]) + u")"


def format_query(tablename, objects):
    if tablename == "ne_provinces":
        return handle_provinces(tablename, objects)
    else:
        return [TEMPLATE.format(parent=u"", name_filter=list_or_not(objects), tablename=_(tablename))]


def handle_provinces(tablename, objects):
    return [TEMPLATE.format(
        parent=u"AND g.parent = {p} ".format(p=_(country)),
        name_filter=list_or_not(provinces),
        tablename=_(tablename)
        ) for country, provinces in zip(objects[::2], objects[1::2])
    ]


def consolidate(components):
    return together(itertools.chain(*[format_query(x, y) for x, y in components.iteritems()]))


sql = "\n".join([BEGINNING.format(name=_(x), collection=_(y)) + consolidate(z).strip() + u") as t1;" for x, y, z in data])

with codecs.open(os.path.join(os.getcwd(), "sql", "recipes.sql"), "w", encoding='utf8') as f:
    f.write(HEADER)
    f.write(sql)
    f.write(FOOTER)
