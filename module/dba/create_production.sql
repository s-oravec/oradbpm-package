whenever sqlerror exit 1 rollback

define l_schema_def       = "&&g_schema_name_base"
define l_schema_tbspc_def = "USERS"
define l_temp_tbspc_def   = "TEMP"

accept l_schema       prompt "Package [&&g_package_name] schema [&&l_schema_def] : " default "&&l_schema_def"
accept l_schema_pwd   prompt "Package [&&g_package_name] schema password : " hide
accept l_schema_tbspc prompt "Package [&&g_package_name] schema tablespace [&&l_schema_tbspc_def] : " default "&&l_schema_tbspc_def"
accept l_temp_tbspc   prompt "Package [&&g_package_name] temp tablespace [&&l_temp_tbspc_def] : " default "&&l_temp_tbspc_def"

declare
  lc_error_message constant varchar2(255) := 'ERROR: Zero-length password not permitted.';
begin
  if '&&l_schema_pwd' is null then
    dbms_output.put_line(lc_error_message);
    raise_application_error(-20000, lc_error_message);
  end if;
end;
/

prompt .. Creating package [&&g_package_name] schema [&&l_schema] with default tablespace [&&l_schema_tbspc] and temp tablespace [&&l_temp_tbspc]
create user &&l_schema
  identified by "&&l_schema_pwd"
  default tablespace &&l_schema_tbspc
  temporary tablespace &&l_temp_tbspc
  quota unlimited on &&l_schema_tbspc
  account unlock
/

prompt .. Granting privileges to package [&&g_package_name] production schema [&&l_schema]

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

undefine l_schema_def
undefine l_schema_tbspc_def
undefine l_temp_tbspc_def
undefine l_schema
undefine l_schema_pwd
undefine l_schema_tbspc
undefine l_temp_tbspc