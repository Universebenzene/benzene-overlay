# benzene-overlay
Universebenzene's personal Gentoo overlay.

Including some old software that no longer supported by official portage.

Alternative building of astropy related packages (more improvement for the doc building and testing, though some of them only work when the `network-sandbox` FEATURE is diabled. See the USE descriptions for details. [(more information)](https://github.com/Universebenzene/benzene-overlay/tree/master/dev-python#information-for-astropy-related-packages)

Related overlay: [benzene-testlay](https://github.com/Universebenzene/benzene-testlay), with some packages testing. You can add it for interest.

This overlay is available on [Gentoo repositories](https://overlays.gentoo.org). You can add it simply through several tools (e.g.: `layman -a benzene-overlay` or `eselect repository enable benzene-overlay`).

It's recommended to mask the whole overlay and then unmask just the packages you need, in order not to get mixed up with other overlays with same packages. (e.g. for using wps-office: `echo "*/*::benzene-overlay" > /etc/portage/package.mask/benzene-overlay; echo "app-office/wps-office::benzene-overlay" >> /etc/portage/package.unmask/benzene-overlay`)

### Available packages (some dependencies are not listed here)

Some science related miscellaneous python package are listed in a separate table [below](https://github.com/Universebenzene/benzene-overlay#some-science-related-miscellaneous-python-packages), in order to simplify the main table.

Doc/sphinx and Doc/MkDocs related packages are listed in separate tables [here](https://github.com/Universebenzene/benzene-overlay#docsphinx-related-packages) and [here](https://github.com/Universebenzene/benzene-overlay#docmkdocs-related-packages)

Package name | Available version | Additional information
------------ | :---------------: | ----------------------
[app-editors/formiko](https://github.com/ondratu/formiko)                            | [1.4.3](https://github.com/Universebenzene/benzene-overlay/blob/master/app-editors/formiko/formiko-1.4.3.ebuild); (live)                                   |
app-i18n/fcitx-table-other                                                           | 0.2.4-r1                                                                                                              | Slot 4 with modified icon name in order to be able to install along with fcitx:5. For more support for installing fcitx4 along with 5, try [benzene-testlay](https://github.com/Universebenzene/benzene-testlay).
app-office/wps-office                                                                | 11.1.0.11711-r3; [11.1.0.11723](https://github.com/Universebenzene/benzene-overlay/blob/master/app-office/wps-office/wps-office-11.1.0.11723.ebuild)       | Add CN version and more language support (encouraged by [AUR](https://aur.archlinux.org/packages/?O=0&SeB=nd&K=wps-office&outdated=&SB=n&SO=a&PP=50&do_Search=Go)). From `11.1.0.10702` you need to set locale outside to get multi-language support. **Please focus on the output after merging the package**. Dependency `media-libs/freetype-wps:2` like [AUR](https://aur.archlinux.org/packages/freetype2-wps) can be included without `system-freetype` USE flag to fix the bold font issue, which is provided by [@123485k](https://github.com/123485k)
[app-pda/i4tools](https://www.i4.cn/pro_pc.html)                                     | [3.06.006](https://github.com/Universebenzene/benzene-overlay/blob/master/app-pda/i4tools/i4tools-3.06.006.ebuild)                                         | 爱思助手 <!--`net-nds/openldap-compat` is included in this overlay for fixing the `libldap_r-2.4.so.2` issue-->
app-text/{[de](https://www.eudic.net/v4/de/app/download),[es](https://www.eudic.net/v4/es/app/download),[fr](https://www.eudic.net/v4/fr/app/download)}helper | [12.7.1](https://github.com/Universebenzene/benzene-overlay/tree/master/app-text) | Converted from [AUR](https://aur.archlinux.org/packages/frhelper) （欧路德语/西语/法语助手）
[app-text/eudic](https://www.eudic.net/v4/en/app/download)                           | [12.7.1](https://github.com/Universebenzene/benzene-overlay/blob/master/app-text/eudic/eudic-12.7.1.ebuild)                                                | Converted from [AUR](https://aur.archlinux.org/packages/eudic) （欧路词典）
[app-text/goldendict](http://goldendict.org)                                         | [1.5.0](https://github.com/Universebenzene/benzene-overlay/blob/master/app-text/goldendict/goldendict-1.5.0.ebuild); [22.12.02\_p20230924104339](https://github.com/Universebenzene/benzene-overlay/blob/master/app-text/goldendict/goldendict-22.12.02_p20230924104339.ebuild); (live){,-r22} | Dropped by official portage. Fix the ebuild for [pg\_overlay](https://gitlab.com/Perfect_Gentleman/PG_Overlay/-/blob/master/app-text/goldendict/goldendict-9999.ebuild). Version above `22` and `9999-r22` are forked versions from [here](https://github.com/goldendict/goldendict/pull/1542) which can use `qtwebengine` instead of `qtwebkit`
[app-text/powerword](http://www.iciba.com)                                           | [1.2](https://github.com/Universebenzene/benzene-overlay/blob/master/app-text/powerword/powerword-1.2.ebuild)                                              | Encouraged by [AUR](https://aur.archlinux.org/packages/powerword-bin) （金山词霸）
[app-text/ydcv](https://github.com/felixonmars/ydcv)                                 | [0.7](https://github.com/Universebenzene/benzene-overlay/blob/master/app-text/ydcv/ydcv-0.7.ebuild); (live)                                                | Need other overlays (like [guru](https://wiki.gentoo.org/wiki/Project:GURU) or [HomeAssistantRepository](https://git.edevau.net/onkelbeh/HomeAssistantRepository)) if you enable `pkg-info` use. Some other issues [here](https://forums.gentoo.org/viewtopic-p-8352006.html) （有道词典命令行-python版）
[app-text/ydcv-rs](https://github.com/farseerfc/ydcv-rs)                             | [0.6.3](https://github.com/Universebenzene/benzene-overlay/blob/master/app-text/ydcv-rs/ydcv-rs-0.6.3.ebuild); (live)                                      |
[app-text/ydgo](https://github.com/boypt/ydgo)                                       | [0.6.3](https://github.com/Universebenzene/benzene-overlay/blob/master/app-text/ydgo/ydgo-0.6.3.ebuild); (live)                                            | **Needs interactive inputing during merging process. PAY ATTENTION TO THE OUTPUT MESSAGES** （有道词典命令行-go版）
[app-text/youdao-dict](https://cidian.youdao.com/multi.html#linuxAll)                | [6.0.0-r3](https://github.com/Universebenzene/benzene-overlay/blob/master/app-text/youdao-dict/youdao-dict-6.0.0-r3.ebuild)                                | Converted from [AUR](https://aur.archlinux.org/packages/youdao-dict). In order to use this you **must use the patched QtWebkit and PyQt5 with `webkit` USE flag in this overlay INSTEAD OF THE OFFICIAL ONE** （有道词典）
[app-vim/indentLine](https://github.com/Yggdroot/indentLine)                         | 2.0; (live)                                                                                                           | Live version is recommended
[app-vim/vim-indent-guides](https://github.com/preservim/vim-indent-guides)          | 1.6; (live)                                                                                                           |
dev-cpp/gtkspellmm                                                                   | 3.0.5                                                                                                                 | Dependency for [gimagereader[gtk]](https://gitlab.com/salfter/portage/-/tree/master/app-text/gimagereader?ref_type=heads)
dev-lang/gdl                                                                         | 1.0.0\_rc3-r3; 1.0.1-r3; 1.0.4-r1                                                                                     | Allow `gdl` and the python module installed at the same time
dev-python/aioftp                                                                    | 0.22.3                                                                                                                |
dev-python/corner                                                                    | 2.2.2                                                                                                                 |
dev-python/dask                                                                      | 2024.4.1; 2024.8.2                                                                                                    | Dropped by official portage
dev-python/exifread                                                                  | 3.0.0                                                                                                                 |
dev-python/glfw                                                                      | 2.7.0                                                                                                                 | Dependency for glue-vispy-viewer>=1.2.0
dev-python/glymur                                                                    | 0.12.0; 0.12.9\_p1; 0.12.9\_p2; 0.13.2\_p1; 0.13.6                                                                    |
dev-python/hsluv                                                                     | 5.0.4                                                                                                                 |
[dev-python/memray](https://bloomberg.github.io/memray)                              | 1.10.0; [1.14.0](https://github.com/Universebenzene/benzene-overlay/blob/master/dev-python/memray/memray-1.14.0.ebuild)                                    | **BINARY WHEEL VERSIONS** are used to avoid npm building
dev-python/nose                                                                      | 1.3.7\_p20221026-r1                                                                                                   | Dropped by official portage
dev-python/oldest-supported-numpy                                                    | 2023.12.21                                                                                                            | The numpy version limitations are changed from `==` into `>=`. If you have better solution, just bring issues or pull requests.
dev-python/parfive                                                                   | 1.5.1; 2.1.0                                                                                                          |
dev-python/PyQt5                                                                     | 5.15.11                                                                                                               | Add `webkit` USE flag (dropped by official portage) to get **youdao-dict** in this overlay work
dev-python/pydantic-settngs                                                          | 2.5.2                                                                                                                 |
dev-python/pytest-cython                                                             | 0.2.2; 0.3.1                                                                                                          |
dev-python/pytest-socket                                                             | 0.7.0                                                                                                                 |
dev-python/api4jenkins                                                               | 2.0.3                                                                                                                 |
dev-python/python-jenkins                                                            | 1.8.2; (live)                                                                                                         | Dependency multi\_key\_dict is also included but not listed here
dev-python/vispy                                                                     | 0.13.0; 0.14.3                                                                                                        |
dev-python/yt                                                                        | 4.0.5; 4.1.4; 4.2.2; 4.3.0; 4.3.1                                                                                     | Full doc building needs huge amount of data, so cannot complete locally.
dev-python/zarr                                                                      | 2.18.3                                                                                                                |
dev-qt/qtwebkit                                                                      | 5.212.0\_pre20200309-{r1,r2}                                                                                          | Add [patch](https://github.com/Universebenzene/benzene-overlay/blob/master/dev-qt/qtwebkit/files/qtwebkit-5.212.0_pre20200309-position.patch) to get **youdao-dict** in this overlay work (the -r2 is a test for upgrade EAPI to 8, and might be a little buggy with youdao-dict.)
[dev-util/micromamba{,-bin}](https://mamba.readthedocs.io)                           | [1.5.6](https://github.com/Universebenzene/benzene-overlay/blob/master/dev-util/micromamba/micromamba-1.5.6.ebuild)                                        | `dev-util/mamba[micromamba]` in [gentoo-zh](https://github.com/microcai/gentoo-zh) is **recommended** if you want source version and don't care about testing. Also need [gentoo-zh](https://github.com/microcai/gentoo-zh) to provide dependency `dev-cpp/reproc`, `dev-cpp/tl-expected` and `sys-libs/libsolv` .
gnome-base/gconf                                                                     | 3.2.6-r6                                                                                                              | Dropped by official portage but required by `net-misc/oss-browser-bin`. Copied from [KBrown-pub](https://git.softwarelibre.mx/KBrown/gentoo-overlay/-/blob/KBrown-pub/gnome-base/gconf) and [kzd](https://gitlab.com/kzdixon/kzd-ebuilds/-/blob/master/gnome-base/gconf) overlays but fix dependency `dev-util/gtk-doc-am` → `dev-build/gtk-doc-am`
[gui-apps/regreet](https://github.com/rharish101/ReGreet)                            | [0.1.1](https://github.com/Universebenzene/benzene-overlay/blob/master/gui-apps/regreet/regreet-0.1.1.ebuild); (live)                                      | Encouraged by [guru](https://gitweb.gentoo.org/repo/proj/guru.git/tree/gui-apps/ReGreet) but better naming and packaging. Needs enabling the guru overlay if you enable the `cage` flag.
media-fonts/wps-office-fonts                                                         | [1.0](https://github.com/Universebenzene/benzene-overlay/blob/master/media-fonts/wps-office-fonts/wps-office-fonts-1.0.ebuild)                             | WPS Linux旧版自带方正系字体
[media-gfx/gpaint](https://savannah.gnu.org/projects/gpaint)                         | [0.3.3](https://github.com/Universebenzene/benzene-overlay/blob/master/media-gfx/gpaint/gpaint-0.3.3.ebuild)                                               | With patches from Debian
[media-gfx/fontweak](https://github.com/guoyunhe/fontweak)                           | [1.3.1](https://github.com/Universebenzene/benzene-overlay/blob/master/media-gfx/fontweak/fontweak-1.3.1.ebuild)                                           | GUI for fontconfig
media-libs/gmtk                                                                      | 1.0.9                                                                                                                 | Dropped by official portage. Dependency of media-video/gnome-mplayer
[media-video/bcwc\_pcie](https://github.com/patjak/bcwc_pcie)                        | [(live version)](https://github.com/Universebenzene/benzene-overlay/blob/master/media-video/bcwc_pcie/bcwc_pcie-9999.ebuild)                               | Slightly edited from [menelkir's overlay](https://gitlab.com/menelkir/gentoo-overlay/-/blob/master/media-video/bcwc_pcie/bcwc_pcie-9999.ebuild). If you have any problems about enabling kernel options, take a look at [this](https://asciinema.org/a/YMmYygzctHvKKq7pB97sSHwRu).
[media-video/facetimehd-firmware](https://github.com/patjak/facetimehd-firmware)     | [(live version)](https://github.com/Universebenzene/benzene-overlay/blob/master/media-video/facetimehd-firmware/facetimehd-firmware-9999.ebuild)           | Converted from [AUR](https://aur.archlinux.org/packages/facetimehd-firmware). `9999` indicates the git repo of the downloading tool, not the real version of the firmware (1.43.0 right now).
[media-video/gnome-mplayer](https://sites.google.com/site/kdekorte2/gnomemplayer)    | [1.0.9-r1](https://github.com/Universebenzene/benzene-overlay/blob/master/media-video/gnome-mplayer/gnome-mplayer-1.0.9-r1.ebuild)                         | Dropped by official portage
media-sound/ting-{[de](https://www.eudic.net/v4/de/app/ting),[en](https://www.eudic.net/v4/en/app/ting),[es](https://www.eudic.net/v4/es/app/ting),[fr](https://www.eudic.net/v4/fr/app/ting)}}-bin | [9.4.1](https://github.com/Universebenzene/benzene-overlay/tree/master/media-sound) | 欧路每日德语/英语/西语/法语听力
net-im/electron-qq-bin (masked)                                                      | 1.5.7; 2.1.4                                                                                                          | Already deprecated and renamed as Icalingua (also in this overlay)
[net-fs/ossfs](https://github.com/aliyun/ossfs)                                      | [1.91.4](https://github.com/Universebenzene/benzene-overlay/blob/master/net-fs/ossfs/ossfs-1.91.4.ebuild)                                                  | 阿里云对象存储OSS Bucket挂载工具
[net-im/electron-wechat-bin](https://github.com/eNkru/freechat)                      | [1.0.0](https://github.com/Universebenzene/benzene-overlay/blob/master/net-im/electron-wechat-bin/electron-wechat-bin-1.0.0.ebuild)                        | Newer project of Electron-built WeChat, a.k.a. Freechat
[net-im/electronic-wechat-bin](https://github.com/Riceneeder/electronic-wechat)      | [2.3.1](https://github.com/Universebenzene/benzene-overlay/blob/master/net-im/electronic-wechat-bin/electronic-wechat-bin-2.3.1.ebuild); 2.3.2 (masked)    | Version 2.3.2 is a fixed version by UOS header. However **Tencent will limit your account if you use this version**, so it's masked now. See [here](https://aur.archlinux.org/packages/electronic-wechat-uos-bin) for more information.
[net-im/icalingua++-bin](https://github.com/Icalingua-plus-plus/Icalingua-plus-plus) | 2.7.7; 2.9.13; [2.12.20](https://github.com/Universebenzene/benzene-overlay/blob/master/net-im/icalingua++-bin/icalingua++-bin-2.12.20.ebuild)             | Previously called Electron QQ. A branch of previous deleted repo, with limited support.
[net-im/wemeet](https://source.meeting.qq.com/download-center.html)                  | 2.8.0.3; 3.10.0.401; [3.19.1.401](https://github.com/Universebenzene/benzene-overlay/blob/master/net-im/wemeet/wemeet-3.19.0.401.ebuild) | Encouraged by [AUR](https://aur.archlinux.org/packages/wemeet-bin) （腾讯会议）
[net-libs/libaxon-bin](https://codeberg.org/goodspeed/axon)                          | [1.0.2](https://github.com/Universebenzene/benzene-overlay/blob/master/net-libs/libaxon-bin/libaxon-bin-1.0.2.ebuild)                                      | Backend for Purple OICQ
[net-misc/baidunetdisk](https://pan.baidu.com/download)                              | 3.0.1; 4.3.0; [4.17.7](https://github.com/Universebenzene/benzene-overlay/blob/master/net-misc/baidunetdisk/baidunetdisk-4.17.7.ebuild)                    | Converted from [AUR](https://aur.archlinux.org/packages/baidunetdisk-bin) and encouraged by [fixing](https://github.com/microcai/gentoo-zh/pull/3633) from @vowstar (Also in [gentoo-zh](https://github.com/microcai/gentoo-zh) overlay, while upgrade will be faster here) （百度网盘）
[net-misc/baidupcs-go](https://github.com/qjfoidnh/BaiduPCS-Go)                      | 3.6.2; 3.8.1; 3.9.5\_beta(template); [3.9.5](https://github.com/Universebenzene/benzene-overlay/blob/master/net-misc/baidupcs-go/baidupcs-go-3.9.5.ebuild); [(live)](https://github.com/Universebenzene/benzene-overlay/blob/master/net-misc/baidupcs-go/baidupcs-go-9999.ebuild) | Also in [gentoo-zh](https://github.com/microcai/gentoo-zh) overlay, while upgrade will be faster here. **Proxy may needed if you use the `9999` version**, as the [proxy.golang.org](https://proxy.golang.org) is banned in some regions
net-misc/baidupcs-go-bin                                                             | 3.6.2; 3.9.5\_beta(template); 3.9.5 |
[net-misc/landrop](https://landrop.app)                                              | [0.4.0](https://github.com/Universebenzene/benzene-overlay/blob/master/net-misc/landrop/landrop-0.4.0.ebuild); (live)                                      |
[net-misc/oss-browser-bin](https://github.com/aliyun/oss-browser)                    | [1.18.0](https://github.com/Universebenzene/benzene-overlay/blob/master/net-misc/oss-browser-bin/oss-browser-bin-1.18.0.ebuild)                            | Encouraged by [AUR](https://aur.archlinux.org/packages/oss-browser-bin) （阿里云对象存储OSS图形化管理工具）
[net-misc/ossutil](https://github.com/aliyun/ossutil)                                | [1.7.19](https://github.com/Universebenzene/benzene-overlay/blob/master/net-misc/ossutil/ossutil-1.7.19.ebuild); (live)                                    | 阿里云对象存储OSS命令行工具
[net-misc/sunloginclient](https://sunlogin.oray.com/download)                        | [10.0.2.24779](https://github.com/Universebenzene/benzene-overlay/blob/master/net-misc/sunloginclient/sunloginclient-10.0.2.24779.ebuild); [11.0.0.36662-r1](https://github.com/Universebenzene/benzene-overlay/blob/master/net-misc/sunloginclient/sunloginclient-11.0.0.36662-r1.ebuild); [15.2.0.63064](https://github.com/Universebenzene/benzene-overlay/blob/master/net-misc/sunloginclient/sunloginclient-15.2.0.63064.ebuild) | Converted from [AUR](https://aur.archlinux.org/packages/sunloginclient), but **versions ABOVE `10.0.2.24779` may have some problem with OpenRC users** (needs libsystemd). See [here](https://github.com/Universebenzene/benzene-overlay/tree/master/net-misc/sunloginclient#note-for-sunloginclient) for details and solutions（向日葵远程控制）
[net-misc/todesk](https://www.todesk.com/download.html)                              | 4.1.0-r4; [4.3.1.0](https://github.com/Universebenzene/benzene-overlay/blob/master/net-misc/todesk/todesk-4.3.1.0.ebuild); 4.7.2.0                         | Encouraged by [AUR](https://aur.archlinux.org/packages?O=0&SeB=nd&K=todesk-&outdated=&SB=n&SO=a&PP=50&submit=Go) （ToDesk远程控制）
[net-misc/xunlei-download](https://www.xunlei.com)                                   | [1.0.0.5](https://github.com/Universebenzene/benzene-overlay/blob/master/net-misc/xunlei-download/xunlei-download-1.0.0.5.ebuild)                          | Converted from [AUR](https://aur.archlinux.org/packages/xunlei-bin) （迅雷Linux）
[net-news/quiterss](https://quiterss.org)                                            | [0.19.4](https://github.com/Universebenzene/benzene-overlay/blob/master/net-news/quiterss/quiterss-0.19.4.ebuild); (live)                                  | Dropped by official portage along with qtwebkit
[net-proxy/gg](https://github.com/mzz2017/gg)                                        | 0.2.13; [0.2.19](https://github.com/Universebenzene/benzene-overlay/blob/master/net-proxy/gg/gg-0.2.19.ebuild)                                             |
[net-proxy/v2raya-bin](https://v2raya.org)                                           | 1.5.1698.1; [2.2.5.8](https://github.com/Universebenzene/benzene-overlay/blob/master/net-proxy/v2raya-bin/v2raya-bin-2.2.5.8.ebuild)                       | Converted from [AUR](https://aur.archlinux.org/packages/v2raya-bin). Needs other overlays like [gentoo-zh](https://github.com/microcai/gentoo-zh). From 2.2.1 only armv7 source is used for arm KEYWORD. If you need armv6 one, try editing the `SRC_URI` yourself.
[sci-astronomy/aladin-bin](https://aladin.u-strasbg.fr/aladin.gml)                   | [12.060](https://github.com/Universebenzene/benzene-overlay/blob/master/sci-astronomy/aladin-bin/aladin-bin-12.060.ebuild)                                 |
[sci-astronomy/astrometry](https://astrometry.net)                                   | 0.78; 0.80; 0.85; [0.96](https://github.com/Universebenzene/benzene-overlay/blob/master/sci-astronomy/astrometry/astrometry-0.96.ebuild)                   | Add USE for switching the netpbm support
[sci-astronomy/healpix](https://healpix.jpl.nasa.gov)                                | [3.82](https://github.com/Universebenzene/benzene-overlay/blob/master/sci-astronomy/healpix/healpix-3.82.ebuild) [3.83\_pre20240419](https://github.com/Universebenzene/benzene-overlay/blob/master/sci-astronomy/healpix/healpix-3.83_pre20240419.ebuild) | [sci-libs/libsharp](https://github.com/Universebenzene/benzene-overlay/tree/master/sci-libs/libsharp) needed for the `cxx` USE flag is also in this overlay but not listed in this table directly
[sci-astronomy/topcat](http://www.star.bris.ac.uk/~mbt/topcat)                       | 4.8; 4.9.1; [4.10](https://github.com/Universebenzene/benzene-overlay/blob/master/sci-astronomy/topcat/topcat-4.10.ebuild)                                 |
[sys-block/diskus](https://github.com/sharkdp/diskus)                                | [0.7.0](https://github.com/Universebenzene/benzene-overlay/blob/master/sys-block/diskus/diskus-0.7.0.ebuild); (live)                                       |
sys-libs/libsystemd                                                                  | 254.13; 254.16; 254.17; 254.18; 255.7; 255.10; 255.11; 255.12; 256.1-r3; 256.2; 256.4; 256.5; 256.6; (live)           | A standalone package to provide `libsystemd.so` for packages depend on the lib on non-systemd system. [Still on trial](https://github.com/Universebenzene/benzene-overlay/tree/master/sys-libs/libsystemd). **IF YOU HAVE ANY IDEA TO IMPROVE THIS PACKAGE JUST BRING ISSUES OR PULL REQUESTS.**
sys-libs/elogind-libsystemd                                                          | 0                                                                                                                     | An alternative way to provide standalone `libsystemd.so` by just linking `libelogind.so`. **Does not support multilib yet due to elogind itself.**
www-plugins/adobe-flash                                                              | [32.0.0.465](https://github.com/Universebenzene/benzene-overlay/blob/master/www-plugins/adobe-flash/adobe-flash-32.0.0.465.ebuild)                         | Dropped by official portage
[x11-libs/lain](https://github.com/lcpz/lain)                                        | [(live version)](https://github.com/Universebenzene/benzene-overlay/blob/master/x11-libs/lain/lain-9999-r100.ebuild)                                       | 9999 for old ebuild without lua targets support (masked); 9999-r100 with the new `lua-single` eclass
[x11-plugins/purple-oicq](https://codeberg.org/goodspeed/purple-oicq)                | [1.0.2](https://github.com/Universebenzene/benzene-overlay/blob/master/x11-plugins/purple-oicq/purple-oicq-1.0.2.ebuild); (live)                           | OICQ plugin (Tencent QQ support) for Pidgin/libpurple.
virtual/libsystemd                                                                   | 0                                                                                                                     | A virtual package for choosing `libsystemd.so` packages

Information for some of the astropy related packages are listed [here](https://github.com/Universebenzene/benzene-overlay/tree/master/dev-python#information-for-astropy-related-packages).

### Some science related miscellaneous python packages

Packages in this table might just be pulled in as dependencies by some sicense related python packages.

<!--<details>
<summary>(Click to unfold)</summary>-->

Package name | Available version | Additional information
------------ | :---------------: | ----------------------
dev-python/adal                    | 1.2.7                                                      | SunPy, h5pyd related
dev-python/abg-python              | 1.1.4                                                      | Optional for yt
dev-python/aggdraw                 | 1.3.16; 1.3.19                                             | Optional for ginga
dev-python/aiobotocore             | 2.13.2                                                     | Pulled in by s3fs
dev-python/arviz                   | 0.17.1; 0.19.0                                             | Optional for corner.py.
dev-python/asciitree               | 0.3.3                                                      | Pulled in by zarr
dev-python/azure-core              | 1.26.3; 1.31.0                                             | Required by new msrest
dev-python/bidict                  | 0.22.0; 0.23.1                                             | Optional for yt
dev-python/bsddb3                  | 6.2.9-r1                                                   | Dropped by official portage. Required by firefly{,-viz}
dev-python/check-manifest          | 0.49                                                       | Dropped by official portage. Build dependency for xarray-datatree
dev-python/cmdstanpy               | 1.0.8; 1.2.4                                               | Test dependency for arviz. Dependency stanio is included but not listed in the table
dev-python/distributed             | 2024.4.1; 2024.8.2                                         | Optional for arviz and spectral-cube
dev-python/dm-tree{,-bin}          | 0.1.8                                                      | Required by new arviz
dev-python/eventlet                | 0.33.3; 0.35.2                                             | Dropped by official portage. Required by firefly{,-viz}
dev-python/f90nml                  | 1.4.4                                                      | Optional for yt
dev-python/fastcache               | 1.1.0                                                      | Optional for yt
dev-python/firefly-viz             | 2.0.4                                                      | Optional for yt
dev-python/firefly                 | 3.2.4                                                      | Optional for new yt
dev-python/flask-socketio          | 5.3.7                                                      | Optional for yt
dev-python/fusepy                  | 3.0.1                                                      | Optional for yt
dev-python/heapdict                | 1.0.1                                                      | Pulled in by zict and distributed
dev-python/indexed\-{bzip2,zstd}   | 1.6.0 / 1.6.1                                              | Optional for yt (ratarmount{,core})
dev-python/rapidgzip               | 0.14.2                                                     | Optional for new ratarmount{,core}
dev-python/libconf                 | 2.0.1                                                      | Optional for yt
dev-python/memory-profiler         | 0.61                                                       | Dropped by official portage. Test dependency for ccdproc
dev-python/miniballcpp             | 0.2.3                                                      | Optional for yt
dev-python/msrest                  | 0.7.1                                                      | SunPy, h5pyd related
dev-python/msrestazure             | 0.6.4                                                      | SunPy, h5pyd related
dev-python/numcodecs               | 0.12.1; 0.13.0                                             | Pulled in by zarr
dev-python/pykdtree                | 1.3.13                                                     | Optional for yt
dev-python/pytest-examples         | 0.0.13                                                     | Test dependency for pydantic-settings
dev-python/pytest-repeat           | 0.9.3                                                      | Test dependency for new zict
dev-python/pytest-textual-snapshot | 1.0.0                                                      | Test dependency for new memray. Dependency syrupy is included but not listed in the table
dev-python/python-pkcs11           | 0.7.0-r1                                                   | Test and optional dependency for asyncssh. Recover from [GURU](https://gitweb.gentoo.org/repo/proj/guru.git/commit/?id=a6b3f15b1a76a2b066f9ff763fab5588bab902c6)
dev-python/python-socketio         | 5.9.0; 5.11.4                                              | Optional for yt
dev-python/python-xz               | 0.5.0                                                      | Optional for yt
dev-python/rasterio                | 1.3.8\_p2; 1.3.11                                          | Optional for photutils. Dependencies are not all listed in the table
dev-python/ratarmount              | 0.14.2; 0.15.2                                             | Optional for yt. Dependency ratarmountcore is also included in this overlay but not listed in the table
dev-python/s3fs                    | 2024.6.1                                                   | Test dependency for zarr and astropy>=5.2
dev-python/siosocks                | 0.3.0                                                      | Optional for aioftp
dev-python/sortedcollections       | 2.1.0                                                      | Test dependency for bidict>=0.23.0
dev-python/textual                 | 0.80.1                                                     | Pulled in by memray>=1.11. Dependency tree-sitter-languages is included but not listed in the table
dev-python/colorspacious           | 1.1.2                                                      | Pulled in by cmyt. Dropped by official portage
dev-python/cmyt                    | 2.0.0                                                      | Pulled in by yt
dev-python/unyt                    | 2.9.5; 3.0.3                                               | Pulled in by yt
dev-python/zict                    | 2.2.0; 3.0.0                                               | Pulled in by distributed

<!--</details>-->

### Doc/sphinx related packages

<!--<details>
<summary>(Click to unfold)</summary>-->

Package name | Available version | Additional information
------------ | :---------------: | ----------------------
dev-python/sphinx                       | 5.1.1; 7.1.2                    | 5 for old myst-parser and myst-nb; 7.1 for glue-qt doc <!-- sphinx>=6 <- copybutton <-doc- sphinx-thebe -doc-> myst-nb -> myst-parser(oldver needs sphinx<6) -->
dev-python/ablog                        | 0.11.11                         |
dev-python/jupyter-cache                | 0.6.1; 1.0.0                    |
dev-python/jupyter-sphinx               | 0.5.3                           |
dev-python/jupytext                     | 1.16.4                          | Build with wheel source to include Jupyter Lab Extenstion
dev-python/myst-nb                      | 0.17.2; 1.1.2                   |
dev-python/myst-parser                  | 0.18.1-r1                       | Only for myst-nb that depends on old version
dev-python/runnotebook                  | 0.3.1; (live)                   |
dev-python/sphinx-astropy               | 1.6.0; 1.9.1                    | See [here](https://github.com/Universebenzene/benzene-overlay/tree/master/dev-python#information-for-astropy-related-packages) for more information.
dev-python/sphinx-asdf                  | 0.1.3; 0.1.4; 0.2.4             |
dev-python/sphinx-autobuild             | 2021.3.14; 2024.4.16; 2024.9.19 |
dev-python/sphinx-autosummary-accessors | 2023.4.0                        |
dev-python/sphinx-book-theme            | 0.2.0; 1.0.1; 1.1.3             | `network-sandbox` FEATURE will be disabled if you enable `doc` flag for newest version.
dev-python/sphinx-changelog             | 1.6.0                           |
dev-python/sphinx-click                 | 6.0.0                           |
dev-python/sphinx-codeautolink          | 0.15.2                          |
dev-python/sphinx-design                | 0.6.1                           |
dev-python/sphinx-examples              | 0.0.5                           |
dev-python/sphinx-hoverxref             | 1.4.1                           |
dev-python/sphinx-readable-theme        | 1.3.0                           |
dev-python/sphinx-thebe                 | 0.2.1; 0.3.1                    |
dev-python/sphinx-togglebutton          | 0.3.2                           |
dev-python/sphinx-contributors          | 0.2.7                           |
dev-python/sphinx-mdinclude             | 0.6.2                           |
dev-python/sphinxcontrib-globalsubs     | 0.1.2                           |
dev-python/sphinxcontrib-srclink        | 0.2.4                           |
dev-python/sphinxcontrib-youtube        | 1.2.0; 1.4.1                    | `network-sandbox` FEATURE will be disabled if you enable demo videos for doc building in version 1.2.0.
dev-python/sphinxext-opengraph          | 0.9.1                           |
dev-python/dask-sphinx-theme            | 3.0.5                           |
dev-python/sunpy-sphinx-theme           | 1.2.42; 2.0.2; 2.0.16           |
dev-python/pydata-sphinx-theme          | 0.13.3-r1                       | Old version dropped by official portage, required by sunpy-sphinx-theme
dev-python/mistune                      | 0.8.4-r1; 2.0.5                 | For sphinx-asdf and sphinx-mdinclude that depend on old version
dev-python/nbconvert                    | 6.4.5                           | Depends on old mistune

<!--</details>-->

### Doc/MkDocs related packages

<!--<details>
<summary>(Click to unfold)</summary>-->

Package name | Available version        | Additional information
------------ | :---------------:        | ----------------------
dev-python/docstring-parser             | 0.16            | Optional dependency of pytkdocs
dev-python/markdown-callouts            | 0.3.0; 0.4.0    | mkdocstrings related (should be test depend)
dev-python/mkdocs-coverage              | 1.0.0           | mkdocstrings related (should be test depend)
dev-python/mkdocs-git-committers-plugin | 2.3.0           | mkdocstrings related (should be test depend)
dev-python/mkdocs-jupyter               | 0.25.0          |
dev-python/mkdocs-literate-nav          | 0.6.1           | mkdocstrings related (should be test depend)
dev-python/mkdocs-section-index         | 0.3.9           | mkdocstrings related (should be test depend)
dev-python/mkdocstrings-crystal         | 0.3.5; 0.3.7    |
dev-python/mkdocstrings-python-legacy   | 0.2.4           |
dev-python/pytkdocs                     | 0.16.2          | Dependency of mkdocstrings-python-legacy

<!--</details>-->
