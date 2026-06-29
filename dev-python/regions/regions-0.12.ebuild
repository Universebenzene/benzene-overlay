# Copyright 2020-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYPI_VERIFY_REPO=https://github.com/astropy/regions
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="Astropy affiliated package for region handling"
HOMEPAGE="http://astropy-regions.readthedocs.io"
SRC_URI+=" doc? ( https://www.astropy.org/astropy-data/tutorials/FITS-images/HorseHead.fits
		https://www.astropy.org/astropy-data/allsky/allsky_rosat.fits
		https://www.astropy.org/astropy-data/photometry/M6707HH.fits )"

SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="BSD"

IUSE="all doc intersphinx"
PROPERTIES="test_network"
RESTRICT="test
	intersphinx? ( network-sandbox )"
REQUIRED_USE="intersphinx? ( doc )"
DEPEND=">=dev-python/numpy-2.0:=[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	>=dev-python/astropy-6.1.7[${PYTHON_USEDEP}]
	all? (
		>=dev-python/matplotlib-3.9[${PYTHON_USEDEP}]
		>=dev-python/shapely-2.1[${PYTHON_USEDEP}]
	)
"
BDEPEND="${RDEPEND}
	>=dev-python/cython-3.1.2[${PYTHON_USEDEP}]
	>=dev-python/extension-helpers-1.3[${PYTHON_USEDEP}]
	>=dev-python/setuptools-scm-8.2[${PYTHON_USEDEP}]
	doc? (
		${RDEPEND}
		>=dev-python/sphinx-astropy-1.9[${PYTHON_USEDEP},confv2]
		>=dev-python/sphinx-design-0.6[${PYTHON_USEDEP}]
		>=dev-python/matplotlib-3.9[${PYTHON_USEDEP}]
		dev-python/shapely[${PYTHON_USEDEP}]
		media-gfx/graphviz
	)
	test? (
		dev-python/gwcs[${PYTHON_USEDEP}]
		dev-python/matplotlib[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=( pytest-{astropy-header,doctestplus,remotedata} )
distutils_enable_tests pytest

python_prepare_all() {
	use doc && { cp "${DISTDIR}"/*.fits* docs/_static || die ; }
	use intersphinx || eapply "${FILESDIR}"/${P}-doc-use-local-fits.patch
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
	epytest "${BUILD_DIR}" --remote-data
}
