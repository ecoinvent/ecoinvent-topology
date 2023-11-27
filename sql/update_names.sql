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

SELECT SingleCountry('Brunei Darussalam');
UPDATE ne_countries SET name = 'Brunei' where name = 'Brunei Darussalam';

SELECT SingleCountry('Republic of Cabo Verde');
UPDATE ne_countries SET name = 'Cape Verde' where name = 'Republic of Cabo Verde';

SELECT SingleCountry('Kingdom of eSwatini');
UPDATE ne_countries SET name = 'Eswatini' where name = 'Kingdom of eSwatini';

SELECT SingleCountry('Falkland Islands / Malvinas');
UPDATE ne_countries SET name = 'Falkland Islands' where name = 'Falkland Islands / Malvinas';

SELECT SingleCountry('Faeroe Islands');
UPDATE ne_countries SET name = 'Faroe Islands' where name = 'Faeroe Islands';

-- SELECT SingleCountry('French Southern and Antarctic Lands');
-- UPDATE ne_countries SET name = 'French Southern Territories' where name = 'French Southern and Antarctic Lands';

SELECT SingleCountry('The Gambia');
UPDATE ne_countries SET name = 'Gambia' where name = 'The Gambia';

SELECT SingleCountry('Côte d''Ivoire');
UPDATE ne_countries SET name = 'Ivory Coast' where name = 'Côte d''Ivoire';

SELECT SingleCountry('Lao PDR');
UPDATE ne_countries SET name = 'Laos' where name = 'Lao PDR';

SELECT SingleCountry('South Georgia and the Islands');
UPDATE ne_countries SET name = 'South Georgia and South Sandwich Islands' where name = 'South Georgia and the Islands';

SELECT SingleCountry('Wallis and Futuna Islands');
UPDATE ne_countries SET name = 'Wallis and Futuna' where name = 'Wallis and Futuna Islands';

SELECT SingleCountry('Saint-Martin');
UPDATE ne_countries SET name = 'Saint Martin' where name = 'Saint-Martin';

SELECT SingleCountry('Timor-Leste');
UPDATE ne_countries SET name = 'East Timor' where name = 'Timor-Leste';

SELECT SingleCountry('Saint-Barthélemy');
UPDATE ne_countries SET name = 'Saint Barthelemy' where name = 'Saint-Barthélemy';

SELECT SingleCountry('São Tomé and Principe');
UPDATE ne_countries SET name = 'Sao Tome and Principe' where name = 'São Tomé and Principe';

SELECT SingleCountry('Guinea-Bissau');
UPDATE ne_countries SET name = 'Guinea Bissau' where name = 'Guinea-Bissau';

SELECT SingleCountry('Bahamas');
UPDATE ne_countries SET name = 'The Bahamas' where name = 'Bahamas';

SELECT SingleCountry('Hong Kong');
UPDATE ne_countries SET name = 'Hong Kong S.A.R.' where name = 'Hong Kong';

SELECT SingleCountry('Macao');
UPDATE ne_countries SET name = 'Macao S.A.R.' where name = 'Macao';

SELECT SingleCountry('Republic of Korea');
UPDATE ne_countries SET name = 'South Korea' where name = 'Republic of Korea';

SELECT SingleCountry('Dem. Rep. Korea');
UPDATE ne_countries SET name = 'North Korea' where name = 'Dem. Rep. Korea';

SELECT SingleCountry('Federated States of Micronesia');
UPDATE ne_countries SET name = 'Micronesia, Federated States of' where name = 'Federated States of Micronesia';

-- SELECT SingleCountry('United Republic of Tanzania');
-- UPDATE ne_countries SET name = 'Tanzania' where name = 'United Republic of Tanzania';

SELECT SingleCountry('Åland Islands');
UPDATE ne_countries SET name = 'Aland' where name = 'Åland Islands';

SELECT SingleProvince('Heilongjiang');
UPDATE ne_provinces SET name_local = '黑龙江省' WHERE name = 'Heilongjiang';

SELECT SingleProvince('Qinghai');
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
