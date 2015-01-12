import progressbar
import subprocess
import sys

layer_id = int(
    subprocess.Popen(
        'psql -U ecoinvent -d eigeo -c "select layer_id from topology.layer where table_name = \'final\';"',
        shell=True,
        stdout=subprocess.PIPE
    ).communicate()[0].split("\n")[2]
)

num_features = int(
    subprocess.Popen(
        'psql -U ecoinvent -d eigeo -c "select count(*) from final";',
        shell=True,
        stdout=subprocess.PIPE
    ).communicate()[0].split("\n")[2]
)

chunk_size = 5

command = """psql -U ecoinvent -d eigeo -c "SET client_min_messages TO WARNING; UPDATE final SET topogeom = toTopoGeom(geom, 'ei_final', %i, 0.0) WHERE id IN (SELECT id FROM final WHERE topogeom IS NULL LIMIT %i);" -q -n -o create_db.log""" % (layer_id, chunk_size)

num_chunks = num_features // chunk_size + 1

widgets = [
    progressbar.SimpleProgress(sep="/"), " (",
    progressbar.Percentage(), ') ',
    progressbar.Bar(marker=progressbar.RotatingMarker()), ' ',
    progressbar.ETA()
]
pbar = progressbar.ProgressBar(
    widgets=widgets,
    maxval=num_chunks
).start()

for x in xrange(num_chunks):
    subprocess.check_call(command, shell=True)
    pbar.update(x)

pbar.finish()
