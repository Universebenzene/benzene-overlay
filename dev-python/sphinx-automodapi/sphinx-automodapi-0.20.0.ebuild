# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="Sphinx extension for generating API documentation"
HOMEPAGE="https://sphinx-automodapi.readthedocs.io"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="rtd"
PROPERTIES="test_network"
RESTRICT="test"
RDEPEND=">=dev-python/sphinx-4[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	rtd? ( dev-python/sphinx-rtd-theme[${PYTHON_USEDEP}] )
"
BDEPEND=">=dev-python/setuptools-scm-8.0.0[${PYTHON_USEDEP}]
	test? (
		dev-python/cython[${PYTHON_USEDEP}]
		media-gfx/graphviz
	)
"

distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/sphinx-rtd-theme
