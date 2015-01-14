import codecs
import json
import os
import re
import unicodecsv

numbers = re.compile('{(?P<face_id>\d+),3}')

fp = os.path.join(os.getcwd(), "output", "faces.csv")
outpath = os.path.join(os.getcwd(), "output", "faces.json")

def get_face_ids(row):
    return (row[0], [int(x) for x in numbers.findall(row[1])])

with open(fp) as f:
    data = [get_face_ids(row) for row in unicodecsv.reader(f, encoding='utf-8')]

ALL = reduce(set.union, [set(row[1]) for row in data])
data.append(("__all__", list(ALL)))
data.sort()

json.dump(data, codecs.open(outpath, "w", encoding='utf8'), indent=2, ensure_ascii=False)
