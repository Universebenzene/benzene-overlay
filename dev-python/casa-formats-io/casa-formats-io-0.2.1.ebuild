# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..10} )

inherit distutils-r1

DESCRIPTION="Code to handle I/O from/to data in CASA format Resources"
HOMEPAGE="https://casa-formats-io.readthedocs.io"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"	# no x86 KEYWORD for glue-core, spectral-cube

DEPEND=">=dev-python/numpy-1.17[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	>=dev-python/astropy-4.0[${PYTHON_USEDEP}]
	>=dev-python/dask-2.0[${PYTHON_USEDEP}]
"
BDEPEND="${DEPEND}
	dev-python/setuptools-scm[${PYTHON_USEDEP}]
	test? ( dev-python/pytest-openfiles[${PYTHON_USEDEP}] )
"
PDEPEND="test? ( dev-python/glue-core[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/sphinx-automodapi dev-python/numpydoc

python_prepare_all() {
	use doc && { sed -i "/casa_io_formats.image_to_dask/s/_io_formats/_formats_io/" docs/index.rst || die ; }

	distutils-r1_python_prepare_all
}

python_compile_all() {
	use doc && { cp "${BUILD_DIR}"/install/$(python_get_sitedir)/${PN//-/_}/*casa*.so "${S}/${PN//-/_}" || die ; }

	sphinx_compile_all
}

python_test() {
	epytest "${BUILD_DIR}"
}
