# benzene-overlay
Universebenzene's personal Gentoo overlay.

Including some old software that no longer supported by official portage.

Alternative building of astropy related packages (more imporovement for the doc building, though some of them only works when the `network-sandbox` FEATURE is diabled, see the USE discriptions for details).

Related overlay: [benzene-testlay](https://github.com/Universebenzene/benzene-testlay), with some packages testing. You can add it for interest.

To add this overlay, just run `layman -o https://raw.githubusercontent.com/Universebenzene/benzene-overlay/master/repositories.xml -f -a benzene-overlay`. (Planned be able to use `layman -a` in the future)

### Available packages

Package name | Available version | Additional information
------------ | :---------------: | ----------------------
app-text/ydcv               | 0.7            | Need the [HomeAssistantRepository](https://git.edevau.net/onkelbeh/HomeAssistantRepository) overlay if you enable `pkg-info` use. Some other issues [here](https://forums.gentoo.org/viewtopic-p-8352006.html)
media-video/gnome-mplayer   | 1.0.9-r1                     | Dropped by official portage
media-gfx/gpaint            | 0.3.3                        | With patches from Debian
net-misc/baidunetdisk       | 2.0.1; 2.0.2; 3.0.1          | Converted from [AUR](https://aur.archlinux.org/packages/baidunetdisk-bin)
net-misc/baidupcs-go        | 3.6; 3.6.1; (live)           |
net-misc/baidupcs-go-bin    | 3.6; 3.6.1                   |
x11-libs/lain               | (live version)               |
dev-python/astropy          | 2.0.14; 2.0.16; 3.0.5; 3.1.2 | See [here](https://github.com/Universebenzene/benzene-overlay/tree/master/dev-python/astropy#note-for-astropy) for details
dev-python/astropy-helpers  | 2.0.11; 3.0.2; 3.1.1         | With patches for better doc building. Same as the [AUR](https://aur.archlinux.org/packages/python-astropy-helpers/) ones
dev-python/pytest-astropy   | 0.7.0                        | Test plugins for astropy. Dependencies are also in this overlay but not list here
dev-python/sphinx-astropy   | 1.2                          | Modules for building astropy related packages. Dependencies are also in this overlay but not list here
dev-python/asdf             | 1.3.3; 2.5.0                 |
sci-astronomy/astrometry    | 0.78                         | Add USE for switching the netpbm support
