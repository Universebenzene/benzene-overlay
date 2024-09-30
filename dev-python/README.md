# Information for astropy related packages
Table here will show information for some of the astropy related packages.

Note: Build with `-O3` flag is not recommended. As this will cause some bug with python or numpy, and make some modules of astropy unusable.

Package name | Available version | Additional information
------------ | :---------------: | ----------------------
dev-python/astropy             | 5.0.8; 5.3.4; 6.0.1; 6.1.4                           | Versions below 5.0.2 are included but masked. See [here](https://github.com/Universebenzene/benzene-overlay/tree/master/dev-python/astropy#note-for-astropy) for more details. wcslib>=8.1 is included in this overlay for astropy>=6.0.0
dev-python/astroalign          | 2.5.1                                                |
dev-python/astropy-iers-data   | 0.2024.9.30.0.32.59                                  | Required by astropy>=6.0.0
dev-python/astropy-helpers     | 2.0.11; 3.0.2; 3.1.1; 4.0.1-r1                       | With patches for better doc building. Same as the [AUR](https://aur.archlinux.org/packages/python-astropy-helpers) ones
dev-python/pytest-astropy      | 0.8.0; 0.11.0                                        | Test plugins for astropy. Dependencies are also in this overlay but not listed in this table
dev-python/sphinx-astropy      | 1.6.0; 1.9.1                                         | Modules for building docs of astropy related packages. Dependencies are also in this overlay but not listed in this table
dev-python/sphinx-asdf         | 0.1.3; 0.1.4; 0.2.4                                  |
dev-python/aplpy               | 2.1.0                                                | Versions below 2.1.0 are included but masked. See [here](https://github.com/Universebenzene/benzene-overlay/tree/master/dev-python/aplpy#note-for-aplpy) for more details. `network-sandbox` FEATURE will be disabled if you enable intersphinx linking for doc building
dev-python/asdf                | 2.7.2; 2.9.2; 2.10.1; 2.13.0; 2.15.0; 2.15.2; 3.4.0  | `network-sandbox` FEATURE will be disabled if you enable intersphinx linking for doc building. Doc building should only be enabled for re-merge to prevent circular depenencies.
dev-python/asdf-astropy        | 0.2.1; 0.6.1                                         | Dependencies are also in this overlay but not listed in this table. `network-sandbox` FEATURE will be disabled if you enable intersphinx linking for doc building
dev-python/astlib              | 0.11.3-r1; 0.11.10-r1; 0.12.0                        | astLib WCS library for ginga
dev-python/astrodendro         | 0.2.0-r2; (live)                                     | 0.2.0 was really old. Live version should be much better.
dev-python/astroml             | 0.4.1; 1.0.2\_p1                                     |
dev-python/astropy-healpix     | 0.5; 1.0.3                                           | `network-sandbox` FEATURE will be disabled if you enable intersphinx linking for doc building
dev-python/astroplan           | 0.6; 0.10.1                                          | `network-sandbox` FEATURE will be disabled if you enable intersphinx linking for doc building. Doc building may not complete, as it needs lots of online data.
dev-python/astroquery          | 0.3.10; 0.4.7                                        | `network-sandbox` FEATURE will be disabled if you enable intersphinx linking for doc building
dev-python/astroscrappy        | 1.0.8; 1.2.0                                         | `network-sandbox` FEATURE will be disabled if you enable intersphinx linking for doc building
dev-python/atpy                | 0.9.7                                                | Old package, so the test phase may fail
dev-python/ccdproc             | 1.3.0\_p1; 2.1.0; 2.4.2                              | `network-sandbox` FEATURE will be disabled if you enable intersphinx linking for doc building
dev-python/casa-formats-io     | 0.3.0                                                |
dev-python/cdflib              | 0.4.9; 1.3.1                                         | SunPy releated.
dev-python/drms                | 0.6.4; 0.8.0                                         | SunPy releated. `network-sandbox` FEATURE will be disabled if you enable `examples` flag for doc building
dev-python/dust-extinction     | 1.5                                                  |
dev-python/echo                | 0.9.0                                                | Glueviz releated.
dev-python/extension-helpers   | 1.1.1                                                |
dev-python/fast-histogram      | 0.14                                                 | Glueviz releated.
dev-python/ginga               | 5.1.0                                                | `network-sandbox` FEATURE will be disabled if you enable intersphinx linking for doc building.
dev-python/glueviz             | 1.2.0-r1 (glue-core: 1.17.1, 1.21.1; glue-qt: 0.3.1) | Meta package, core package and qt package versions are all shown.
dev-python/glue-vispy-viewers  | 1.1.0; 1.2.2                                         |
dev-python/gwcs                | 0.17.1; 0.21.0                                       | `network-sandbox` FEATURE will be disabled if you enable intersphinx linking for doc building.
dev-python/h5netcdf            | 1.3.0                                                |
dev-python/h5pyd               | 0.12.2; 0.17.0; 0.18.0                               |
dev-python/healpy              | 1.16.6; 1.17.3                                       |
dev-python/hvpy                | 1.1.0                                                | Test dependency and optional for sunpy.
dev-python/imexam              | 0.9.1                                                | With [my issue](https://github.com/spacetelescope/imexam/issues/252) unsolved. [NOT COMPATIBLE WITH PY3.11 YET](https://github.com/spacetelescope/imexam/issues/256)
dev-python/jplephem            | 2.22                                                 |
dev-python/jsonschema          | 3.2.0-r1; 4.9.1                                      | Old version for dev-python/asdf
dev-python/montage-wrapper     | 0.9.9                                                |
dev-python/mpl-animator        | 1.2.0                                                | `network-sandbox` FEATURE will be disabled for doc building, as it needs downloading sunpy related data.
dev-python/mpl-scatter-density | 0.7                                                  | Glueviz releated.
dev-python/naima               | 0.10.0                                               |
dev-python/ndcube              | 2.2.0; 2.2.2                                         | SunPy releated. Dependency of specutils.
dev-python/photutils           | 1.9.0; 1.12.0; 1.13.0                                | `network-sandbox` FEATURE will be disabled if you enable intersphinx linking for doc building.
dev-python/pvextractor         | 0.4                                                  | `network-sandbox` FEATURE will be disabled if you enable intersphinx linking for doc building.
dev-python/pyavm               | 0.9.6                                                |
dev-python/pyerfa              | 1.7.2; 2.0.1.4                                       | Fixed test phase. One of the deps of `astropy`. `network-sandbox` FEATURE will be disabled if you enable intersphinx linking for doc building.
dev-python/pydl                | 0.7.0; 1.0.1                                         | `network-sandbox` FEATURE will be disabled if you enable intersphinx linking for doc building.
dev-python/pymoc               | 0.5.2                                                |
dev-python/pyregion            | 2.1.1; 2.2.0                                         | `network-sandbox` FEATURE will be disabled if you enable intersphinx linking for doc building
dev-python/pyvo                | 1.2.1; 1.5.2                                         | `network-sandbox` FEATURE will be disabled if you enable intersphinx linking for doc building
dev-python/radio-beam          | 0.3.7                                                | `network-sandbox` FEATURE will be disabled if you enable intersphinx linking for doc building
dev-python/regions             | 0.4; 0.10                                            | `network-sandbox` FEATURE will be disabled if you enable intersphinx linking for doc building
dev-python/reproject           | 0.5.1; 0.12.0; 0.14.0                                | `network-sandbox` FEATURE will be disabled if you enable intersphinx linking for doc building
dev-python/sep                 | 1.2.1                                                |
dev-python/sgp4                | 2.22                                                 |
dev-python/sherpa              | 4.15.0; 4.15.1-r1; 4.16.1                            | `XSPEC` support is not included while building. See [here](https://sherpa.readthedocs.io/en/4.15.0/install.html#building-from-source) for more details to build with `XSPEC` manually.
dev-python/skyfield            | 1.45; 1.46; 1.49                                     |
dev-python/spectral-cube       | 0.6.5                                                | `network-sandbox` FEATURE will be disabled if you enable intersphinx linking for doc building
dev-python/specutils           | 1.1.1; 1.16.0                                        | `network-sandbox` FEATURE will be disabled if you enable intersphinx linking for doc building
dev-python/specreduce          | 1.4.1                                                | `network-sandbox` FEATURE will be disabled if you enable intersphinx linking for doc building. Some images cannot be plotted if intersphinx is disabled.
dev-python/starlink-pyast      | 0.2.1                                                | Starlink WCS library for ginga
dev-python/sunpy               | 5.1.5; 6.0.2                                         | Doc building is really hard to run, so not supported right now.
dev-python/synphot             | 1.4.0                                                |
dev-python/sunpy-sphinx-theme  | 1.2.42; 2.0.2; 2.0.16                                |
