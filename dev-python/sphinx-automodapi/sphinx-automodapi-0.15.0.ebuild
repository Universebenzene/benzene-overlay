# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1 pypi

DESCRIPTION="Sphinx extension for generating API documentation"
HOMEPAGE="https://sphinx-automodapi.readthedocs.io"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
PROPERTIES="test_network"
RESTRICT="test"
RDEPEND=">=dev-python/sphinx-2[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="dev-python/setuptools-scm[${PYTHON_USEDEP}]
	test? ( media-gfx/graphviz )"

distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/sphinx-rtd-theme
