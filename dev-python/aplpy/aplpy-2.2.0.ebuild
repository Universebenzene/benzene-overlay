# Copyright 2020-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 optfeature pypi

DESCRIPTION="Astronomical Plotting Library in Python"
HOMEPAGE="https://aplpy.github.com"
SRC_URI+=" doc? ( http://www.astropy.org/astropy-data/l1448/l1448_13co.fits )"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc intersphinx"
RESTRICT="intersphinx? ( network-sandbox )"
REQUIRED_USE="intersphinx? ( doc )"

RDEPEND=">=dev-python/numpy-1.22[${PYTHON_USEDEP}]
	>=dev-python/astropy-5.0[${PYTHON_USEDEP}]
	>=dev-python/matplotlib-3.5[${PYTHON_USEDEP}]
	>=dev-python/reproject-0.9[${PYTHON_USEDEP}]
	>=dev-python/pyregion-2.2[${PYTHON_USEDEP}]
	>=dev-python/pillow-9.0[${PYTHON_USEDEP}]
	>=dev-python/pyavm-0.9.6[${PYTHON_USEDEP}]
	>=dev-python/shapely-2.0[${PYTHON_USEDEP}]
	>=dev-python/scikit-image-0.20[${PYTHON_USEDEP}]
"
BDEPEND="dev-python/setuptools-scm[${PYTHON_USEDEP}]
	doc? (
		${RDEPEND}
		dev-python/sphinx-astropy[${PYTHON_USEDEP}]
	)
	test? (
		dev-python/pytest-astropy-header[${PYTHON_USEDEP}]
		dev-python/pytest-doctestplus[${PYTHON_USEDEP}]
		dev-python/pytest-remotedata[${PYTHON_USEDEP}]
		dev-python/pytest-mpl[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
#distutils_enable_sphinx docs dev-python/sphinx-astropy

python_prepare_all() {
	use doc && { eapply "${FILESDIR}"/${PN}-2.1.0-doc-use-local-fits.patch; \
		cp "${DISTDIR}"/l1448_13co.fits "${S}"/docs/fitsfigure || die ; }
	distutils-r1_python_prepare_all
}

python_compile_all() {
	if use doc; then
		VARTEXFONTS="${T}"/fonts MPLCONFIGDIR="${T}" PYTHONPATH="${BUILD_DIR}"/install/$(python_get_sitedir) \
			emake "SPHINXOPTS=$(usex intersphinx '' '-D disable_intersphinx=1')" -C docs html
		HTML_DOCS=( docs/_build/html/. )
	fi
}

python_test() {
	use doc && local EPYTEST_IGNORE=( docs/_build )
	epytest --remote-data
}
