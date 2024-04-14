# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYPI_PN=${PN^}
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="Tools for accessing JPEG2000 files"
HOMEPAGE="https://glymur.readthedocs.org"
SRC_URI+=" doc? (
		https://github.com/quintusdias/glymur/raw/v${PV}/docs/source/whatsnew/0.10.rst -> ${P}-d-0.10.rst
		https://github.com/quintusdias/glymur/raw/v${PV}/docs/source/whatsnew/0.11.rst -> ${P}-d-0.11.rst
		https://github.com/quintusdias/glymur/raw/v${PV}/docs/source/whatsnew/0.12.rst -> ${P}-d-0.12.rst
	)
	test? (
		https://github.com/quintusdias/glymur/raw/v${PV}/tests/data/0220000800_uuid.dat -> ${P}-t-0220000800_uuid.dat
		https://github.com/quintusdias/glymur/raw/v${PV}/tests/data/basn6a08.tif -> ${P}-t-basn6a08.tif
		https://github.com/quintusdias/glymur/raw/v${PV}/tests/data/issue549.dat -> ${P}-t-issue549.dat
		https://github.com/quintusdias/glymur/raw/v${PV}/tests/data/issue572.tif -> ${P}-t-issue572.tif
		https://github.com/quintusdias/glymur/raw/v${PV}/tests/data/issue982.j2k -> ${P}-t-issue982.j2k
		https://github.com/quintusdias/glymur/raw/v${PV}/tests/data/uint16.j2k -> ${P}-t-uint16.j2k
		https://raw.githubusercontent.com/quintusdias/glymur/v${PV}/tests/data/issue555.xmp -> ${P}-t-issue555.xmp
	)
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
"
BDEPEND="test? (
		sci-libs/gdal[python]
		dev-python/scikit-image[${PYTHON_USEDEP}]
		media-libs/openjpeg:2
	)
"

distutils_enable_tests pytest
distutils_enable_sphinx docs/source dev-python/numpydoc dev-python/sphinx-rtd-theme

python_prepare_all() {
	use doc && { mkdir docs/source/_static || die ; \
		for dst in "${DISTDIR}"/*-d-*; do { cp ${dst} "${S}"/docs/source/whatsnew/${dst##*-d-} || die ; } ; done ; }
	use test && { for tdata in "${DISTDIR}"/*-t-*; do { cp ${tdata} "${S}"/tests/data/${tdata##*-t-} || die ; } ; done ; }
	distutils-r1_python_prepare_all
}
