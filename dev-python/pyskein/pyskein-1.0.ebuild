# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
#DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{{10..13},13t} )

inherit distutils-r1 pypi

DESCRIPTION="Implementation of the Skein hash function"
HOMEPAGE="https://pythonhosted.org/pyskein"

SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="GPL-3"
IUSE="doc"
RESTRICT="test"	# Test phase runs with fails

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# Fatal Python error: Segmentation fault
	test/test_compare_pure.py::TestSkein::testTree
	test/test_skein.py::TestSkein1024Tree::testCopy
	test/test_skein.py::TestSkein1024Tree::testPickle
)

python_install_all() {
	use doc && HTML_DOCS=( doc/. )

	distutils-r1_python_install_all
}
