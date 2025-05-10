# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 desktop optfeature pypi xdg

DESCRIPTION="A scientific image viewer and toolkit"
HOMEPAGE="https://ejeschke.github.io/ginga"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc gtk intersphinx pyside6 qt5 qt6 recommended tk web"
# Tests phase runs with fails
#RESTRICT="test
#	intersphinx? ( network-sandbox )"
RESTRICT="intersphinx? ( network-sandbox )"
REQUIRED_USE="intersphinx? ( doc )"
#	pyside2? ( || ( $(python_gen_useflags python3_{10,11}) ) )"	# pyside2 about to be dropped

RDEPEND=">=dev-python/numpy-1.26[${PYTHON_USEDEP}]
	>=dev-python/astropy-6.0.1[${PYTHON_USEDEP}]
	>=dev-python/pillow-11.1.0[${PYTHON_USEDEP}]
	>=dev-python/qtpy-2.4.1[${PYTHON_USEDEP}]
	>=dev-python/packaging-23.1[${PYTHON_USEDEP}]
	>=dev-python/puremagic-1.28[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-6.0[${PYTHON_USEDEP}]
	gtk? (
		dev-python/pycairo[${PYTHON_USEDEP}]
		>=dev-python/pygobject-3.48.1[${PYTHON_USEDEP}]
	)
	pyside6? ( dev-python/pyside[${PYTHON_USEDEP}] )
	qt5? ( dev-python/pyqt5[${PYTHON_USEDEP}] )
	qt6? ( dev-python/pyqt6[${PYTHON_USEDEP}] )
	recommended? (
		>=dev-python/astroquery-0.4.7[${PYTHON_USEDEP}]
		>=dev-python/exifread-2.3.2[${PYTHON_USEDEP}]
		>=dev-python/matplotlib-3.8[${PYTHON_USEDEP}]
		>=dev-python/python-dateutil-2.8.2[${PYTHON_USEDEP}]
		>=dev-python/python-magic-0.4.15[${PYTHON_USEDEP}]
		>=dev-python/scipy-1.11.4[${PYTHON_USEDEP}]
		>=media-libs/opencv-4.5.4.58[${PYTHON_USEDEP},python]
		dev-python/photutils[${PYTHON_USEDEP}]
	)
	tk? ( dev-python/pycairo[${PYTHON_USEDEP}] )
	web? (
		dev-python/pycairo[${PYTHON_USEDEP}]
		dev-python/tornado[${PYTHON_USEDEP}]
	)
"
#	$(python_gen_cond_dep '>=dev-python/tomli-2.0.1[${PYTHON_USEDEP}]' python3_10)
#	pyside2? ( $(python_gen_cond_dep 'dev-python/pyside2[${PYTHON_USEDEP}]' python3_{10,11}) )
BDEPEND=">=dev-python/setuptools-scm-7[${PYTHON_USEDEP}]
	doc? (
		${RDEPEND}
		dev-python/sphinx-astropy[${PYTHON_USEDEP}]
		dev-python/sphinx-rtd-theme[${PYTHON_USEDEP}]
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
#		dev-python/starlink-pyast[${PYTHON_USEDEP}]

distutils_enable_tests pytest
#distutils_enable_sphinx doc dev-python/sphinx-astropy dev-python/sphinx-rtd-theme

#python_prepare_all() {
##	use test && { sed -i "/ignore:distutils/a \	ignore:the imp module is deprecated:DeprecationWarning" setup.cfg || die ; }
#
#	distutils-r1_python_prepare_all
#}

python_compile_all() {
	if use doc; then
		VARTEXFONTS="${T}"/fonts MPLCONFIGDIR="${T}" PYTHONPATH="${BUILD_DIR}"/install/$(python_get_sitedir) \
			emake "SPHINXOPTS=$(usex intersphinx '' '-D disable_intersphinx=1')" -C doc html
		HTML_DOCS=( doc/_build/html/. )
	fi
}

python_install_all() {
	distutils-r1_python_prepare_all
	doicon -s scalable ${PN}/icons/${PN}.svg
	domenu ${PN}.desktop
}

pkg_postinst() {
	xdg_pkg_postinst

	optfeature_header "For WCS resolution:"
	optfeature "Use astLib" dev-python/astlib
	optfeature "Use starlink" dev-python/starlink-pyast
}
