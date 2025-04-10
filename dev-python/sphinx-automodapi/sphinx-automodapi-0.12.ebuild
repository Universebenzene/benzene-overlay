# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 pypi

DESCRIPTION="Sphinx extension for generating API documentation"
HOMEPAGE="https://sphinx-automodapi.readthedocs.io"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
RDEPEND=">=dev-python/sphinx-1.7[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="doc? ( dev-python/sphinx-rtd-theme[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest
distutils_enable_sphinx docs --no-autodoc
