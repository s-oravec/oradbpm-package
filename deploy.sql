rem !!! this works only under SQLcl as it can change directory when connected
rem
rem This script is what OraDBPM CLI would do
rem
rem It will
rem - interactively resolve any issues: e.g. version requirement conflicts
rem - and download all required packages
rem
rem It will have to take in account
rem - packages already deployed in target database - connect string as OraDBPM CLI parameter/configuration
rem - target schema for deployment - target user as OraDBPM CLI parameter/configuration
rem - target deployment privileges mode (public/peer) - public/peer as OraDBPM CLI parameter
rem
rem Then it would generate statements that can be seen in
rem - deploy.sql
rem
rem now         : you have to create/modify all these files manually
rem near future : OraDBPM CLI will generate these files with download from github/other sources
rem far future  : OraDBPM CLI will download packages stored in repository somewhere in the cloud (other people computers)
rem
rem download dependencies
rem invoicer depends on blog installed as public
host rm -rf oradbpm_modules/public/blog
host git clone --branch blog https://github.com/s-oravec/oradbpm-package oradbpm_modules/public/blog
host rm -rf oradbpm_modules/public/blog/.git
rem
rem invoicer dependes on slogger installed as peer
host rm -rf oradbpm_modules/peer/slogger
host git clone --branch slogger https://github.com/s-oravec/oradbpm-package oradbpm_modules/peer/slogger
host rm -rf oradbpm_modules/peer/slogger/.git
rem
rem slogger depends on cstck installed as peer
host rm -rf oradbpm_modules/peer/cstck
host git clone --branch cstck https://github.com/s-oravec/oradbpm-package oradbpm_modules/peer/cstck
host rm -rf oradbpm_modules/peer/cstck/.git
rem

rem 1. Create schemas
rem 1.1. Create this package schema
@create configured

rem 1.2. Create schems for public dependencies
cd oradbpm_modules/public/blog
@create configured
cd

rem 2. Install
rem 2.1. Install public dependencies
cd oradbpm_modules/public/blog
@package
@set_current_schema &&g_schema_name
@install public
cd

rem 2.2. Install peer dependencies
@package
@set_current_schema &&g_schema_name
cd

rem SQLcl threading issue - has to call noop
host :
cd oradbpm_modules/peer/cstck
@install peer
cd

rem SQLcl threading issue - has to call noop
host :
cd oradbpm_modules/peer/slogger
@install peer
cd

rem 2.3. Install this package as public or peer
host :
@install public

exit 0
