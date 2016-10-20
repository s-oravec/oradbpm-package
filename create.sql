rem
rem Creates package schema/schemas
rem
rem Usage
rem     sql @create.sql <environment>
rem
rem Options
rem
rem     environment - development - creates <g_schema_name_base>_DEV  schema for development and testing package
rem                 - production  - creates <g_schema_name_base>
rem
set verify off
define g_environment = "&1"

prompt Load package
@@package.sql

prompt Create schemas
@@module/dba/create_&&g_environment..sql

exit
