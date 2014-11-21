SET CLIENT_ENCODING TO UTF8;
SET STANDARD_CONFORMING_STRINGS TO ON;
SET client_min_messages TO WARNING;

BEGIN;
update final set name = 'Congo, Democratic Republic of the' where name = 'Democratic Republic of the Congo';
update final set name = 'Congo' where name = 'Republic of Congo';
update final set name = 'Micronesia, Federated States of' where name = 'Federated States of Micronesia';
update final set name = 'Serbia' where name = 'Republic of Serbia';
update final set name = 'Tanzania' where name = 'United Republic of Tanzania';
COMMIT;
