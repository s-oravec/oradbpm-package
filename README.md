# OraDBPM Package Template and Guide

This repo represents cstck of released version of OraDBPM Package. This is, how it should look after you build it from you source.

> The way you keep your source and build the release is not issue discussed in this document or the cstck implementation.

## Main ideas

* Pure **SQL\*Plus** (no **SQLcl** goodies, until it is widely adopted)
* No dynamic scripts (scripts created by scripts) 
    * only dynamic calls based on configuration like
    * no create then exec scripts    
* No substitution variable hell
* No super dynamic unreadable code full of substitutions

```
@module/dba/create_&&l_configuration..sql
```

# Package definition - oradbpm_package.json

File describes your package. See [OraDBPM Package Schema](https://github.com/s-oravec/oradbpm-package-schema) github repo for detials.

## Name

Choose well as you may stick with it for a long time. It should be

* short - you need to install it in Oracle DB - so 30 chars is max length (think also about appending version string to package name to create schema with version identification: e.g. APEX_050000)
* has to be Oracle SQL Name

Set global substitution variable in `package.sql`

```
define g_package_name = "<packageName>"
```

And also expose package name using constant in package `<packageName>`

```
-- Package name
PACKAGE_NAME constant varchar2(30) := '&&g_package_name';
```

## Version

**Use semantic versioning**

Reference is [semver](http://semver.org)

> Given a version number MAJOR.MINOR.PATCH, increment the:
>
>- **MAJOR** version when you make incompatible API changes,
>- **MINOR** version when you add functionality in a backwards-compatible manner, and
>- **PATCH** version when you make backwards-compatible bug fixes.
>
>Additional labels for pre-release and build metadata are available as extensions to the `MAJOR.MINOR.PATCH` format.

Set global substitution variable in `package.sql` file

```sql
rem SQL name compatible version string
define g_sql_version = "000100"

rem full semver version string
define g_semver_version = "0.1.0"
```

**Your API package should expose it's version as constant and function in <packageName> package**

Create package `module/api/package/<packageName>`.

Expose your module version as

```
-- Package SQL Name compatible version
SQL_VERSION    constant varchar2(30) := '&&g_sql_version';

function get_sql_version return varchar2;

-- Semver version
SEMVER_VERSION constant varchar2(30) := '&&g_semver_version';

function get_semver_version return varchar2;
```

## Description

Describe in couple words the purpose of your package.

## Author

Provide your name and your contact email in form `name <email>`. e.g.

```
Štefan Oravec <stefan.oravec@me.com>
```

## License

Don't forget to specify license for the package.

# Command scripts

Command scripts are **SQL*Plus** scripts, implementing common package use cases.
Place these scripts in a package root directory.

**privileged user commands**

- create - create schemas of public package
- drop - drop schemas of public package
- grant - grant required privileges to `packageSchema` when installing into existing schema

**package schema commnads**

- install - create package objects
- uninstall - drop package objects 

**schema using your package commands**

- set dependency reference owner - create synonyms for your package's API in other schema, which objects depend on your package's public API
- unset dependency reference owner - drop those API synonyms

## create

Creates database users and grants required privileges. It's intended to be run by privileged user.

Create separate grant file `module/dba/grant_schema.sql` with all required package schema grants, for granting required privileges to existing schema (e.g. when your package is installed as peer in others package schema) and easier review of required grants.

Script should have exactly one parameter `g_configuration` and accept values

- `configured` - uses configuration stored in `package.sql`
- `manual` - interactive - asks for everything

Sample call

```
rem schema name, tablespaces, ... are configured in package.sql
$ sqlplus / as sysdba @create configured

rem schema name, tablespaces, ... are entered in interactive mode
$ sqlplus / as sysdba @create manual
```

## drop

Script should have exactly one parameter `g_environment`.
See description of the **create** command for details.

- script is intended to be run by privileged user
		- specify minimal required privileges for privileged user (e.g.  `drop any table`), at least in comments in **drop** script, ideally as a separate grant script
- drop database users

Sample call

```
$ sqlplus / as sysdba @drop configured
$ sqlplus / as sysdba @drop manual
```

## grant 

Grants required privileges to `packageSchema`. Intended to be run under privileged user.

Sample call

```
$ sqlplus / as sysdba @grant <packageSchema>
```

## install

Script should have exactly one parameter `g_privileges` and accept values

- `peer` - when you want install package as a peer dependency in your package
- `public` - when you want install package into separate schema and grant it's API to `PUBLIC`

<!--

Idea. : what about private package usage? 
Detail: when you don't want to share package with other modules or package requires only one "user" of package/desn't support use by other modules

--> 

- script is intended to be run in target schema, where your package will be installed
- in case of `PUBLIC` package, it is recomended to create `packageSchema` user using **create** script

Sample call

```
$ sqlplus <userName>/<password>@<connectString> @install <privileges>
```

## uninstall

Uninstalls package.

Script is intended to be run in `packageSchema` schema, where is your package installed.

```
$ sqlplus <packageSchema>@<connectString> @uninstall
```

## set\_dependency\_ref\_owner

Creates synonyms in `<userUsingYourPackage>` schema for your public API in `<publicPackageSchema>` schema.

```
$ sqlplus <userUsingYourPackage>@<connectString> @set_dependency_ref_owner <publicPackageSchema>
```

## unset\_dependency\_ref\_owner

Drops synonyms in `<userUsingYourPackage>` schema for your public API in `<publicPackageSchema>` schema

```
$ sqlplus <userUsingYourPackage>@<connectString> @unset_dependency_ref_owner <publicPackageSchema>
```

# SQL*Plus Best Practice

**Substitution variables**

* always undefine what you have defined
* use some naming for scope
    * `g_` or `<packageName>_` for global scope - try not to overuse globals
    * `m_<packageName>_` for module scope
    * `l_` for local scope = script. Make sure that you have undefined them at the end of the script
