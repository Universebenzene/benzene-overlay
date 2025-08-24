# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{11..13} )

DOCS_BUILDER="mkdocs"
DOCS_DEPEND="dev-python/mkdocs-material"

inherit distutils-r1 docs

DESCRIPTION="MkDocs plugin to allow clickable sections that lead to an index page"
HOMEPAGE="https://oprypin.github.io/mkdocs-section-index"
SRC_URI="https://github.com/oprypin/mkdocs-section-index/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-python/mkdocs-1.2[${PYTHON_USEDEP}]"
BDEPEND="test? (
		dev-python/pytest-golden[${PYTHON_USEDEP}]
		>=dev-python/mechanicalsoup-0.12.0[${PYTHON_USEDEP}]
		>=dev-python/mkdocs-material-6.1.5[${PYTHON_USEDEP}]
		>=dev-python/testfixtures-6.15.0[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
