# Copyright 2020-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="Astropy affiliated package for region handling"
HOMEPAGE="http://astropy-regions.readthedocs.io"
SRC_URI+=" doc? ( https://www.astropy.org/astropy-data/tutorials/FITS-images/HorseHead.fits
		https://www.astropy.org/astropy-data/photometry/M6707HH.fits )"

SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="BSD"

IUSE="all doc intersphinx"
RESTRICT="intersphinx? ( network-sandbox )"
REQUIRED_USE="intersphinx? ( doc )"
DEPEND=">=dev-python/numpy-1.23[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	>=dev-python/astropy-5.1[${PYTHON_USEDEP}]
	all? (
		>=dev-python/matplotlib-3.5[${PYTHON_USEDEP}]
		dev-python/shapely[${PYTHON_USEDEP}]
	)
"
BDEPEND="${RDEPEND}
	>=dev-python/cython-3.0.0[${PYTHON_USEDEP}]
	<dev-python/cython-3.1.0[${PYTHON_USEDEP}]
	dev-python/extension-helpers[${PYTHON_USEDEP}]
	>=dev-python/setuptools-scm-6.2[${PYTHON_USEDEP}]
	doc? (
		${RDEPEND}
		>=dev-python/sphinx-astropy-1.9[${PYTHON_USEDEP}]
		>=dev-python/matplotlib-3.5[${PYTHON_USEDEP}]
		dev-python/shapely[${PYTHON_USEDEP}]
	)
	test? (
		dev-python/pytest-astropy-header[${PYTHON_USEDEP}]
		dev-python/pytest-doctestplus[${PYTHON_USEDEP}]
		dev-python/pytest-remotedata[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

python_prepare_all() {
	use doc && { cp "${DISTDIR}"/*.fits* docs/_static || die ; }
	use intersphinx || eapply "${FILESDIR}"/${PN}-0.8-doc-use-local-fits.patch
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
	epytest "${BUILD_DIR}"
}
