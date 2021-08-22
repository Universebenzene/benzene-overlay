# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{7..10} )

inherit distutils-r1

DESCRIPTION="Sphinx extension for generating API documentation"
HOMEPAGE="https://sphinx-automodapi.readthedocs.io"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="!test? ( test )"	# Test phase runs with fails
#RESTRICT="network-sandbox"	# Test will run better, but some will still fail
RDEPEND=">=dev-python/sphinx-1.7[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="test? ( media-gfx/graphviz )"

distutils_enable_tests pytest
