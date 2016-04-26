import json
import os
import re
import csv
import hashlib


def sha256(filepath, blocksize=65536):
    """Generate SHA 256 hash for file at `filepath`"""
    hasher = hashlib.sha256()
    fo = open(filepath, 'rb')
    buf = fo.read(blocksize)
    while len(buf) > 0:
        hasher.update(buf)
        buf = fo.read(blocksize)
    return hasher.hexdigest()

base_path = os.path.abspath(os.path.dirname(__file__))

numbers = re.compile('{(?P<face_id>\d+),3}')

fp = os.path.abspath(os.path.join(base_path, '..', "output", "faces.csv"))
outpath = os.path.abspath(os.path.join(base_path, '..', "output", "faces.json"))

def get_face_ids(row):
    return (row[0], [int(x) for x in numbers.findall(row[1])])

with open(fp, encoding='utf-8') as f:
    face_data = [get_face_ids(row) for row in csv.reader(f)]

ALL = {obj for row in face_data for obj in row[1]}
face_data.append(("__all__", list(ALL)))
face_data.sort()

gpkg_fp = os.path.abspath(os.path.join(base_path, '..', "output", "faces.gpkg"))

data = {
    'metadata': {
        'sha256': sha256(gpkg_fp),
        'field': 'id',
        'filename': 'faces.gpkg'
    },
    'data': face_data
}

json.dump(data, open(outpath, "w", encoding='utf8'), indent=2, ensure_ascii=False)
