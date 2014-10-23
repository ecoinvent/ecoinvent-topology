import subprocess

command = 'psql -U ecoinvent -d eigeo -c "SELECT EliminateNonBranchingNodes();"'
num = 0

while True:
    p = subprocess.Popen(command, shell=True, stdout=subprocess.PIPE)
    result = p.communicate()[0]
    if not result.split("\n")[2].strip():
        break
    else:
        num += 1

print "%s nodes eliminated" % num
