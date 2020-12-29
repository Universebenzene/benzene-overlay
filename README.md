# benzene-overlay
Universebenzene's personal Gentoo overlay.

Including some old software that no longer supported by official portage.

Alternative building of astropy related packages (more improvement for the doc building, though some of them only work when the `network-sandbox` FEATURE is diabled, see the USE discriptions for details).

Related overlay: [benzene-testlay](https://github.com/Universebenzene/benzene-testlay), with some packages testing. You can add it for interest.

This overlay is available on [Gentoo repositories](https://overlays.gentoo.org). You can add it simply through several tools (e.g. via layman: `layman -a benzene-overlay`).

### Available packages

Package name | Available version | Additional information
------------ | :---------------: | ----------------------
app-office/wps-office        | 11.1.0.9711; 11.1.0.9719   | Add CN version and more language support (encouraged by [AUR](https://aur.archlinux.org/packages/?O=0&SeB=nd&K=wps-office&outdated=&SB=n&SO=a&PP=50&do_Search=Go))
app-text/ydcv                | 0.7                        | Need the [HomeAssistantRepository](https://git.edevau.net/onkelbeh/HomeAssistantRepository) overlay if you enable `pkg-info` use. Some other issues [here](https://forums.gentoo.org/viewtopic-p-8352006.html)
app-text/youdao-dict         | 6.0.0                      | Converted from [AUR](https://aur.archlinux.org/packages/youdao-dict). In order to use this you **must use the patched QtWebkit in this overlay INSTEAD OF THE OFFICIAL ONE**
dev-qt/qtwebkit              | 5.212.0\_pre20200309-r1    | Add [patch](https://github.com/Universebenzene/benzene-overlay/blob/master/dev-qt/qtwebkit/files/qtwebkit-5.212.0_pre20200309-position.patch) to get **youdao-dict** in this overlay work
media-fonts/wps-office-fonts | 1.0                        |
media-gfx/gpaint             | 0.3.3                      | With patches from Debian
media-video/gnome-mplayer    | 1.0.9-r1                   | Dropped by official portage
net-im/electronic-wechat-bin | 2.3.1                      | Converted from [AUR](https://aur.archlinux.org/packages/electronic-wechat-bin)
net-misc/baidunetdisk        | 3.0.1; 3.4.1; 3.5.0        | Converted from [AUR](https://aur.archlinux.org/packages/baidunetdisk-bin) (Also in [gentoo-zh](https://github.com/microcai/gentoo-zh) overlay, while upgrade will be faster here)
net-misc/baidupcs-go         | 3.6.2; (live)              | Also in [gentoo-zh](https://github.com/microcai/gentoo-zh) overlay, while upgrade will be faster here
net-misc/baidupcs-go-bin     | 3.6.2                      |
net-misc/sunloginclient      | 10.0.2.24779; 10.1.1.38139 | Converted from [AUR](https://aur.archlinux.org/packages/sunloginclient), but **versions ABOVE `10.0.2.24779` have some problem with OpenRC users** . See [here](https://github.com/Universebenzene/benzene-overlay/tree/master/net-misc/sunloginclient#note-for-sunloginclient) for details
net-misc/xunlei-download     | 1.0.0.1; 1.0.0.1-r1        | Converted from [AUR](https://aur.archlinux.org/packages/xunlei-bin/)
www-plugins/adobe-flash      | 32.0.0.465                 | Dropped by official portage
x11-libs/lain                | (live version)             | 9999 for old ebuild without lua targets support; 9999-r100 with the new `lua-single` eclass
dev-python/astlib            | 0.8.0; 0.11.3              |
sci-astronomy/aladin         | 11.024                     |
sci-astronomy/astrometry     | 0.78; 0.80                 | Add USE for switching the netpbm support
sci-astronomy/topcat         | 4.7.2; 4.7.3               |

Informations for some of the astropy related packages are listed [here](https://github.com/Universebenzene/benzene-overlay/tree/master/dev-python#informations-for-astropy-related-packages).
