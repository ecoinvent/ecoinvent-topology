import subprocess
import sys

valid_geom_final = 'psql -U ecoinvent -d eigeo -c "select name from final where not st_isvalid(geom)";'

def check_command(command, error, ok, expected="(0 rows)"):
    p = subprocess.Popen(command, shell=True, stdout=subprocess.PIPE)
    result = p.communicate()[0]
    if expected not in result:
        raise sys.exit(error)
    else:
        print ok

check_command(valid_geom_final, "Valid geometries", "All final geometries are valid")
