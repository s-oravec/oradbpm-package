rem
rem Drops package schema/schemas
rem
rem Usage
rem     sql @drop.sql <environment>
rem
rem Options
rem
rem     environment - development - drops <g_schema_name_base>_DEV  schema for development and testing package
rem                 - production  - drops <g_schema_name_base>
rem
set verify off
define g_environment = "&1"

prompt Load package
@@package.sql

prompt Create schemas
@@module/dba/create_&&g_environment..sql

exit
