# Note for astropy
<!-- I haven't updated the astropy package in this overlay to the newest version yet, as some dependencies in the official portage are not up-to-date. For now (2019-12-29), the newest version of following dependencies in the portage are:

cfitsio: 3.410; erfa: 1.4.0; wcslib: 5.16

While the bundled versions in astropy sources are listed in the table below, which might be the most suitable ones for each version of astropy.

Versions of astropy | cfitsio | erfa | wcslib | More information --
:------: | :----: | :----: | :----: | -----
4.0      | 3.470  | 1.7.0  | 6.4    | bundled wcslib > 6, so not included in this overlay yet
3.2.3    | 3.450  | 1.4.0  | 6.2    | similar with 4.0
3.1.2    | 3.450  | 1.4.0  | 5.19.1 | cfitsio and wcslib newer than portage
3.0.5    | 3.440  | 1.4.0  | 5.19   | similar with 3.1.2
2.0.16   | 3.440  | 1.4.0  | 5.16   | cfitsio newer than portage
2.0.14   | 3.440  | 1.4.0  | 5.16   | same as 2.0.16

Some of the dependencies in the portage are always older than the bundled ones, so I'm not sure if the builds in this overlay always work well. I just provide the versions that don't need quite new versions of the dependencies.(3.1.2 is the newest one here for now)

If you still want the newest version, try the ones in [this overlay](https://github.com/Universebenzene/benzene-testlay/), which are even less tested.a -->

<!--Update to newest version as the `cfitsio` and `wcslib` in official portage are up-to-date now, while `erfa` is still using the one in [sciense](https://wiki.gentoo.org/wiki/Project:Science) overlay.-->

<!--Versions above `5.0.2` are not included in the overlay, as newest version of cfitsio in the main tree is still `4.0.0` (2022-04), while astropy>=5.0.3 officially bundle the `4.0.1`.-->

<!--Versions above `4.2.1` are not included in the overlay, as newest version of wcslib in the main tree is still `7.4` (2021-12), while astropy>=4.3.1 officially bundle the `7.7`.-->

Ebuilds of versions of `5.0.8` and below might only be templates and are masked now. You'd better ignore them.
<!--We still keep `dev-python/pyerfa-1.7.2` in this overlay, as astropy 4.2.1 released before pyerfa 1.7.3 released.

Old versions in this overlay might be removed in the future.

Doc building fail with version `4.2.1`. Still no idea how to fix it.

Test phase aborts while running with `4.2.1`. Seems caused by erfa, but not sure.-->
