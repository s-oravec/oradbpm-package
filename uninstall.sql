rem
rem uninstall package
rem
rem Usage
rem     sql @uninstall.sql <privileges>
rem
rem Options
rem
rem     privileges - public - uninstalls package and grants API to public
rem                - peer   - uninstalls package and grants API to peers - using whitelist grants
rem
set verify off
define g_privileges = "&1"

prompt Load package
@@package.sql

prompt Uninstall package [&&g_package_name]

prompt Uninstalling package Implementation
@module/implementation/uninstall.sql

prompt Uninstalling package API
@module/api/uninstall.sql
