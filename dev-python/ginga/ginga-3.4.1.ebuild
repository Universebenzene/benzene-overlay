# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1 desktop xdg

DESCRIPTION="A scientific image viewer and toolkit"
HOMEPAGE="https://ejeschke.github.io/ginga"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc gtk3 intersphinx qt5 recommended tk web"
RESTRICT="intersphinx? ( network-sandbox )"
REQUIRED_USE="intersphinx? ( doc )"

RDEPEND=">=dev-python/numpy-1.14[${PYTHON_USEDEP}]
	>=dev-python/astropy-3.2[${PYTHON_USEDEP}]
	>=dev-python/pillow-6.2.1[${PYTHON_USEDEP}]
	>=dev-python/QtPy-2.0.1[${PYTHON_USEDEP}]
	gtk3? (
		dev-python/pycairo[${PYTHON_USEDEP}]
		dev-python/pygobject[${PYTHON_USEDEP}]
	)
	qt5? ( dev-python/PyQt5[${PYTHON_USEDEP}] )
	recommended? (
		>=dev-python/astroquery-0.3.5[${PYTHON_USEDEP}]
		>=dev-python/beautifulsoup4-4.3.2[${PYTHON_USEDEP}]
		dev-python/docutils[${PYTHON_USEDEP}]
		>=dev-python/exifread-2.3.2[${PYTHON_USEDEP}]
		>=dev-python/matplotlib-2.1[${PYTHON_USEDEP}]
		>=dev-python/python-magic-0.4.15[${PYTHON_USEDEP}]
		>=dev-python/scipy-0.18.1[${PYTHON_USEDEP}]
		>=media-libs/opencv-4.5.4.58[${PYTHON_USEDEP},python]
		dev-python/photutils[${PYTHON_USEDEP}]
	)
	tk? ( dev-python/aggdraw[${PYTHON_USEDEP}] )
	web? ( dev-python/tornado[${PYTHON_USEDEP}] )
"
BDEPEND="dev-python/setuptools_scm[${PYTHON_USEDEP}]
	doc? (
		${RDEPEND}
		dev-python/sphinx-astropy[${PYTHON_USEDEP}]
		dev-python/sphinx_rtd_theme[${PYTHON_USEDEP}]
		media-gfx/graphviz
	)
	test? (
		dev-python/pytest-astropy-header[${PYTHON_USEDEP}]
		dev-python/photutils[${PYTHON_USEDEP}]
		>dev-python/regions-0.5[${PYTHON_USEDEP}]
		dev-python/scipy[${PYTHON_USEDEP}]
		dev-python/astlib[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
#distutils_enable_sphinx doc dev-python/sphinx-astropy dev-python/sphinx_rtd_theme

python_prepare_all() {
	sed -i "/Exec/a Icon=ginga" ${PN}.desktop || die
#	use test && { sed -i "/ignore:distutils/a \	ignore:the imp module is deprecated:DeprecationWarning" setup.cfg || die ; }

	distutils-r1_python_prepare_all
}

python_compile_all() {
	if use doc; then
		pushd doc || die
		VARTEXFONTS="${T}"/fonts MPLCONFIGDIR="${T}" PYTHONPATH="${BUILD_DIR}"/install/$(python_get_sitedir) \
			emake "SPHINXOPTS=$(usex intersphinx '' '-D disable_intersphinx=1')" html
		popd || die
		HTML_DOCS=( doc/_build/html/. )
	fi
}

python_install_all() {
	distutils-r1_python_prepare_all
	newicon -s 512 ${PN}/icons/${PN}-512x512.png ${PN}.png
	domenu ${PN}.desktop
}
