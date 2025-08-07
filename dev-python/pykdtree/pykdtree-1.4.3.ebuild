# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="Fast kd-tree implementation with OpenMP-enabled queries"
HOMEPAGE="https://github.com/storpipfugl/pykdtree"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=">=dev-python/numpy-2.0.0[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
BDEPEND=">=dev-python/cython-3.1[${PYTHON_USEDEP}]
	test? ( dev-python/mypy[${PYTHON_USEDEP}] )
"

distutils_enable_tests pytest

python_test() {
	epytest "${BUILD_DIR}"
}
