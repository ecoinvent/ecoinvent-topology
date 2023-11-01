from lxml import objectify
import fiona

ours = {
    dict(feat.properties)['uuid']: dict(feat.properties)['name']
    for feat in fiona.open("output/all.gpkg")
}

ei = {
    geo.get('id'): geo.name.text
    for geo in objectify.parse(open("/Users/chrismutel/Downloads/Geographies.xml")).getroot().geography
}

ours_r = {v: k for k, v in ours.items()}
