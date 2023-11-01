import os
import re
import subprocess
import sys
import csv

valid_geom_final = (
    'psql -U ecoinvent -d eigeo -c "select name from final where not st_isvalid(geom)";'
)


def check_command(command, error, ok, expected="(0 rows)"):
    p = subprocess.Popen(command, shell=True, stdout=subprocess.PIPE)
    result = p.communicate()[0].decode("utf8")
    if expected not in result:
        raise sys.exit(error)
    else:
        print(ok)


numbers = re.compile("{(?P<face_id>\\d+),3}")


def check_country_faces():
    fp = os.path.join(os.getcwd(), "output", "faces-check.csv")
    errors = []

    def get_face_ids(row):
        return (row[0], {int(x) for x in numbers.findall(row[1])})

    with open(fp, "r", encoding="utf8") as f:
        data = [get_face_ids(row) for row in csv.reader(f)]

    for index, first in enumerate(data):
        for second in data[index + 1 :]:
            if first[1].intersection(second[1]):
                errors.append((first[0], second[0]))

    if errors:
        print("Error: Overlapping countries found:")
        for row in errors:
            print(row)
        sys.exit(1)
    else:
        print("No overlapping countries")


if __name__ == "__main__":
    check_command(
        valid_geom_final, "Valid geometries", "All final geometries are valid"
    )
    check_country_faces()
