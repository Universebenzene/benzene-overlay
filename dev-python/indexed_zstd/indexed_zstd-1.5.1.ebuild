# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..11} )

inherit distutils-r1

DESCRIPTION="Fast random access to zstd files"
HOMEPAGE="https://github.com/martinellimarco/indexed_zstd"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="app-arch/zstd"
BDEPEND="dev-python/cython[${PYTHON_USEDEP}]"

distutils_enable_tests nose

python_test() {
	pushd "${BUILD_DIR}" || die
	distutils-r1_python_test
	popd || die
}
