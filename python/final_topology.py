import pyprind
import subprocess
import sys

layer_id = int(
    subprocess.Popen(
        "psql -U ecoinvent -d eigeo -c \"select layer_id from topology.layer where table_name = 'final';\"",
        shell=True,
        stdout=subprocess.PIPE,
    )
    .communicate()[0]
    .decode("utf8")
    .split("\n")[2]
)

num_features = int(
    subprocess.Popen(
        'psql -U ecoinvent -d eigeo -c "select count(*) from final";',
        shell=True,
        stdout=subprocess.PIPE,
    )
    .communicate()[0]
    .decode("utf8")
    .split("\n")[2]
)

chunk_size = 5

command = (
    """psql -U ecoinvent -d eigeo -c "SET client_min_messages TO WARNING; UPDATE final SET topogeom = toTopoGeom(geom, 'ei_final', %i, 0.0) WHERE id IN (SELECT id FROM final WHERE topogeom IS NULL LIMIT %i);" -q -n -o create_db.log"""
    % (layer_id, chunk_size)
)

num_chunks = num_features // chunk_size + 1

for x in pyprind.prog_bar(range(num_chunks)):
    subprocess.check_call(command, shell=True)
