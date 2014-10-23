# -*- coding: utf-8 -*
import json

template_multi = u"""SELECT ST_Union(geometry(topogeom)) FROM geometries INNER JOIN (VALUES %s) AS v("tname", "name") USING ("tname", "name");"""

data = json.load(open("../data/config/recipes.json"))

for name, components in data:
    s = u", ".join([u"('%s', '%s')" % (tname, name) for tname, values in components.items() for name in values])
    print (template_multi % s).encode('utf8')
