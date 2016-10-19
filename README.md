# OraDBPM Package

# Version

## Use semantic versioning

Reference is [semver](http://semver.org)

> Given a version number MAJOR.MINOR.PATCH, increment the:
>
>- **MAJOR** version when you make incompatible API changes,
>- **MINOR** version when you add functionality in a backwards-compatible manner, and
>- **PATCH** version when you make backwards-compatible bug fixes.
>
>Additional labels for pre-release and build metadata are available as extensions to the `MAJOR.MINOR.PATCH` format.

## Your package should expose it's version as constant and function

> See package `module/package/oradbpm_template.pkg` as reference implementation

Create package `module/package/oradbpm_<packageName>` grant execute on it to public.

Expose your module version as

* `VERSION` constant
* `packge_version` method - returning that constant
 

