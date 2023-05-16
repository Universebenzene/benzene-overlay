# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{10..11} )

DOCS_BUILDER="mkdocs"
DOCS_DEPEND="dev-python/mkdocs-pymdownx-material-extras"

inherit distutils-r1 docs

DESCRIPTION="Markdown extension: a classier syntax for admonitions"
HOMEPAGE="https://oprypin.github.io/markdown-callouts"
SRC_URI="https://github.com/oprypin/markdown-callouts/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test"	# Test phase runs with fails

RDEPEND=">=dev-python/markdown-3.3.3[${PYTHON_USEDEP}]"
BDEPEND="test? (
		dev-python/pytest-golden[${PYTHON_USEDEP}]
		dev-python/beautifulsoup4[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

python_compile_all() {
	VARTEXFONTS="${T}"/fonts MPLCONFIGDIR="${T}" PYTHONPATH="${BUILD_DIR}"/install/$(python_get_sitedir) \
		docs_compile
}
