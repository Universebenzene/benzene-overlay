# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
MY_PN="${PN/dm-}"
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="Tree is a library for working with nested data structures."
HOMEPAGE="https://tree.readthedocs.io"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="!dev-python/dm-tree-bin
	>=dev-python/absl-py-0.6.1[${PYTHON_USEDEP}]
	>=dev-python/attrs-18.2.0[${PYTHON_USEDEP}]
	>=dev-python/numpy-1.21.2[${PYTHON_USEDEP}]
	>=dev-python/wrapt-1.11.2[${PYTHON_USEDEP}]
"
BDEPEND="dev-build/cmake
	dev-cpp/abseil-cpp
	dev-python/pybind11[${PYTHON_USEDEP}]
"

# Encouraged by debian
PATCHES=( "${FILESDIR}/${P}-Simplify-setup.py-by-using-pybind11.setup_helpers.Py.patch" )

distutils_enable_tests pytest

python_test() {
	# cannot import name '_tree' from partially initialized module 'tree'
	[[ -d ${MY_PN} ]] && { mv {,_}${MY_PN} || die ; }
	epytest
	[[ -d _${MY_PN} ]] && { mv {_,}${MY_PN} || die ; }
}
