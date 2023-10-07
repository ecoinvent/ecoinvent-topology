import json
import codecs
import os

dirpath = "data/config/recipes.json"
data = json.load(open(dirpath))
json.dump(
    data, codecs.open(dirpath, "w", encoding="utf8"), indent=2, ensure_ascii=False
)
