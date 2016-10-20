whenever sqlerror exit 1 rollback

define l_schema       = "&&g_schema_name_base._DEV"
define l_schema_tbspc = "USERS"
define l_temp_tbspc   = "TEMP"

prompt .. Creating package [&&g_package_name] schema [&&l_schema]
prompt .  - password [&&l_schema]
prompt .  - with default tablespace [&&l_schema_tbspc]
prompt .  - temp tablespace [&&l_temp_tbspc]
create user &&l_schema
  identified by "&&l_schema"
  default tablespace &&l_schema_tbspc
  temporary tablespace &&l_temp_tbspc
  quota unlimited on &&l_schema_tbspc
  account unlock
/

prompt .. Granting privileges to package [&&g_package_name] production schema [&&l_schema]

prompt .. Granting CREATE SESSION to &&l_schema
grant create session to &&l_schema;

prompt .. Granting DEBUG CONNECT SESSION
grant debug connect session to &&l_schema;

prompt .. Granting CREATE TABLE to &&l_schema
grant create table to &&l_schema;

prompt .. Granting CREATE PROCEDURE to &&l_schema
grant create procedure to &&l_schema;

prompt .. Granting CREATE TYPE to &&l_schema
grant create type to &&l_schema;

prompt .. Granting CREATE SEQUENCE to &&l_schema
grant create sequence to &&l_schema;

prompt .. Granting CREATE SYNONYM to &&l_schema
grant create synonym to &&l_schema;

prompt .. Granting CREATE VIEW to &&l_schema
grant create view to &&l_schema;

undefine l_schema
undefine l_schema_tbspc
undefine l_temp_tbspc
