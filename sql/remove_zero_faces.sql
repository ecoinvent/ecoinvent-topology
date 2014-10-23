select st_RemEdgeModFace('ei_topo', abs(t1.edge))
    from (
        select (ST_GetFaceEdges('ei_topo', face_id)).*
            from ei_topo.face
            where ST_Area(ST_GetFaceGeometry('ei_topo', face_id)) < 1e-14
            and face_id > 0
    ) as t1
    where t1.sequence = 1;





select abs(t1.edge)
    from (
        select (ST_GetFaceEdges('ei_topo', face_id)).*
            from ei_topo.face
            where ST_Area(ST_GetFaceGeometry('ei_topo', face_id)) < 1e-14
            and face_id > 0
    ) as t1
    where t1.sequence = 1;
