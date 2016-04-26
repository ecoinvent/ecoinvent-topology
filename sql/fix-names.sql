SET CLIENT_ENCODING TO UTF8;
SET STANDARD_CONFORMING_STRINGS TO ON;
SET client_min_messages TO WARNING;

BEGIN;
update final set name = 'Congo, Democratic Republic of the' where name = 'Democratic Republic of the Congo';
update final set name = 'Congo' where name = 'Republic of Congo';
update final set name = 'Micronesia, Federated States of' where name = 'Federated States of Micronesia';
update final set name = 'Serbia' where name = 'Republic of Serbia';
update final set name = 'Tanzania' where name = 'United Republic of Tanzania';
update final set shortname = 'AUS-AC', name = 'Australia, Ashmore and Cartier Islands' where name = 'Ashmore and Cartier Islands';
update final set shortname = 'AUS-IOT', name = 'Australia, Indian Ocean Territories' where name = 'Indian Ocean Territories';
COMMIT;
