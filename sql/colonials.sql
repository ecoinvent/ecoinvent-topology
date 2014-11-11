SET CLIENT_ENCODING TO UTF8;
SET STANDARD_CONFORMING_STRINGS TO ON;
SET client_min_messages TO WARNING;

BEGIN;

-- First, reset France and Netherlands to only be European
update geometries set topogeom = ToTopoGeom((
    select ST_Union(geometry(topogeom))
        from geometries
        where parent = 'Netherlands'
        and tname = 'ne_provinces'
        and name in ('Noord-Brabant', 'Utrecht', 'Zuid-Holland', 'Noord-Holland', 'Drenthe', 'Friesland', 'Gelderland', 'Groningen', 'Limburg', 'Overijssel', 'Flevoland', 'Zeeland')
    ), 'ei_topo', 1, 0.0)
    where name = 'Netherlands'
    and tname = 'ne_countries';
update geometries set topogeom = ToTopoGeom((
    select ST_Union(geometry(topogeom))
        from geometries
        where parent = 'France'
        and tname = 'ne_provinces'
        and name in ('Ain', 'Aisne', 'Allier', 'Alpes-Maritimes', 'Alpes-de-Haute-Provence', 'Ardennes', 'Ardèche', 'Ariège', 'Aube', 'Aude', 'Aveyron', 'Bas-Rhin', 'Bouches-du-Rhône', 'Calvados', 'Cantal', 'Charente', 'Charente-Maritime', 'Cher', 'Corrèze', 'Corse-du-Sud', 'Creuse', 'Côte-d''Or', 'Côtes-d''Armor', 'Deux-Sèvres', 'Dordogne', 'Doubs', 'Drôme', 'Essonne', 'Eure', 'Eure-et-Loir', 'Finistère', 'Gard', 'Gers', 'Gironde', 'Haute-Corse', 'Haute-Garonne', 'Haute-Loire', 'Haute-Marne', 'Haute-Rhin', 'Haute-Savoie', 'Haute-Saône', 'Haute-Vienne', 'Hautes-Alpes', 'Hautes-Pyrénées', 'Hauts-de-Seine', 'Hérault', 'Ille-et-Vilaine', 'Indre', 'Indre-et-Loire', 'Isère', 'Jura', 'Landes', 'Loir-et-Cher', 'Loire', 'Loire-Atlantique', 'Loiret', 'Lot', 'Lot-et-Garonne', 'Lozère', 'Maine-et-Loire', 'Manche', 'Marne',  'Mayenne',  'Meurhe-et-Moselle', 'Meuse', 'Morbihan', 'Moselle', 'Nièvre', 'Nord', 'Oise', 'Orne', 'Paris', 'Pas-de-Calais', 'Puy-de-Dôme', 'Pyrénées-Atlantiques', 'Pyrénées-Orientales', 'Rhône', 'Sarthe', 'Savoie', 'Saône-et-Loire', 'Seien-et-Marne', 'Seine-Maritime', 'Seine-Saint-Denis', 'Somme', 'Tarn', 'Tarn-et-Garonne', 'Territoire de Belfort', 'Val-d''Oise', 'Val-de-Marne', 'Var', 'Vaucluse', 'Vendée', 'Vienne', 'Vosges', 'Yonne', 'Yvelines')
    ), 'ei_topo', 1, 0.0)
    where name = 'France'
    and tname = 'ne_countries';
insert into geometries (name, tname, topogeom) values ('Bonaire, Saint Eustatius and Saba', 'ne_countries',  ToTopoGeom((
    select ST_Union(geometry(topogeom))
        from geometries
        where parent in ('Netherlands', 'Caribbean Netherlands')
        and tname = 'ne_provinces'
        and name in ('Saba', 'St. Eustatius', 'Bonaire')
    ), 'ei_topo', 1, 0.0)
);
insert into geometries (name, tname, topogeom) values ('French Guiana', 'ne_countries', ToTopoGeom((
    select geometry(topogeom)
        from geometries
        where parent = 'France'
        and tname = 'ne_provinces'
        and name = 'Guyane française'
    ), 'ei_topo', 1, 0.0)
);
insert into geometries (name, tname, topogeom) values ('Guadeloupe', 'ne_countries', ToTopoGeom((
    select geometry(topogeom)
        from geometries
        where parent = 'France'
        and tname = 'ne_provinces'
        and name = 'Guadeloupe'
    ), 'ei_topo', 1, 0.0)
);
insert into geometries (name, tname, topogeom) values ('Martinique', 'ne_countries', ToTopoGeom((
    select geometry(topogeom)
        from geometries
        where parent = 'France'
        and tname = 'ne_provinces'
        and name = 'Martinique'
    ), 'ei_topo', 1, 0.0)
);
insert into geometries (name, tname, topogeom) values ('Mayotte', 'ne_countries', ToTopoGeom((
    select geometry(topogeom)
        from geometries
        where parent = 'France'
        and tname = 'ne_provinces'
        and name = 'Mayotte'
    ), 'ei_topo', 1, 0.0)
);
insert into geometries (name, tname, topogeom) values ('Réunion', 'ne_countries', ToTopoGeom((
    select geometry(topogeom)
        from geometries
        where parent = 'France'
        and tname = 'ne_provinces'
        and name = 'La Réunion'
    ), 'ei_topo', 1, 0.0)
);
COMMIT;
