from pathlib import Path
import json
import sys

data_dir = Path(__file__).parent.parent.resolve() / "data" / "config"


def check_consistency():
    recipes = sorted([x[0] for x in json.load(open(data_dir / "recipes.json"))])
    um = sorted(
        [
            x["name"]
            for d in json.load(open(data_dir / "uuid-mapping.json")).values()
            for x in d
        ]
    )

    assert len(recipes) == len(set(recipes))
    assert len(um) == len(set(um))

    recipes, um = set(recipes), set(um)

    print("{} elements in `recipes.json`".format(len(recipes)))
    print("{} elements in `uuid-mapping.json`".format(len(um)))

    if recipes.difference(um):
        print(
            "Missing in `uuid-mapping.json`:\n\t", "\t\n".join(recipes.difference(um))
        )
        sys.exit(1)
    else:
        print("No inconsistencies found")


if __name__ == "__main__":
    check_consistency()
