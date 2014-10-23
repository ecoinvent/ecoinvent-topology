import subprocess

no_duplicate_a3_codes = 'psql -U ecoinvent -d eigeo -c "select code, count from (select distinct su_a3 as code, count(distinct su_a3) from ne_countries group by su_a3) as t1 where count > 1;"'


def check_command(command, error, ok, expected="(0 rows)"):
    p = subprocess.Popen(command, shell=True, stdout=subprocess.PIPE)
    result = p.communicate()[0]
    if expected not in result:
        raise ValueError(error)
    else:
        print ok

check_command(no_duplicate_a3_codes, "Duplicate A3 codes", "A3 codes are all unique")
