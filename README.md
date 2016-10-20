

# OraDBPM Package Template and Guide

This repo represents template of released version of OraDBPM Package. This is, how it should look after you build it from you source.

> The way you keep your source and build the release is not issue discussed in this document.

## Main ideas

* Pure **SQL\*Plus**
* No dynamic scripts - only dynamic calls based on configuration like 

```
@module/dba/install_&&g_environment..sql
```

# Package definition - oradbpm_package.json

File describes your package. See [OraDBPM Package Schema](https://github.com/s-oravec/oradbpm-package-schema) github repo for detials.

# Name

Choose well as you may stick with it for a long time. It should be

* short - you need to install it in Oracle DB - so 30 chars is max length (think also about appending version string to package name to create schema with version identification: e.g. APEX_050000)
* has to be Oracle SQL Name

# Version

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

**Your package should expose it's version as constant and function**

Create package `module/schema/package/opm_<packageName>` grant execute on it to public.

Expose your module version as

* `VERSION` constant
* `packge_version` method - returning that constant

# Command scripts

Command scripts are **SQL*Plus** scripts, implementing common package use cases.
Place these scripts in a package root directory.

- create - create schemas
- drop - drop schemas
- install - create package objects
- uninstall - drop package objects 
- install test - install test objects
- uninstall test - uninstall test objects
- test - run test
- create synonyms - create synonyms for your package's API in other schema
- drop synonyms - drop thode API synonyms

## SQL*Plus Best Practice

**Substitution variables**

* always undefine what you have defined
* use some naming for scope
    * `g_` or `<packageName>_` for global scope 
    * `m_` for module scope
    * `l_` for local scope = script. Make sure that you have undefined them at the end of the script

### create

Creates database users and grants required privileges. It's intended to be run by privileged user. Create separate grant files `module/grant_&g_environment..sql` with all required grants, for easier review of required grants.

> Specify minimal required privileges for privileged user (e.g.  `create any table`), at least in comments of the **create** script, ideally as a separate grant script

<!-- TODO: create both deployer_privs_grant, deployer_privs_revoke scripts? -->

Script should have exactly one parameter `g_environment` and accept values

- `production` for creation of user/users for production deployment
- `development` for creation of user/users for development and testing

```sql
define g_envirnment = &1
```

> it is good practice to create separate user for development and testing as your package may be used by other packages already deployed in your database

Sample call

```
$ sqlplus sys/oracle@local as sysdba @create development
```

### drop

Script should have exactly one parameter `g_environment`.
See description of the **create** command for details.

- script is intended to be run by privileged user
		- specify minimal required privileges for privileged user (e.g.  `drop any table`), at least in comments in **drop** script, ideally as a separate grant script
- drop database users

Sample call

```
$ sqlplus sys/oracle@local as sysdba @drop development
```

### install

Script should have exactly one parameter `g_privileges` and accept values

- `peer` - when you want install package as a peer dependency in your package
- `public` - when you want install package into separate schema and grant it's API to `PUBLIC`

<!--

Idea. : what about private package usage? 
Detail: when you don't want to share package with other modules or package requires only one "user" of package/desn't support use by other modules

--> 

- script is intended to be run in target schema, where your package will be installed
- in case of `PUBLIC` package, it is recomended to create target user using **create** script

```sql
define g_privileges = &1
```

Sample call

```
$ sqlplus <userName>/<password>@<connectString> @install <privileges>
```

### uninstall

- script is intended to be run in target schema, where is your package installed

```
$ sqlplus <userName>/<password>@<connectString> @uninstall
```

### install_test

- script is 

```
$ sqlplus <testUserName>/<password>@<connectString> @install_test
```

### uninstall_test

```
$ sqlplus <userName>/<password>@<connectString> @uninstall_test
```

### test

```
$ sqlplus <userName>/<password>@<connectString> @test
```

### create_synonyms

creates synonyms for your public API (packages, views, ...) in user which is using your package

```
$ sqlplus <userUsingYourPackage>/<password>@<connectString> @create_synonyms <publicPackageSchema>
```

### drop_synonyms

drop synonyms

```
$ sqlplus <userName>/<password>@<connectString> @drop_synonyms <publicPackageSchema>
```
