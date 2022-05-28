# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="Code to handle I/O from/to data in CASA format Resources"
HOMEPAGE="https://casa-formats-io.readthedocs.io"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND=">dev-python/numpy-1.17[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	>=dev-python/astropy-4.0[${PYTHON_USEDEP}]
	>=dev-python/dask-1.0[${PYTHON_USEDEP}]
"
BDEPEND="${DEPEND}
	dev-python/setuptools_scm[${PYTHON_USEDEP}]
	doc? (
		${RDEPEND}
		dev-python/sphinx-automodapi
		dev-python/numpydoc
	)
	test? (
		dev-python/pytest-doctestplus[${PYTHON_USEDEP}]
		dev-python/pytest-openfiles[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
# No module named 'casa_formats_io._casa_chunking'
#distutils_enable_sphinx docs dev-python/sphinx-automodapi dev-python/numpydoc

python_prepare_all() {
	mkdir -p docs/_static || die
	distutils-r1_python_prepare_all
}

python_compile_all() {
	if use doc; then
		pushd docs || die
		VARTEXFONTS="${T}"/fonts MPLCONFIGDIR="${T}" PYTHONPATH="${BUILD_DIR}"/install/$(python_get_sitedir) \
			emake html
		popd || die
		HTML_DOCS=( docs/_build/html/. )
	fi
}

python_test() {
	epytest "${BUILD_DIR}"
}
