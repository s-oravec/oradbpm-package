define l_schema = "&&g_schema_name_base"

rem Drop Production schema
prompt .. Dropping [&&l_schema] user
drop user &&l_schema cascade;

undefine l_schema