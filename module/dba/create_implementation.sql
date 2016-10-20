prompt .. Creating package &&g_package_name schema &&l_schema_name with default tablespace &&l_schema_tbspc and temp tablespace &&l_temp_tbspc
create user &&l_schema_name
  identified by "&&l_schema_pwd"
  default tablespace &&l_schema_tbspc
  temporary tablespace &&l_temp_tbspc
  quota unlimited on &&l_schema_tbspc
  account unlock
/

prompt .. Granting privileges to package &&g_package_name production schema &&l_schema_name

prompt .. Granting CREATE TABLE to &&l_schema_name
grant create table to &&l_schema_name;

prompt .. Granting CREATE PROCEDURE to &&l_schema_name
grant create procedure to &&l_schema_name;

prompt .. Granting CREATE TYPE to &&l_schema_name
grant create type to &&l_schema_name;

prompt .. Granting CREATE SEQUENCE to &&l_schema_name
grant create sequence to &&l_schema_name;

prompt .. Granting CREATE SYNONYM to &&l_schema_name
grant create synonym to &&l_schema_name;

prompt .. Granting CREATE VIEW to &&l_schema_name
grant create view to &&l_schema_name;

