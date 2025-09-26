# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

inherit cmake gnome2-utils python-any-r1 xdg

DESCRIPTION="A Gtk/Qt front-end to tesseract-ocr"
HOMEPAGE="https://github.com/manisandro/gImageReader"
SRC_URI="https://github.com/manisandro/gImageReader/releases/download/v${PV}/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk qt5 qt6 +scanner"
REQUIRED_USE="^^ ( gtk qt5 qt6 )"

DEPEND=">=app-text/tesseract-3.04
	scanner? ( media-gfx/sane-backends )
	app-text/podofo:=
	virtual/jpeg
	app-text/djvu
	dev-libs/libzip
	dev-libs/libxml2
	app-text/enchant:2
	gtk? (
		dev-cpp/gtkmm:3.0
		dev-cpp/gtksourceviewmm:=
		dev-cpp/cairomm:0
		dev-libs/json-glib
		dev-cpp/libxmlpp:2.6
		dev-cpp/gtkspellmm
	)
	qt5? (
		app-text/qtspell[qt5]
		app-text/poppler:=[qt5]
		dev-libs/quazip:=[qt5]
		dev-qt/qtimageformats:5
	)
	qt6? (
		app-text/qtspell[qt6]
		app-text/poppler:=[qt6]
		dev-libs/quazip:=[qt6]
		dev-qt/qtimageformats:6
	)
"
RDEPEND="${DEPEND}"
BDEPEND="gtk? ( $(python_gen_any_dep 'dev-python/pygobject:3[${PYTHON_USEDEP}]') )
	dev-util/intltool
"

python_check_deps() {
	use gtk || return 0
	python_has_version "dev-python/pygobject:3[${PYTHON_USEDEP}]"
}

src_configure() {
	use gtk && local mycmakeargs=( -DINTERFACE_TYPE=gtk )
	use qt5 && local mycmakeargs=( -DINTERFACE_TYPE=qt5 )
	use qt6 && local mycmakeargs=( -DINTERFACE_TYPE=qt6 )
	cmake_src_configure
}

src_install() {
	cmake_src_install
	mv "${ED%/}"/usr/share/doc/{${PN},${PF}} || die
}

pkg_postinst() {
	use gtk && gnome2_schemas_update
	xdg_pkg_postinst
}

pkg_postrm() {
	use gtk && gnome2_schemas_update
	xdg_pkg_postinst
}
