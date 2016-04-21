import argparse
import json
import os
from lxml import objectify


def remove_namespace(doc, namespace=u"{http://www.EcoInvent.org/EcoSpold02}"):
    """Remove namespace in the passed document in place."""
    ns = u'{}'.format(namespace)
    nsl = len(ns)
    for elem in doc.getiterator():
        if elem.tag.startswith(ns):
            elem.tag = elem.tag[nsl:]


class EcoinventChecker(object):
    def __init__(self, fp):
        assert os.path.isfile(fp)

        config = {obj.pop('uuid'): obj for obj in self.extract_config_data()}
        ecoinvent = {obj.pop('id'): obj for obj in self.extract_ecoinvent_data(fp)}

        log_fp = os.path.abspath(os.path.join(
            os.path.abspath(os.path.dirname(__file__)),
            "..", "output", "ecoinvent-check.log"
        ))
        with open(log_fp, "w") as logfile:
            print("Checking on missing UUIDs in ecoinvent")
            logfile.write("Checking on missing UUIDs in ecoinvent\n")
            for key in config:
                if key not in ecoinvent:
                    logfile.write("{}: {}, {}\n".format(key, config[key]['name'], config[key]['shortname']))

            print("Checking on missing UUIDs in config")
            logfile.write("\nChecking on missing UUIDs in config\n")
            for key in ecoinvent:
                if key not in config:
                    logfile.write("{}: {}, {}\n".format(key, ecoinvent[key]['name'], ecoinvent[key]['shortname']))

            all_keys = set(ecoinvent.keys()).intersection(set(config.keys()))

            print("Checking on name differences")
            logfile.write("\nChecking on name differences (config, ecoinvent)\n")
            for key in all_keys:
                if ecoinvent[key]['name'] != config[key]['name']:
                    logfile.write("{}: {}\n".format(config[key]['name'], ecoinvent[key]['name']))

            print("Checking on shortname differences")
            logfile.write("\nChecking on shortname differences (config, ecoinvent)\n")
            for key in all_keys:
                if ecoinvent[key]['shortname'] != config[key]['shortname']:
                    logfile.write("{}: {}\n".format(config[key]['shortname'], ecoinvent[key]['shortname']))

        print("Log written to {}".format(log_fp))

    def extract_config_data(self):
        data = []
        for elem in json.load(open(self.get_config_fp())).values():
            data.extend(elem)
        return data

    def get_config_fp(self):
        return os.path.join(
            os.path.abspath(os.path.dirname(__file__)),
            "..", "data", "config", "uuid-mapping.json"
        )

    def extract_ecoinvent_data(self, fp):
        data = []
        xml = objectify.parse(open(fp))
        root = xml.getroot()
        remove_namespace(root)
        objectify.deannotate(root, cleanup_namespaces=True)

        for obj in root.iterchildren():
            if obj.tag != "geography":
                continue
            name = obj.name
            shortname = obj.shortname
            data.append({
                'id': obj.get('id'),
                'name': name.text,
                'shortname': shortname.text
            })
        return data


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Check UUIDs and names against ecoinvent master data.')
    parser.add_argument(
        'filepath',
        type=str,
        help='`Geographies.xml` filepath from EcoEditor'
    )

    args = parser.parse_args()
    EcoinventChecker(args.filepath)

