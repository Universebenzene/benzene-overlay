# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

MY_PN=${PN^}
MY_P=${MY_PN}-${PV}

DESCRIPTION="Tools for accessing JPEG2000 files"
HOMEPAGE="https://glymur.readthedocs.org"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test"	# 1 test failed

RDEPEND="dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
"

BDEPEND="test? (
		sci-libs/gdal[python,${PYTHON_USEDEP}]
		sci-libs/scikit-image[${PYTHON_USEDEP}]
	)
"

S="${WORKDIR}/${MY_P}"

distutils_enable_tests pytest
distutils_enable_sphinx docs/source dev-python/numpydoc dev-python/sphinx_rtd_theme

python_prepare_all() {
	mkdir docs/source/_static || die
	distutils-r1_python_prepare_all
}

python_install() {
	rm -r "${BUILD_DIR}"/lib/tests || die
	distutils-r1_python_install
}
