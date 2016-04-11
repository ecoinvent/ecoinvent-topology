import json
import os
import re
import csv

numbers = re.compile('{(?P<face_id>\d+),3}')

fp = os.path.join(os.getcwd(), "output", "faces.csv")
outpath = os.path.join(os.getcwd(), "output", "faces.json")

def get_face_ids(row):
    return (row[0], [int(x) for x in numbers.findall(row[1])])

with open(fp, encoding='utf-8') as f:
    data = [get_face_ids(row) for row in csv.reader(f)]

ALL = {obj for row in data for obj in row[1]}
data.append(("__all__", list(ALL)))
data.sort()

json.dump(data, open(outpath, "w", encoding='utf8'), indent=2, ensure_ascii=False)
