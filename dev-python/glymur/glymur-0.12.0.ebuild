# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..11} )

inherit distutils-r1

MY_PN=${PN^}
MY_P=${MY_PN}-${PV}

DESCRIPTION="Tools for accessing JPEG2000 files"
HOMEPAGE="https://glymur.readthedocs.org"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz
	doc? (
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
		sci-libs/scikit-image[${PYTHON_USEDEP}]
		media-libs/openjpeg:2
	)
"

S="${WORKDIR}/${MY_P}"

distutils_enable_tests pytest
distutils_enable_sphinx docs/source dev-python/numpydoc dev-python/sphinx_rtd_theme

python_prepare_all() {
	use doc && { for dst in "${DISTDIR}"/*-d-*; do { cp ${dst} "${S}"/docs/source/whatsnew/${dst##*-d-} || die ; } ; done ; \
		mkdir docs/source/_static || die ; }
	use test && { for tdata in "${DISTDIR}"/*-t-*; do { cp ${tdata} "${S}"/tests/data/${tdata##*-t-} || die ; } ; done ; }
	distutils-r1_python_prepare_all
}
