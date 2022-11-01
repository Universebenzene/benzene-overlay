# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="eusoft-${PN}"
PD="2022-10-31"

inherit unpacker qmake-utils desktop xdg

DESCRIPTION="Proprietary German dictionary software for linux"
HOMEPAGE="https://www.eudic.net/v4/de/app/dehelper"
SRC_URI="https://www.eudic.net/download/${PN}.deb?v=${PD} -> ${P}_amd64.deb"

LICENSE="eudic"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE="ibus"

RDEPEND="dev-qt/qtgui:5[ibus?]
	dev-qt/qtimageformats:5
	dev-qt/qtlocation:5
	dev-qt/qtspeech:5[flite]
	dev-qt/qtsvg:5
	dev-qt/qtwebkit:5[X,orientation,qml,webp]
"
DEPEND=""
BDEPEND=""

S="${WORKDIR}"

QA_PREBUILT="opt/${PN}/*"

src_prepare() {
	sed -i "s|/usr/share/${MY_PN}/AppRun|${PN}|g" usr/share/applications/${MY_PN}.desktop || die
	sed -i "/^Prefix/c Prefix = $(qt5_get_libdir)/qt5" usr/share/${MY_PN}/qt.conf || die
	default
}

src_install() {
	insinto /opt/${PN}
	doins -r usr/share/${MY_PN}/{dat,dic,translations,${PN},qt.conf}

	fperms +x /opt/${PN}/${PN}
	dosym -r /opt/${PN}/${PN} /usr/bin/${PN}

	doicon usr/share/pixmaps/com.${MY_PN/-/.}.png
	domenu usr/share/applications/${MY_PN}.desktop
}
