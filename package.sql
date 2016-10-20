rem Package name
define g_package_name="TEMPLATE"

rem SQL name compatible version string
define g_sql_version = "000100"

rem default schema name base
define g_schema_name_base = &&g_package_name._&&g_sql_version

rem full semver version string
define g_semver_version = "0.1.0"