# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..11} )

inherit distutils-r1

DESCRIPTION="Fast kd-tree implementation with OpenMP-enabled queries"
HOMEPAGE="https://github.com/storpipfugl/pykdtree"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-python/numpy[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

distutils_enable_tests pytest

python_test() {
	epytest "${BUILD_DIR}"
}
