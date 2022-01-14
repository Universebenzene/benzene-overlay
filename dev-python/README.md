# Informations for astropy related packages
Table here will show informations for some of the astropy related packages.

Package name | Available version | Additional information
------------ | :---------------: | ----------------------
dev-python/astropy            | 2.0.16; 3.0.5; 3.1.2; 4.2.1 | Build with system libs. Tests phase fails to complete. See [here](https://github.com/Universebenzene/benzene-overlay/tree/master/dev-python/astropy#note-for-astropy) for more details
dev-python/astropy-helpers    | 2.0.11; 3.0.2; 3.1.1; 4.0.1 | With patches for better doc building. Same as the [AUR](https://aur.archlinux.org/packages/python-astropy-helpers/) ones
dev-python/pytest-astropy     | 0.8.0; 0.9.0                | Test plugins for astropy. Dependencies are also in this overlay but not list in this table
dev-python/sphinx-astropy     | 1.6.0; 1.7.0                | Modules for building docs of astropy related packages. Dependencies are also in this overlay but not list in this table
dev-python/sphinx-asdf        | 0.1.2                       |
dev-python/aplpy              | 1.1.1; 2.0.3                | Other overlays might needed for newest version. See [here](https://github.com/Universebenzene/benzene-overlay/tree/master/dev-python/aplpy#note-for-aplpy) for details
dev-python/asdf               | 2.7.2; 2.8.3                | `network-sandbox` FEATURE will be disabled if you enable intersphinx linking for doc building
dev-python/astrodendro        | 0.2.0                       | Old package, so the test and doc building may fail
dev-python/astroml            | 0.4.1                       |
dev-python/astropy-healpix    | 0.5; 0.6                    | Compiling can pass but with some problem. See [here](https://github.com/Universebenzene/benzene-overlay/tree/master/dev-python/astropy-healpix#note-for-astropy-healpix) for details
dev-python/astroplan          | 0.6                         |
dev-python/astroquery         | 0.3.10; 0.4                 |
dev-python/astroscrappy       | 1.0.8; 1.1.0                | `network-sandbox` FEATURE will be disabled if you enable intersphinx linking for doc building
dev-python/atpy               | 0.9.7                       | Old package, so the test phase may fail
dev-python/ccdproc            | 1.3.0\_p1; 2.1.0            |
dev-python/extension-helpers  | 0.1                         |
dev-python/gwcs               | 0.16.1; 0.17.1              | `network-sandbox` FEATURE will be disabled if you enable intersphinx linking for doc building
dev-python/healpy             | 1.11.0                      | See [here](https://github.com/Universebenzene/benzene-overlay/tree/master/dev-python/healpy#note-for-healpy) for details
dev-python/montage-wrapper    | 0.9.9                       |
dev-python/mpl-animator       | 1.0.0                       |
dev-python/photutils          | 1.0.2; 1.2.0                | Disable `network-sandbox` FEATURE to use intersphinx linking in doc building. While the doc building needs lots of online data, you may not get the figures in the doc built
dev-python/pyavm              | 0.9.5                       |
dev-python/pyerfa             | 1.7.2; 2.0.0.1              | Fixed test phase. One of the deps of `astropy`.
dev-python/pyregion           | 2.0                         |
dev-python/pyvo               | 1.2.1                       | `network-sandbox` FEATURE will be disabled if you enable intersphinx linking for doc building
dev-python/regions            | 0.4; 0.5                    | `network-sandbox` FEATURE will be disabled if you enable intersphinx linking for doc building
dev-python/reproject          | 0.5.1; 0.7.1                | Disable `network-sandbox` FEATURE to use intersphinx linking in doc building. Some modules cannot work due to the compiling problem of `astropy-healpix`. See [here](https://github.com/Universebenzene/benzene-overlay/tree/master/dev-python/reproject#note-for-reproject) for details
dev-python/sgp4               | 2.20                        |
dev-python/specutils          | 1.1.1                       | Disable `network-sandbox` FEATURE to use intersphinx linking in doc building. Doc building needs SDSS online data, but SDSS servers are down, so you may not get the figures in the doc built
dev-python/sunpy-sphinx-theme | 1.2.28                      |
