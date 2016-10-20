rem
rem install package
rem
rem Usage
rem     sql @install.sql <privileges>
rem
rem Options
rem
rem     privileges - public - installs package and grants API to public
rem                - peer   - installs package and grants API to peers - use whitelist grants
rem
set verify off
define g_privileges = "&1"

prompt Load package
@@package.sql

prompt Install package [&&g_package_name]

prompt Installing package Implementation
@module/implementation/install.sql

prompt Installing package API
@module/api/install.sql

prompt Granting privileges on package API
@module/api/grant_&&g_privileges..sql

