SET CLIENT_ENCODING TO UTF8;
SET STANDARD_CONFORMING_STRINGS TO ON;
BEGIN;

CREATE OR REPLACE FUNCTION EliminateNonBranchingNodes()
RETURNS int AS $$
    select ST_ModEdgeHeal('ei_topo', outr.lft, outr.rght) from (
        select distinct
            (case when edge1.edge_id < edge2.edge_id then edge1.edge_id else edge2.edge_id end) as lft,
            (case when edge1.edge_id < edge2.edge_id then edge2.edge_id else edge1.edge_id end) as rght
            from (
                select node_id as nid
                    from ei_topo.node
                    left join ei_topo.edge_data as foo1 on foo1.start_node = node_id
                    left join ei_topo.edge_data as foo2 on foo2.end_node = node_id
                    where foo1.edge_id != foo2.edge_id
                    group by node_id
                    having count(*) = 1
            ) as innr
        left join ei_topo.edge_data as edge1 on edge1.start_node = innr.nid
        left join ei_topo.edge_data as edge2 on edge2.end_node = innr.nid
        group by lft, rght
    ) as outr
    where ((select count(*) from ei_topo.edge_data where edge_id = lft) + (select count(*) from ei_topo.edge_data where edge_id = rght)) > 1
    limit 1;
$$ language 'sql';

COMMIT;
