import requests
import subprocess

url = "https://glossary.ecoinvent.org/geography/"
ecoinvent_names = {o['item']['name'] for o in requests.get(url, headers={"Accept": "Application/ld+json"}).json()['itemListElement']}

command = 'psql -U ecoinvent -d eigeo -c "COPY (SELECT name FROM final) TO STDOUT;"'
p = subprocess.Popen(command, shell=True, stdout=subprocess.PIPE)
our_names = set(p.communicate()[0].decode("utf8").split("\n"))

diff = ecoinvent_names.difference(our_names)

if diff:
    print("Differences found:")
    for name in diff:
        print(f"\t{name}")
