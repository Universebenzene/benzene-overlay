# benzene-overlay
Universebenzene's personal Gentoo overlay.

Including some old software that no longer supported by official portage.

Alternative building of astropy related packages (more improvement for the doc building, though some of them only work when the `network-sandbox` FEATURE is diabled, see the USE discriptions for details).

Related overlay: [benzene-testlay](https://github.com/Universebenzene/benzene-testlay), with some packages testing. You can add it for interest.

This overlay is available on [Gentoo repositories](https://overlays.gentoo.org). You can add it simply through several tools (e.g. via layman: `layman -a benzene-overlay`).

### Available packages

Package name | Available version | Additional information
------------ | :---------------: | ----------------------
app-office/wps-office        | 11.1.0.9126; 11.1.0.9505; 11.1.0.9522 | Add CN version and more language support (encouraged by [AUR](https://aur.archlinux.org/packages/?O=0&SeB=nd&K=wps-office&outdated=&SB=n&SO=a&PP=50&do_Search=Go))
app-text/ydcv                | 0.7                     | Need the [HomeAssistantRepository](https://git.edevau.net/onkelbeh/HomeAssistantRepository) overlay if you enable `pkg-info` use. Some other issues [here](https://forums.gentoo.org/viewtopic-p-8352006.html)
app-text/youdao-dict         | 6.0.0                   | Converted from [AUR](https://aur.archlinux.org/packages/youdao-dict), but REALLY BUGGY right now. See [here](https://github.com/Universebenzene/benzene-overlay/tree/master/app-text/youdao-dict#note-for-youdao-dict) for details and HOPE ANY ONE CAN HELP ME with it
media-fonts/wps-office-fonts | 1.0                     |
media-gfx/gpaint             | 0.3.3                   | With patches from Debian
media-video/gnome-mplayer    | 1.0.9-r1                | Dropped by official portage
net-misc/baidunetdisk        | 2.0.1; 2.0.2; 3.0.1     | Converted from [AUR](https://aur.archlinux.org/packages/baidunetdisk-bin) (Also in [gentoo-zh](https://github.com/microcai/gentoo-zh) overlay, while upgrade will be faster here)
net-misc/baidupcs-go         | 3.6.2                   | Also in [gentoo-zh](https://github.com/microcai/gentoo-zh) overlay, while upgrade will be faster here
net-misc/baidupcs-go-bin     | 3.6; 3.6.1              |
x11-libs/lain                | (live version)          |
dev-python/astlib            | 0.8.0; 0.11.3           |
sci-astronomy/aladin         | 11.024                  |
sci-astronomy/astrometry     | 0.78; 0.80              | Add USE for switching the netpbm support
sci-astronomy/topcat         | 4.7; 4.7.1              |

Informations for some of the astropy related packages are listed [here](https://github.com/Universebenzene/benzene-overlay/tree/master/dev-python#informations-for-astropy-related-packages).
