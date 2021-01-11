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

Update to newest version as the `cfitsio` and `wcslib` in official portage are up-to-date now, while `erfa` is still using the one in [sciense](https://wiki.gentoo.org/wiki/Project:Science) overlay.

Old versions in this overlay might be removed in the future.

Doc building will fail with version `4.2`. Still no idea how to fix it.
