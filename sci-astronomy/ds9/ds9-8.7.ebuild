# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="SAOImageDS9"
MY_P=${MY_PN}-${PV}

inherit desktop xdg

DESCRIPTION="Data visualization application for astronomical FITS images"
HOMEPAGE="http://ds9.si.edu/site/Home.html
	http://hea-www.harvard.edu/RD/ds9/
"
SRC_URI="https://github.com/SAOImageDS9/SAOImageDS9/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
RESTRICT="strip"
KEYWORDS="~amd64 ~x86"

#DEPEND="dev-lang/tk:=
#	dev-lang/tcl:=
#	dev-libs/libxml2:=
#	x11-libs/xpa:=
#"
RDEPEND="dev-libs/libxml2
	media-libs/fontconfig
	media-libs/freetype
	x11-libs/libX11
	x11-libs/libXScrnSaver
	x11-libs/libXext
	x11-libs/libXft
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/xpa
	!sci-astronomy/ds9-bin
"

S="${WORKDIR}/${MY_P}"

ECONF_SOURCE="${S}/unix"

src_install() {
	dobin bin/ds9
	make_desktop_entry --eapi9 "${PN}" -a "%F" -n ${MY_PN} -i ${PN} \
		-c "Science;X-Education;X-Astronomy;X-Astrophysics;X-Imaging;" \
		-e "Version=1.0" -e "Terminal=false" -e "MimeType=image/x-fits;"
	newicon "${PN}"{/doc/sun,}.png
	einstalldocs
#	domenu "${FILESDIR}/${PN}.desktop"
}
