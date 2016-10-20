rem
rem Creates synonyms for your public API (packages, views, ...) in user which is using your package
rem
rem Usage
rem     sql @set_dependency_ref_owner.sql <schema name>
rem
rem Options
rem
rem     schema name - whre your package is installed with public API
rem
set verify off
define l_schema_name = "&1"

rem Load package
@@package.sql

prompt Creating synonyms in &&_USER schema for API objects &&g_package_name package installed in &&l_schema_name schema
@module/api/set_dependency_ref_owner.sql

rem undefine locals
undefine l_schema_name

rem undefine package globals
@@undefine_globals.sql
