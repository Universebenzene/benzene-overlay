# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1 optfeature

DESCRIPTION="Astropy affiliated package for region handling"
HOMEPAGE="http://astropy-regions.readthedocs.io"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz
	doc? ( https://www.astropy.org/astropy-data/tutorials/FITS-images/HorseHead.fits
		https://www.astropy.org/astropy-data/photometry/M6707HH.fits )"

SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="BSD"

IUSE="doc intersphinx test"
RESTRICT="!test? ( test )
	intersphinx? ( network-sandbox )"
REQUIRED_USE="intersphinx? ( doc )"
RDEPEND=">=dev-python/numpy-1.16[${PYTHON_USEDEP}]
	>=dev-python/astropy-3.2[${PYTHON_USEDEP}]
"
BDEPEND="${RDEPEND}
	dev-python/cython[${PYTHON_USEDEP}]
	dev-python/extension-helpers[${PYTHON_USEDEP}]
	dev-python/setuptools_scm[${PYTHON_USEDEP}]
	doc? (
		${RDEPEND}
		dev-python/sphinx-astropy[${PYTHON_USEDEP}]
		sci-libs/shapely[${PYTHON_USEDEP}]
	)
	test? (
		${RDEPEND}
		dev-python/pytest-astropy[${PYTHON_USEDEP}]
		dev-python/matplotlib[${PYTHON_USEDEP}]
	)
"

python_prepare_all() {
	use doc && { cp "${DISTDIR}"/*.fits* docs/_static || die ; }
	use intersphinx || eapply "${FILESDIR}"/${P}-doc-use-local-fits.patch
	distutils-r1_python_prepare_all
}

python_compile_all() {
	if use doc; then
		pushd docs || die
		VARTEXFONTS="${T}"/fonts MPLCONFIGDIR="${T}" PYTHONPATH="${BUILD_DIR}"/lib \
			emake "SPHINXOPTS=$(usex intersphinx '' '-D disable_intersphinx=1')" html
		popd || die
		HTML_DOCS=( docs/_build/html/. )
	fi
}

python_test() {
	epytest "${BUILD_DIR}/lib"
}

pkg_postinst() {
	optfeature "Plotting support" ">=dev-python/matplotlib-2.0"
	optfeature "Managing geometric objects" "dev-python/shapely"
}
