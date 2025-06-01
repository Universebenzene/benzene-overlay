# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="Handles redirects for moved pages in Sphinx documentation projects"
HOMEPAGE="https://documatt.com/sphinx-reredirects"
#SRC_URI="https://github.com/documatt/sphinx-reredirects/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
PROPERTIES="test_network"
RESTRICT="test"

RDEPEND=">=dev-python/sphinx-7.4[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/sphinx-copybutton dev-python/sphinx-sitemap \
	dev-python/sphinx-documattcom-theme \
	dev-python/linkify-it-py \
	dev-python/myst-parser
