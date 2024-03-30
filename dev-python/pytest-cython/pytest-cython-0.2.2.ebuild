# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="A plugin for testing Cython extension modules"
HOMEPAGE="https://github.com/lgpage/pytest-cython"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="<dev-python/pytest-8[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/cython[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/sphinx-py3doc-enhanced-theme dev-python/myst-parser

python_test() {
	epytest tests
}
