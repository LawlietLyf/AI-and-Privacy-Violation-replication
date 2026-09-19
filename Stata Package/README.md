# Stata dependencies

This directory documents the dependency structure. The three subfolders contain README placeholders only; third-party source code is not bundled. README files keep the folders visible in GitHub, which does not track empty directories.

Install all required packages using the commands in [Installation in the package README](../../README.md#2-installation). This includes SSC packages as well as these versioned official sources:

| Folder | Dependency version | Official source |
|---|---|---|
| `ftools-master/` | ftools 2.49.1 | [ftools](https://github.com/sergiocorreia/ftools/tree/2.49.1) |
| `reghdfe-master/` | reghdfe 6.12.5 | [reghdfe](https://github.com/sergiocorreia/reghdfe/tree/6.12.5) |
| `ivreghdfe-master/` | ivreghdfe 1.1.3 | [ivreghdfe](https://github.com/sergiocorreia/ivreghdfe/tree/1.1.3) |

The folder names retain the original package layout; the installation URLs pin specific versions. Nothing needs to be copied into these folders. Stata installs dependencies in its ado directory. Source code and licences are available from the linked repositories.
