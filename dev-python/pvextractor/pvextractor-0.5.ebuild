# Copyright 2022-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_VERIFY_REPO=https://github.com/radio-astro-tools/pvextractor
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi virtualx

DESCRIPTION="Position-velocity diagram extractor"
HOMEPAGE="http://pvextractor.readthedocs.io"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"	# no x86 KEYWORD for spectral-cube, yt, glueviz
IUSE="doc intersphinx examples"
RESTRICT="intersphinx? ( network-sandbox )"
REQUIRED_USE="intersphinx? ( doc )"

RDEPEND=">=dev-python/numpy-1.24[${PYTHON_USEDEP}]
	>=dev-python/astropy-6.1[${PYTHON_USEDEP}]
	>=dev-python/matplotlib-3.5[${PYTHON_USEDEP}]
	>=dev-python/packaging-19[${PYTHON_USEDEP}]
	>=dev-python/qtpy-2.0[${PYTHON_USEDEP}]
	>=dev-python/radio-beam-0.3.10[${PYTHON_USEDEP}]
	>=dev-python/scipy-1.8[${PYTHON_USEDEP}]
	>=dev-python/setuptools-62.3.3[${PYTHON_USEDEP}]
	>=dev-python/spectral-cube-0.6.7[${PYTHON_USEDEP}]
"
BDEPEND="dev-python/setuptools-scm[${PYTHON_USEDEP}]
	doc? (
		${RDEPEND}
		dev-python/sphinx-astropy[${PYTHON_USEDEP}]
	)
	test? ( dev-python/pyqt6[${PYTHON_USEDEP}] )
"

EPYTEST_PLUGINS=( pytest-{astropy-header,doctestplus} )
distutils_enable_tests pytest
#distutils_enable_sphinx docs dev-python/sphinx-astropy

EPYTEST_IGNORE=(
	# ModuleNotFoundError: No module named 'pyds9'
	scripts/ds9_pvextract.py
)

#python_prepare_all() {
#	use doc && { eapply "${FILESDIR}"/${PN}-0.3-fix-doc-build-warning.patch ; \
#		sed -i -e "/version =/c version = '${pkgver}'" -e "/release =/c release = '${pkgver}'" docs/conf.py || die ; }
#
#	distutils-r1_python_prepare_all
#}

python_compile_all() {
	if use doc; then
		VARTEXFONTS="${T}"/fonts MPLCONFIGDIR="${T}" PYTHONPATH="${BUILD_DIR}"/install/$(python_get_sitedir) \
			emake "SPHINXOPTS=$(usex intersphinx '' '-D disable_intersphinx=1')" -C docs html
		HTML_DOCS=( docs/_build/html/. )
	fi
}

python_install_all() {
	if use examples; then
		docompress -x "/usr/share/doc/${PF}/examples"
		docinto examples
		dodoc -r examples/.
	fi

	distutils-r1_python_install_all
}

python_test() {
	virtx epytest
}
