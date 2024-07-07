# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PLOCALES="ar_SA ay_WI be_BY be_BY@latin bg_BG cs_CZ de_DE el_GR eo_EO es_AR es_BO es_ES fa_IR fi_FI fr_FR hi_IN ie_001 it_IT ja_JP jb_JB ko_KR lt_LT mk_MK nl_NL pl_PL pt_BR qt_es qt_it qt_lt qu_WI ru_RU sk_SK sq_AL sr_SR sv_SE tg_TJ tk_TM tr_TR uk_UA vi_VN zh_CN zh_TW"

inherit desktop plocale qmake-utils xdg

DESCRIPTION="Feature-rich dictionary lookup program"
HOMEPAGE="http://goldendict.org/"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/${PN}/${PN}.git"
	EGIT_SUBMODULES=()
	inherit git-r3
else
	MY_PV=${PV^^}
	MY_PV=${MY_PV/_/-}
	SRC_URI="https://github.com/${PN}/${PN}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/${PN}-${MY_PV}"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="debug ffmpeg"

RDEPEND="
	app-arch/bzip2
	>=app-text/hunspell-1.2:=
	dev-libs/eb
	dev-libs/lzo
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qthelp:5
	dev-qt/qtnetwork:5
	dev-qt/qtprintsupport:5
	dev-qt/qtsql:5
	dev-qt/qtsvg:5
	dev-qt/qtwebkit:5
	dev-qt/qtwidgets:5
	dev-qt/qtx11extras:5
	dev-qt/qtxml:5
	media-libs/libvorbis
	media-libs/tiff:0
	sys-libs/zlib
	x11-libs/libX11
	x11-libs/libXtst
	ffmpeg? (
		media-libs/libao
		media-video/ffmpeg:0=
	)
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-qt/linguist-tools:5
	virtual/pkgconfig
"

PATCHES=( "${FILESDIR}/${PN}-fix-all-plocale.patch" )

src_prepare() {
	default

	# disable git
	sed -i -e '/git describe/s/^/#/' ${PN}.pro || die

	# fix installation path
	sed -i -e '/PREFIX = /s:/usr/local:/usr:' ${PN}.pro || die

	# add trailing semicolon
	sed -i -e '/^Categories/s/$/;/' redist/org.${PN}.GoldenDict.desktop || die

	# support ffmpeg>=7.0
	use ffmpeg && eapply "${FILESDIR}/${PN}-add-support-for-ffmpeg-7.0.patch"

	echo "QMAKE_CXXFLAGS_RELEASE = $CXXFLAGS" >> ${PN}.pro
	echo "QMAKE_CFLAGS_RELEASE = $CFLAGS" >> ${PN}.pro

	local loc_dir="${S}/locale"
	plocale_find_changes "${loc_dir}" "" ".ts"
	rm_loc() {
		rm -vf "locale/${1}.ts" || die
		sed -i "/${1}.ts/d" ${PN}.pro || die
	}
	plocale_for_each_disabled_locale rm_loc
}

src_configure() {
	local myconf=()

	if ! use ffmpeg ; then
		myconf+=( CONFIG+=no_ffmpeg_player )
	fi

	myconf+=( CONFIG+=no_qtmultimedia_player )
	eqmake5 "${myconf[@]}" ${PN}.pro
}

install_locale() {
	insinto /usr/share/${PN}/locale
	doins "${S}"/locale/${1}.qm
	eend $? || die "failed to install $1 locale"
}

src_install() {
	dobin ${PN}
	domenu redist/org.${PN}.GoldenDict.desktop
	doicon redist/icons/${PN}.png

	insinto /usr/share/${PN}/help
	doins help/gdhelp_en.qch
	plocale_for_each_locale install_locale
}
