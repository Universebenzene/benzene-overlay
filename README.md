# benzene-overlay
Universebenzene's personal Gentoo overlay.

Including some old software that no longer supported by official portage.

Alternative building of astropy related packages (more improvement for the doc building and testing, though some of them only work when the `network-sandbox` FEATURE is diabled, see the USE discriptions for details. [(more information)](https://github.com/Universebenzene/benzene-overlay/tree/master/dev-python#informations-for-astropy-related-packages)

Related overlay: [benzene-testlay](https://github.com/Universebenzene/benzene-testlay), with some packages testing. You can add it for interest.

This overlay is available on [Gentoo repositories](https://overlays.gentoo.org). You can add it simply through several tools (e.g. via layman: `layman -a benzene-overlay`).

### Available packages

Package name | Available version | Additional information
------------ | :---------------: | ----------------------
app-office/wps-office                                                             | 11.1.0.10161; 11.1.0.10702          | Add CN version and more language support (encouraged by [AUR](https://aur.archlinux.org/packages/?O=0&SeB=nd&K=wps-office&outdated=&SB=n&SO=a&PP=50&do_Search=Go)). From `11.1.0.10702` you need to set locale outside to get multi-language support. **Please focus on the output after merging the package**
[app-pda/i4tools](https://www.i4.cn/pro_pc.html)                                  | 1.0.038                             |
[app-text/ydcv](https://github.com/felixonmars/ydcv)                              | 0.7                                 | Need other overlays (like [guru](https://wiki.gentoo.org/wiki/Project:GURU) or [HomeAssistantRepository](https://git.edevau.net/onkelbeh/HomeAssistantRepository)) if you enable `pkg-info` use. Some other issues [here](https://forums.gentoo.org/viewtopic-p-8352006.html)
[app-text/youdao-dict](https://cidian.youdao.com/multi.html#linuxAll)             | 6.0.0                               | Converted from [AUR](https://aur.archlinux.org/packages/youdao-dict). In order to use this you **must use the patched QtWebkit and PyQt5 with `webkit` USE flag in this overlay INSTEAD OF THE OFFICIAL ONE**
dev-qt/qtwebkit                                                                   | 5.212.0\_pre20200309-{r1,r2}        | Add [patch](https://github.com/Universebenzene/benzene-overlay/blob/master/dev-qt/qtwebkit/files/qtwebkit-5.212.0_pre20200309-position.patch) to get **youdao-dict** in this overlay work (the -r2 is a test for upgrade EAPI to 8, and might be a little buggy with youdao-dict.)
media-fonts/wps-office-fonts                                                      | 1.0                                 |
[media-gfx/gpaint](https://savannah.gnu.org/projects/gpaint)                      | 0.3.3                               | With patches from Debian
media-libs/gmtk                                                                   | 1.0.9                               | Dropped by official portage. Dependency of media-video/gnome-mplayer
[media-video/gnome-mplayer](https://sites.google.com/site/kdekorte2/gnomemplayer) | 1.0.9-r1                            | Dropped by official portage
net-im/electron-qq-bin                                                            | 1.5.7; 2.1.4                        | Already renamed as Icalingua (also in this overlay)
[net-im/electron-wechat-bin](https://github.com/eNkru/freechat)                   | 1.0.0                               | Newer project of Electron-built WeChat, a.k.a. Freechat
[net-im/electronic-wechat-bin](https://github.com/kooritea/electronic-wechat)     | 2.3.1                               | Converted from [AUR](https://aur.archlinux.org/packages/electronic-wechat-bin)
[net-im/icalingua-bin](https://github.com/Clansty/Icalingua)                      | 2.2.1                               | Previously called Electron QQ
[net-im/wemeet](https://source.meeting.qq.com/download-center.html)               | 2.8.0.1                             | Encouraged by [AUR](https://aur.archlinux.org/packages/wemeet-bin)
[net-misc/baidunetdisk](https://pan.baidu.com/download)                           | 3.0.1; 3.4.1; 3.5.0                 | Converted from [AUR](https://aur.archlinux.org/packages/baidunetdisk-bin) (Also in [gentoo-zh](https://github.com/microcai/gentoo-zh) overlay, while upgrade will be faster here)
[net-misc/baidupcs-go](https://github.com/qjfoidnh/BaiduPCS-Go)                   | 3.6.2; 3.8.1; 3.8.3; (live)         | Also in [gentoo-zh](https://github.com/microcai/gentoo-zh) overlay, while upgrade will be faster here. **Proxy may needed if you use the `9999` version**, as the [proxy.golang.org](https://proxy.golang.org) is banned in some regions
net-misc/baidupcs-go-bin                                                          | 3.6.2; 3.8.3                        |
[net-misc/sunloginclient](https://sunlogin.oray.com/download)                     | 10.0.2.24779; 11.0.0.36662          | Converted from [AUR](https://aur.archlinux.org/packages/sunloginclient), but **versions ABOVE `10.0.2.24779` have some problem with OpenRC users** (needs libsystemd). See [here](https://github.com/Universebenzene/benzene-overlay/tree/master/net-misc/sunloginclient#note-for-sunloginclient) for details
[net-misc/xunlei-download](https://www.xunlei.com)                                | 1.0.0.1; 1.0.0.1-r1                 | Converted from [AUR](https://aur.archlinux.org/packages/xunlei-bin)
[net-proxy/v2raya-bin](https://v2raya.org)                                        | 1.4.4-r1; 1.5.2                     | Converted from [AUR](https://aur.archlinux.org/packages/v2raya-bin). Needs other overlays like [gentoo-zh](https://github.com/microcai/gentoo-zh)
www-plugins/adobe-flash                                                           | 32.0.0.465                          | Dropped by official portage
[x11-libs/lain](https://github.com/lcpz/lain)                                     | (live version)                      | 9999 for old ebuild without lua targets support (masked); 9999-r100 with the new `lua-single` eclass
dev-python/astlib                                                                 | 0.8.0; 0.11.3                       |
dev-python/PyQt5                                                                  | 5.15.4-r1; 5.15.5\_pre2107091435[M] | Add `webkit` USE flag (dropped by official portage) to get **youdao-dict** in this overlay work
dev-python/pytest-mpl                                                             | 0.12                                |
[sci-astronomy/aladin](https://aladin.u-strasbg.fr/aladin.gml)                    | 11.024                              |
[sci-astronomy/astrometry](https://astrometry.net)                                | 0.78; 0.80; 0.85                    | Add USE for switching the netpbm support
sci-astronomy/erfa                                                                | 1.7.2                               |
[sci-astronomy/topcat](http://www.star.bris.ac.uk/~mbt/topcat)                    | 4.8; 4.8.1                          |

Informations for some of the astropy related packages are listed [here](https://github.com/Universebenzene/benzene-overlay/tree/master/dev-python#informations-for-astropy-related-packages).
