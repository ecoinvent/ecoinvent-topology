import subprocess

command = 'psql -U ecoinvent -d eigeo -c "SELECT EliminateNonBranchingNodes();"'
num = 0

while True:
    p = subprocess.Popen(command, shell=True, stdout=subprocess.PIPE)
    if "(1 row)" not in p.communicate()[0]:
        break
    else:
        num += 1
    if num and not num % 100:
        print "%s nodes eliminated" % num
