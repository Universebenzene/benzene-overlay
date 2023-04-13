# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{9..11} )

inherit distutils-r1 pypi

DESCRIPTION="A sphinx extension for designing beautiful, view size responsive web components"
HOMEPAGE="https://sphinx-design.readthedocs.io"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test"	# Test phase runs with fails

RDEPEND="<dev-python/sphinx-6[${PYTHON_USEDEP}]"

distutils_enable_tests nose
