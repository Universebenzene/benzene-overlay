# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

DESCRIPTION="A sphinx extension for designing beautiful, view size responsive web components"
HOMEPAGE="https://sphinx-design.readthedocs.io"
SRC_URI="https://github.com/executablebooks/sphinx-design/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="code-style rtd theme-furo theme-pydata theme-rtd theme-sbt"

RDEPEND="<dev-python/sphinx-8[${PYTHON_USEDEP}]
	code-style? ( dev-vcs/pre-commit )
	rtd? ( <dev-python/myst-parser-3[${PYTHON_USEDEP}] )
	theme-furo? ( >=dev-python/furo-2022.06.04[${PYTHON_USEDEP}] )
	theme-pydata? ( dev-python/pydata-sphinx-theme[${PYTHON_USEDEP}] )
	theme-rtd? ( dev-python/sphinx-rtd-theme[${PYTHON_USEDEP}] )
	theme-sbt? ( dev-python/sphinx-book-theme[${PYTHON_USEDEP}] )
"
BDEPEND="test? (
		dev-python/pytest-regressions[${PYTHON_USEDEP}]
		dev-python/myst-parser[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/myst-parser
