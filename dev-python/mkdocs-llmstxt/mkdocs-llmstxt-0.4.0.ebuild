# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DOCS_BUILDER="mkdocs"
DOCS_DEPEND="dev-python/mkdocs-material
	dev-python/mkdocs-coverage
	dev-python/mkdocs-git-revision-date-localized-plugin
	dev-python/mkdocs-minify-plugin
	dev-python/mkdocs-section-index
	dev-python/mkdocstrings-python
	dev-python/markdown-callouts
	dev-python/markdown-exec
"

DISTUTILS_USE_PEP517=pdm-backend
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 docs pypi

DESCRIPTION="MkDocs plugin to generate an /llms.txt file"
HOMEPAGE="https://pawamoy.github.io/mkdocs-llmstxt"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"	# mkdocstrings... no x86

RDEPEND=">=dev-python/beautifulsoup4-4.12[${PYTHON_USEDEP}]
	>=dev-python/markdownify-0.14[${PYTHON_USEDEP}]
	>=dev-python/mdformat-0.7.21[${PYTHON_USEDEP}]
	>=dev-python/mdformat-tables-1.0[${PYTHON_USEDEP}]
"
BDEPEND="test? (
		dev-python/griffe[${PYTHON_USEDEP}]
		dev-python/mkdocstrings[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

python_prepare_all() {
	use doc && { sed -i '$a use_directory_urls: false' mkdocs.yml || die ; }

	distutils-r1_python_prepare_all
}
