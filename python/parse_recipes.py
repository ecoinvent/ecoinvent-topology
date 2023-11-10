# -*- coding: utf-8 -*
import codecs
import itertools
import json
import os


HEADER = """SET CLIENT_ENCODING TO UTF8;
SET STANDARD_CONFORMING_STRINGS TO ON;
SET client_min_messages TO WARNING;

BEGIN;\n"""
FOOTER = """\nCOMMIT;\n"""

BEGINNING = """INSERT INTO final (name, collection, geom, faces) SELECT {name}, {collection}, ST_Multi(ST_Union(geometry(t1.topogeom))), intarrays_cat(GetTopoGeomElementArray(t1.topogeom)::int[]) FROM ("""
TEMPLATE = """SELECT topogeom FROM geometries g where g.tname = {tablename} {parent} and g.name {name_filter} """


data = json.load(open(os.path.join(os.getcwd(), "data", "config", "recipes.json")))
sql = []

_ = lambda s: "'%s'" % s.replace("'", "''")
together = lambda values: "UNION ".join(list(values))


def list_or_not(values):
    if isinstance(values, str):
        return "= " + _(values)
    elif len(values) == 1:
        return "= " + _(values[0])
    else:
        return "IN (" + ", ".join([_(x) for x in values]) + ")"


def format_query(tablename, objects):
    if tablename == "ne_provinces":
        return handle_provinces(tablename, objects)
    else:
        return [
            TEMPLATE.format(
                parent="", name_filter=list_or_not(objects), tablename=_(tablename)
            )
        ]


def handle_provinces(tablename, objects):
    return [
        TEMPLATE.format(
            parent="AND g.parent = {p} ".format(p=_(country)),
            name_filter=list_or_not(provinces),
            tablename=_(tablename),
        )
        for country, provinces in zip(objects[::2], objects[1::2])
    ]


def consolidate(components):
    return together(
        itertools.chain(*[format_query(x, y) for x, y in components.items()])
    )


sql = "\n".join(
    [
        BEGINNING.format(name=_(x), collection=_(y))
        + consolidate(z).strip()
        + ") as t1;"
        for x, y, z in data
    ]
)

with codecs.open(
    os.path.join(os.getcwd(), "sql", "recipes.sql"), "w", encoding="utf8"
) as f:
    f.write(HEADER)
    f.write(sql)
    f.write(FOOTER)
