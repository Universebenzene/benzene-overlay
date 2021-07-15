# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DISABLE_AUTOFORMATTING=true
inherit font

DESCRIPTION="The wps-office-fonts package contains Founder Chinese fonts"
HOMEPAGE="http://wps-community.org"
SRC_URI="https://github.com/Universebenzene/wps-office-fonts/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="WPS-EULA"
SLOT="0"
KEYWORDS="amd64 arm ppc ppc64 x86 ~x86-fbsd"

FONT_SUFFIX="TTF"
FONT_PN="${PN/-fonts/}"
FONTDIR="/usr/share/fonts/${FONT_PN}"
