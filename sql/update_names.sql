SET CLIENT_ENCODING TO UTF8;
SET STANDARD_CONFORMING_STRINGS TO ON;
SET client_min_messages TO WARNING;

BEGIN;

SELECT SingleCountry('Turkey');
UPDATE ne_countries SET name = 'Türkiye' WHERE name = 'Turkey';

-- SELECT SingleCountry('Republic of Serbia');
-- UPDATE ne_countries SET name = 'Serbia' WHERE name = 'Republic of Serbia';

SELECT SingleCountry('Democratic Republic of the Congo');
UPDATE ne_countries SET name = 'Congo, Democratic Republic of the' where name = 'Democratic Republic of the Congo';

SELECT SingleCountry('Republic of the Congo');
UPDATE ne_countries SET name = 'Congo' where name = 'Republic of the Congo';

SELECT SingleCountry('Bajo Nuevo Bank (Petrel Islands)');
UPDATE ne_countries SET name = 'Bajo Nuevo Bank (Petrel Is.)' where name = 'Bajo Nuevo Bank (Petrel Islands)';

SELECT SingleCountry('United States');
UPDATE ne_countries SET name = 'United States of America' where name = 'United States';

SELECT SingleCountry('Czech Republic');
UPDATE ne_countries SET name = 'Czechia' where name = 'Czech Republic';

SELECT SingleCountry('Federated States of Micronesia');
UPDATE ne_countries SET name = 'Micronesia, Federated States of' where name = 'Federated States of Micronesia';

-- SELECT SingleCountry('United Republic of Tanzania');
-- UPDATE ne_countries SET name = 'Tanzania' where name = 'United Republic of Tanzania';

SELECT SingleCountry('Åland Islands');
UPDATE ne_countries SET name = 'Aland' where name = 'Åland Islands';

UPDATE ne_provinces SET name_local = '黑龙江省' WHERE name = 'Heilongjiang';
UPDATE ne_provinces SET name_local = '青海' WHERE name = 'Qinghai';

SELECT SingleCountry('Russian Federation');
UPDATE ne_countries SET name = 'Russia' WHERE name = 'Russian Federation';

SELECT SingleCountry('Akrotiri');
UPDATE ne_countries SET name = 'Akrotiri Sovereign Base Area' WHERE name = 'Akrotiri';

SELECT SingleCountry('Dhekelia');
UPDATE ne_countries SET name = 'Dhekelia Sovereign Base Area' WHERE name = 'Dhekelia';

SELECT SingleCountry('Cyprus U.N. Buffer Zone');
UPDATE ne_countries SET name = 'Cyprus No Mans Area' WHERE name = 'Cyprus U.N. Buffer Zone';

SELECT SingleCountry('Heard I. and McDonald Islands');
UPDATE ne_countries SET name = 'Heard Island and McDonald Islands' WHERE name = 'Heard I. and McDonald Islands';

COMMIT;
