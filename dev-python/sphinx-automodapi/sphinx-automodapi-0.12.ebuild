# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9..11} )

inherit distutils-r1

DESCRIPTION="Sphinx extension for generating API documentation"
HOMEPAGE="https://sphinx-automodapi.readthedocs.io"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
RDEPEND=">=dev-python/sphinx-1.7[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="doc? ( dev-python/sphinx-rtd-theme[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest
distutils_enable_sphinx docs --no-autodoc
