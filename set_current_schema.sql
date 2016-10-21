define l_current_schema = &1

alter session set current_schema = &&l_current_schema;

column current_schema new_value g_current_schema
set termout off
select sys_context('userenv','current_schema') as current_schema from dual;
set termout on

prompt Current schema changed to &&g_current_schema

undefine l_current_schema