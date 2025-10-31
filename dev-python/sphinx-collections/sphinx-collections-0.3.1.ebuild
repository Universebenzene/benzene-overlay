# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1

DESCRIPTION="Sphinx extension for collecting external data for Sphinx build"
HOMEPAGE="https://sphinxcontrib-youtube.readthedocs.io"
SRC_URI="https://github.com/useblocks/sphinx-collections/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-python/sphinx-4.0[${PYTHON_USEDEP}]
	>=dev-python/gitpython-3.1[${PYTHON_USEDEP}]
	>=dev-python/jinja2-3.0[${PYTHON_USEDEP}]
	>=dev-python/packaging-20.0[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
EPYTEST_XDIST=1
distutils_enable_tests pytest
distutils_enable_sphinx docs
