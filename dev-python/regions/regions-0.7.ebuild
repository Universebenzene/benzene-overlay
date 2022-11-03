# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="Astropy affiliated package for region handling"
HOMEPAGE="http://astropy-regions.readthedocs.io"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz
	doc? ( https://www.astropy.org/astropy-data/tutorials/FITS-images/HorseHead.fits
		https://www.astropy.org/astropy-data/photometry/M6707HH.fits )"

SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="BSD"

IUSE="all doc intersphinx"
RESTRICT="intersphinx? ( network-sandbox )"
REQUIRED_USE="intersphinx? ( doc )"
DEPEND=">=dev-python/numpy-1.18[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	>=dev-python/astropy-5.0[${PYTHON_USEDEP}]
	all? (
		>=dev-python/matplotlib-3.1[${PYTHON_USEDEP}]
		dev-python/shapely[${PYTHON_USEDEP}]
	)
"
BDEPEND="${RDEPEND}
	>=dev-python/cython-0.29.30[${PYTHON_USEDEP}]
	dev-python/extension-helpers[${PYTHON_USEDEP}]
	dev-python/setuptools_scm[${PYTHON_USEDEP}]
	doc? (
		${RDEPEND}
		dev-python/sphinx-astropy[${PYTHON_USEDEP}]
		>=dev-python/matplotlib-3.1[${PYTHON_USEDEP}]
		dev-python/shapely[${PYTHON_USEDEP}]
	)
	test? (
		dev-python/pytest-arraydiff[${PYTHON_USEDEP}]
		dev-python/pytest-astropy-header[${PYTHON_USEDEP}]
		dev-python/pytest-doctestplus[${PYTHON_USEDEP}]
		dev-python/matplotlib[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

python_prepare_all() {
	use doc && { cp "${DISTDIR}"/*.fits* docs/_static || die ; }
	use intersphinx || eapply "${FILESDIR}"/${P}-doc-use-local-fits.patch
	distutils-r1_python_prepare_all
}

python_compile_all() {
	if use doc; then
		pushd docs || die
		VARTEXFONTS="${T}"/fonts MPLCONFIGDIR="${T}" PYTHONPATH="${BUILD_DIR}"/install/$(python_get_sitedir) \
			emake "SPHINXOPTS=$(usex intersphinx '' '-D disable_intersphinx=1')" html
		popd || die
		HTML_DOCS=( docs/_build/html/. )
	fi
}

python_test() {
	epytest "${BUILD_DIR}"
}
