# Copyright 2020-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

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

RDEPEND="dev-python/numpy[${PYTHON_USEDEP}]
	>=dev-python/astropy-3.1[${PYTHON_USEDEP}]
	>=dev-python/matplotlib-2.0[${PYTHON_USEDEP}]
	>=dev-python/reproject-0.4[${PYTHON_USEDEP}]
	>=dev-python/pyregion-2.0[${PYTHON_USEDEP}]
	>=dev-python/pillow-4.3[${PYTHON_USEDEP}]
	>=dev-python/pyavm-0.9.4[${PYTHON_USEDEP}]
	>=dev-python/shapely-1.7[${PYTHON_USEDEP}]
	>=dev-python/scikit-image-0.14[${PYTHON_USEDEP}]
"
BDEPEND="dev-python/setuptools-scm[${PYTHON_USEDEP}]
	doc? (
		${RDEPEND}
		dev-python/sphinx-astropy[${PYTHON_USEDEP}]
	)
	test? (
		dev-python/pytest-doctestplus[${PYTHON_USEDEP}]
		dev-python/pytest-remotedata[${PYTHON_USEDEP}]
		dev-python/pytest-mpl[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
#distutils_enable_sphinx docs dev-python/sphinx-astropy

python_prepare_all() {
	use doc && { eapply "${FILESDIR}"/${P}-doc-use-local-fits.patch; \
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
	epytest --remote-data
}

pkg_postinst() {
	optfeature "enhance the functionality" "dev-python/montage-wrapper sci-astronomy/montage"
}
