# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="com.kingsoft.${PN}"

inherit unpacker wrapper desktop xdg

DESCRIPTION="A Chinese-English dictionary tool by Kingsoft"
HOMEPAGE="http://www.iciba.com"
SRC_URI="amd64? ( https://docs.deepin.com/d/90f1e57130/files/?p=/sign.Powerword_uos_x86.deb&dl=1 -> ${P}-amd64.deb )
	arm64? ( https://docs.deepin.com/d/90f1e57130/files/?p=/sign.Powerword_uos_arm64.deb&dl=1  -> ${P}-arm64.deb )
"

LICENSE="iciba-EULA"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm64"

RDEPEND="media-libs/alsa-lib
	x11-libs/libX11
"
DEPEND=""
BDEPEND=""

S="${WORKDIR}/opt/apps/${MY_PN}"

QA_PREBUILT="opt/${PN}/*"

src_prepare() {
	sed -e "/Exec/c Exec=${PN}\ \%f" -e "/Icon/c Icon=${MY_PN}" -i entries/applications/${MY_PN}.desktop || die
	default
}

src_install() {
	insinto /opt/${PN}/resources
	doins -r files/resources

	insopts -m755
	insinto /opt/${PN}
	doins -r files/{mp3player,${PN^},imageformats,libs}
	make_wrapper ${PN} /opt/${PN}{/${PN^},,/libs}

	doicon -s 48 entries/icons/hicolor/48x48/apps/${MY_PN}.png
	domenu entries/applications/${MY_PN}.desktop
}
