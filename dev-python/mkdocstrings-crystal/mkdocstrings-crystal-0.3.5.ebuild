# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{10..11} )

DOCS_BUILDER="mkdocs"
DOCS_DEPEND="dev-python/mkdocstrings-python
	dev-python/mkdocs-pymdownx-material-extras
	dev-python/mkdocs-section-index
	dev-python/markdown-callouts
"

inherit distutils-r1 docs

DESCRIPTION="Crystal language doc generator for mkdocstrings"
HOMEPAGE="https://mkdocstrings.github.io/crystal"
SRC_URI="https://github.com/mkdocstrings/crystal/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"	# mkdocstrings{,-python} no x86
IUSE="examples"

RDEPEND=">=dev-python/cached-property-1.5.2[${PYTHON_USEDEP}]
	>=dev-python/jinja2-2.11.2[${PYTHON_USEDEP}]
	>=dev-python/markdown-callouts-0.1.0[${PYTHON_USEDEP}]
	>=dev-python/markupsafe-1.1.1[${PYTHON_USEDEP}]
	>=dev-python/mkdocs-autorefs-0.2.0[${PYTHON_USEDEP}]
	>=dev-python/mkdocstrings-0.18.0[${PYTHON_USEDEP}]
"
BDEPEND="test? ( dev-python/pytest-golden[${PYTHON_USEDEP}] )"

S="${WORKDIR}/crystal-${PV}"

distutils_enable_tests pytest

python_prepare_all() {
	sed -i '/cached/d' pyproject.toml || die

	distutils-r1_python_prepare_all
}

python_install_all() {
	if use examples; then
		docompress -x "/usr/share/doc/${PF}/examples"
		docinto examples
		dodoc -r examples/.
	fi

	distutils-r1_python_install_all
}
