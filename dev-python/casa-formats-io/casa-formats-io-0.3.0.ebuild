# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="Code to handle I/O from/to data in CASA format Resources"
HOMEPAGE="https://casa-formats-io.readthedocs.io"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"	# no x86 KEYWORD for glue-core, spectral-cube

DEPEND=">=dev-python/numpy-1.21[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	>=dev-python/astropy-4.0[${PYTHON_USEDEP}]
	>=dev-python/dask-2.0[${PYTHON_USEDEP}]
"
BDEPEND="${DEPEND}
	dev-python/setuptools-scm[${PYTHON_USEDEP}]
"
PDEPEND="test? ( dev-python/glue-core[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/sphinx-automodapi dev-python/numpydoc

python_prepare_all() {
	use doc && { sed -i "/casa_io_formats.image_to_dask/s/_io_formats/_formats_io/" docs/index.rst || die ; }

	distutils-r1_python_prepare_all
}

python_compile_all() {
#	No module named 'casa_formats_io._casa_chunking'
	use doc && [[ -d ${PN//-/_} ]] && { mv {,_}${PN//-/_} || die ; }
	sphinx_compile_all
	[[ -d _${PN//-/_} ]] && { mv {_,}${PN//-/_} || die ; }
}

python_test() {
	epytest "${BUILD_DIR}"
}
