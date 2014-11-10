SET CLIENT_ENCODING TO UTF8;
SET STANDARD_CONFORMING_STRINGS TO ON;
SET client_min_messages TO WARNING;

BEGIN;
insert into final (gid, collection, name, shortname, isotwolettercode, isothreelettercode, uncode, unregioncode, geom)
    select g.gid, 'countries', g.name, c.iso_a2, c.iso_a2, c.iso_a3, un_a3::int, null, geometry(g.topogeom)
    from geometries g
    left join ne_countries c on g.gid = c.gid
    where g.tname = 'ne_countries';

update final set geom = (
    select ST_Union(geometry(topogeom))
        from geometries
        where parent = 'Netherlands'
        and tname = 'ne_provinces'
        and name in ('Noord-Brabant', 'Utrecht', 'Zuid-Holland', 'Noord-Holland', 'Drenthe', 'Friesland', 'Gelderland', 'Groningen', 'Limburg', 'Overijssel', 'Flevoland', 'Zeeland')
    ) where name = 'Netherlands';

update final set geom = (
    select ST_Union(geometry(topogeom))
        from geometries
        where parent = 'France'
        and tname = 'ne_provinces'
        and name in ('Ain', 'Aisne', 'Allier', 'Alpes-Maritimes', 'Alpes-de-Haute-Provence', 'Ardennes', 'Ardèche', 'Ariège', 'Aube', 'Aude', 'Aveyron', 'Bas-Rhin', 'Bouches-du-Rhône', 'Calvados', 'Cantal', 'Charente', 'Charente-Maritime', 'Cher', 'Corrèze', 'Corse-du-Sud', 'Creuse', 'Côte-d''Or', 'Côtes-d''Armor', 'Deux-Sèvres', 'Dordogne', 'Doubs', 'Drôme', 'Essonne', 'Eure', 'Eure-et-Loir', 'Finistère', 'Gard', 'Gers', 'Gironde', 'Haute-Corse', 'Haute-Garonne', 'Haute-Loire', 'Haute-Marne', 'Haute-Rhin', 'Haute-Savoie', 'Haute-Saône', 'Haute-Vienne', 'Hautes-Alpes', 'Hautes-Pyrénées', 'Hauts-de-Seine', 'Hérault', 'Ille-et-Vilaine', 'Indre', 'Indre-et-Loire', 'Isère', 'Jura', 'Landes', 'Loir-et-Cher', 'Loire', 'Loire-Atlantique', 'Loiret', 'Lot', 'Lot-et-Garonne', 'Lozère', 'Maine-et-Loire', 'Manche', 'Marne',  'Mayenne',  'Meurhe-et-Moselle', 'Meuse', 'Morbihan', 'Moselle', 'Nièvre', 'Nord', 'Oise', 'Orne', 'Paris', 'Pas-de-Calais', 'Puy-de-Dôme', 'Pyrénées-Atlantiques', 'Pyrénées-Orientales', 'Rhône', 'Sarthe', 'Savoie', 'Saône-et-Loire', 'Seien-et-Marne', 'Seine-Maritime', 'Seine-Saint-Denis', 'Somme', 'Tarn', 'Tarn-et-Garonne', 'Territoire de Belfort', 'Val-d''Oise', 'Val-de-Marne', 'Var', 'Vaucluse', 'Vendée', 'Vienne', 'Vosges', 'Yonne', 'Yvelines')
    ) where name = 'France';

-- update final set name = 'France, including overseas territories', shortname = 'FR (political)' where name = 'France' and collection = 'countries';
-- update final set name = 'Spain, including overseas territories', shortname = 'ES (political)' where name = 'Spain' and collection = 'countries';

COMMIT;
