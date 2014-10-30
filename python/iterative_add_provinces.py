import subprocess

command_all = """psql -U ecoinvent -d eigeo -c "update geometries gg set topogeom = PolygonTopoUnion('ei_topo', 1, f.p, f.c) from (
    select p.name as province_name, p.admin as province_admin, c.name as country_name, c.admin as country_admin, g.id as province_id, g2.id as country_id, g.topogeom as p, g2.topogeom as c
        from geometries g
        left join ne_provinces p on g.gid = p.gid
        left join ne_countries c on c.admin = p.admin
        left join geometries g2 on g2.gid = c.gid
        where g.tname = 'ne_provinces'
        and g2.tname = 'ne_countries'
        and not topocontains(g2.topogeom, g.topogeom)
        order by g.name, g2.name
) as f
where gg.id = f.country_id;" """.replace("\n", " ").replace("    ", " ").replace("  ", " ")

command_one = """psql -U ecoinvent -d eigeo -c "update geometries gg set topogeom = PolygonTopoUnion('ei_topo', 1, f.p, f.c) from (
    select p.name as province_name, p.admin as province_admin, c.name as country_name, c.admin as country_admin, g.id as province_id, g2.id as country_id, g.topogeom as p, g2.topogeom as c
        from geometries g
        left join ne_provinces p on g.gid = p.gid
        left join ne_countries c on c.admin = p.admin
        left join geometries g2 on g2.gid = c.gid
        where g.tname = 'ne_provinces'
        and g2.tname = 'ne_countries'
        and not topocontains(g2.topogeom, g.topogeom)
        order by g.name, g2.name
        limit 1
) as f
where gg.id = f.country_id;" """.replace("\n", " ").replace("    ", " ").replace("  ", " ")

for x in range(5):
    p = subprocess.Popen(command_all, shell=True, stdout=subprocess.PIPE)

while True:
    p = subprocess.Popen(command_one, shell=True, stdout=subprocess.PIPE)
    result = p.communicate()[0]
    if result.strip() == "UPDATE 1":
        print "tick", result
        pass
    else:
        break

