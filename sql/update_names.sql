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

SELECT SingleCountry('Federated States of Micronesia');
UPDATE ne_countries SET name = 'Micronesia, Federated States of' where name = 'Federated States of Micronesia';

-- SELECT SingleCountry('United Republic of Tanzania');
-- UPDATE ne_countries SET name = 'Tanzania' where name = 'United Republic of Tanzania';

SELECT SingleCountry('Åland Islands');
UPDATE ne_countries SET name = 'Aland' where name = 'Åland Islands';

UPDATE ne_provinces SET name_local = '黑龙江省' WHERE name = 'Heilongjiang';
UPDATE ne_provinces SET name_local = '青海' WHERE name = 'Qinghai';

SELECT SingleCountry('Akrotiri');
UPDATE ne_countries SET name = 'Akrotiri Sovereign Base Area' WHERE name = 'Akrotiri';

SELECT SingleCountry('Dhekelia');
UPDATE ne_countries SET name = 'Dhekelia Sovereign Base Area' WHERE name = 'Dhekelia';

SELECT SingleCountry('Cyprus U.N. Buffer Zone');
UPDATE ne_countries SET name = 'Cyprus No Mans Area' WHERE name = 'Cyprus U.N. Buffer Zone';

COMMIT;