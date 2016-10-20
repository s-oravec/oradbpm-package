rem
rem uninstall package
rem
rem Usage
rem     sql @uninstall.sql
rem
rem Load package
@@package.sql

prompt Uninstall package Implementation
@module/implementation/uninstall.sql

prompt Uninstall package API
@module/api/uninstall.sql

rem undefine package globals
@module/undefine_globals.sql
