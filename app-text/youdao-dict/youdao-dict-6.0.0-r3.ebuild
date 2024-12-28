# Copyright 2020-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{10..13} )

inherit python-r1 xdg

DESCRIPTION="YouDao Dictionary"
HOMEPAGE="https://cidian.youdao.com"
SRC_URI="
	amd64? ( http://codown.youdao.com/cidian/linux/${P}-amd64.tar.gz )
	x86? ( http://codown.youdao.com/cidian/linux/${PN}_${PV}_i386.tar.gz )
"
LICENSE="youdaodict-proprietary GPL-3+ PSF-2"
SLOT="0"
RESTRICT="strip mirror"
KEYWORDS="-* ~amd64 ~x86"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND=""
RDEPEND="${DEPEND}
	x11-themes/hicolor-icon-theme
	dev-python/pyqt5[${PYTHON_USEDEP},webkit,declarative]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/python-xlib[${PYTHON_USEDEP}]
	dev-python/pygobject[${PYTHON_USEDEP}]
	dev-python/pyopengl[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/pyquery[${PYTHON_USEDEP}]
	dev-python/webob[${PYTHON_USEDEP}]
	dev-python/pyxdg[${PYTHON_USEDEP}]
	dev-qt/qtwebkit:5
	dev-qt/qtgraphicaleffects:5
	dev-qt/qtquickcontrols:5
	dev-qt/qtmultimedia:5
	app-text/tesseract
	|| (
		app-text/tessdata_fast[l10n_en,l10n_zh]
		app-text/tessdata_best[l10n_en,l10n_zh]
		app-text/tessdata_legacy[l10n_en,l10n_zh]
	)
	${PYTHON_DEPS}
"
BDEPEND=""

S="${WORKDIR}"

src_prepare() {
	use amd64 && { pushd "${P}-${ARCH}" || die ; }
	eapply "${FILESDIR}/${P}-fix-window-center-value.patch"
	eapply "${FILESDIR}/${P}-fix-imp-to-importlib.patch"
	sed -i 's/getargspec/getfullargspec/g' src/app/plugins/youdao/pyquery/pyquery.py || die
	sed -i -e "/PREFIX=/cDEST=${ED%/}\nPREFIX=\$DEST/usr" \
		-e 's/\/etc/$DEST\/etc/g' \
		-e 's/ln -sf $PREFIX/ln -sf \/usr/g' install.sh || die
	default
}

src_install() {
	use amd64 && { pushd "${P}-${ARCH}" || die ; }
	sh install.sh || die "Running install script failed"
	default
}

pkg_postinst() {
	elog
	elog "To make this package work, make sure you have installed the QtWebKit with this patch:"
	elog "https://github.com/Universebenzene/benzene-overlay/blob/master/dev-qt/qtwebkit/files/qtwebkit-5.212.0_pre20200309-position.patch"
	elog "and PyQt5 with webkit USE flag enabled"
	elog
	elog "You can do these as follows:"
	elog
	elog " # echo \"dev-python/pyqt5 -webkit\" >> /etc/portage/profile/package.use.mask"
	elog " # emerge --oneshot qtwebkit::benzene-overlay PyQt5::benzene-overlay"
	elog

	xdg_pkg_postinst
}
