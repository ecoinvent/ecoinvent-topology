import argparse
import fiona
import os


def select_feature_to_gpkg(name, data_fp, out_fp):
    with fiona.drivers():
        with fiona.open(data_fp) as source:
            source.meta['crs'] = {'no_defs': True, 'ellps': 'WGS84', 'datum': 'WGS84', 'proj': 'longlat'}
            with fiona.open(out_fp, 'w', **source.meta) as sink:
                for feature in source:
                    if feature['properties']['name'] == name:
                        sink.write(feature)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Extract feature to new geopackage.')
    parser.add_argument('feature_name', type=str)
    parser.add_argument('filename', type=str)

    args = parser.parse_args()
    in_fp = os.path.realpath(os.path.join(
        os.path.abspath(os.path.dirname(__file__)),
        "..", "data", "intermediate", "ecoinvent_geographies.gpkg"
    ))

    assert "-" not in args.filename, "Geopackage filenames can't have '-'"

    out_fp = os.path.realpath(os.path.join(
        os.path.abspath(os.path.dirname(__file__)),
        "..", "data", "intermediate",
        u"%s.gpkg" % args.filename.decode('utf8').replace(".gpkg", "")
    ))

    assert not os.path.exists(out_fp), "File already exists"

    select_feature_to_gpkg(args.feature_name.decode('utf8'), in_fp, out_fp)


