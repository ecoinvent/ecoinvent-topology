from lxml import objectify, etree
import fastkml
import fiona
import shapely
import os


def remove_namespace(doc, namespace=u"{http://www.EcoInvent.org/EcoSpold02}"):
    """Remove namespace in the passed document in place."""
    ns = u'{}'.format(namespace)
    nsl = len(ns)
    for elem in doc.getiterator():
        if elem.tag.startswith(ns):
            elem.tag = elem.tag[nsl:]


def xml_to_geopackage(in_fp, out_fp):
    if os.path.exists(out_fp):
        os.remove(out_fp)

    xml = objectify.parse(open(in_fp))
    root = xml.getroot()
    remove_namespace(root)
    objectify.deannotate(root, cleanup_namespaces=True)

    meta = {
        'crs': {'no_defs': True, 'ellps': 'WGS84', 'datum': 'WGS84', 'proj': 'longlat'},
        'driver': 'GPKG',
        'schema': {
            'geometry': 'MultiPolygon',
            'properties': {'name': 'str', 'uuid': 'str', 'code': 'float'}
        }
    }

    with fiona.drivers():
        with fiona.open(out_fp, "w", **meta) as dest:
            for el in root.geography:
                try:
                    parsed = fastkml.kml.KML()
                    parsed.from_string(etree.tostring(getattr(el, "{http://www.opengis.net/kml/2.2}kml"), encoding="utf8"))
                except AttributeError:
                    print("Skipping %s" % el.name)
                    continue

                geom = parsed.features().next().features().next().geometry
                if not geom.is_valid:
                    clean = shapely.geometry.multipolygon.MultiPolygon([geom.buffer(0.0)])
                    assert clean.is_valid
                    geom = clean

                dest.write({
                    'geometry': shapely.geometry.mapping(geom),
                    'properties': {
                        'name': unicode(el.name),
                        'uuid': unicode(el.get('id')),
                        'code': unicode(el.shortname)
                    }
                })


if __name__ == "__main__":
    IN_FP = os.path.realpath(os.path.join(
        os.path.abspath(os.path.dirname(__file__)),
        "..", "data", "raw", "Geographies.xml"
    ))
    OUT_FP = os.path.realpath(os.path.join(
        os.path.abspath(os.path.dirname(__file__)),
        "..", "data", "intermediate", "ecoinvent_geographies.gpkg"
    ))
    xml_to_geopackage(IN_FP, OUT_FP)
