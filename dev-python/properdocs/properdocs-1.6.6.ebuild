# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
#PYPI_VERIFY_REPO=https://github.com/ProperDocs/properdocs
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 #pypi

DESCRIPTION="Project documentation with Markdown."
HOMEPAGE="https://properdocs.org"
SRC_URI="https://github.com/ProperDocs/properdocs/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND=">=dev-python/click-7.0[${PYTHON_USEDEP}]
	>=dev-python/ghp-import-1.0[${PYTHON_USEDEP}]
	>=dev-python/jinja2-2.11.1[${PYTHON_USEDEP}]
	>=dev-python/markdown-3.3.6[${PYTHON_USEDEP}]
	>=dev-python/markupsafe-2.0.1[${PYTHON_USEDEP}]
	>=dev-python/mergedeep-1.3.4[${PYTHON_USEDEP}]
	>=dev-python/packaging-20.5[${PYTHON_USEDEP}]
	>=dev-python/pathspec-0.11.1[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-5.1[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-env-tag-0.1[${PYTHON_USEDEP}]
	>=dev-python/platformdirs-2.2.0[${PYTHON_USEDEP}]
	>=dev-python/watchdog-2.0[${PYTHON_USEDEP}]
"
BDEPEND="doc? (
		dev-python/mkdocs-autorefs[${PYTHON_USEDEP}]
		dev-python/mkdocs-click[${PYTHON_USEDEP}]
		dev-python/mkdocs-literate-nav[${PYTHON_USEDEP}]
		dev-python/mkdocs-redirects[${PYTHON_USEDEP}]
		dev-python/mkdocstrings-python[${PYTHON_USEDEP}]
		dev-python/markdown-callouts[${PYTHON_USEDEP}]
		dev-python/mdx-gh-links[${PYTHON_USEDEP}]
		dev-python/pymdown-extensions[${PYTHON_USEDEP}]
		dev-python/properdocs-theme-mkdocs[${PYTHON_USEDEP}]
	)
"
PDEPEND="test? (
		dev-python/properdocs-theme-mkdocs[${PYTHON_USEDEP}]
		dev-python/properdocs-theme-readthedocs[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests unittest

python_prepare_all() {
	use doc && { sed -i '$a use_directory_urls: false' properdocs.yml || die ; }
	#use test && { for tpy in $(ls tests/[a-z]*.py); do { mv tests/{,test_}${tpy#tests/} || die ; } ; done ; }
	distutils-r1_python_prepare_all
}

python_compile_all() {
	if use doc; then
		PYTHONPATH="${BUILD_DIR}"/install/$(python_get_sitedir) \
			properdocs build || die
		HTML_DOCS=( site/. )
	fi
}

python_test() {
	eunittest -s ${PN}/tests -p '*.py'
}
