# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 pypi

DESCRIPTION="Automatic links from code examples to reference documentation"
HOMEPAGE="https://sphinx-codeautolink.readthedocs.io"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ipython"
PROPERTIES="test_network"
RESTRICT="test"

RDEPEND=">=dev-python/sphinx-3.2.0[${PYTHON_USEDEP}]
	>=dev-python/beautifulsoup4-4.8.1[${PYTHON_USEDEP}]
	ipython? ( >dev-python/ipython-8.7.0[${PYTHON_USEDEP}] )
"
BDEPEND="test? ( dev-python/ipython[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest
distutils_enable_sphinx docs/src dev-python/sphinx-rtd-theme dev-python/ipython dev-python/matplotlib
