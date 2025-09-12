# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DOCS_BUILDER="mkdocs"
DOCS_DEPEND="dev-python/mkdocs-material
	dev-python/mkdocs-git-revision-date-localized-plugin
	dev-python/mkdocs-llmstxt
	dev-python/mkdocs-minify-plugin
	dev-python/mkdocs-section-index
	dev-python/mkdocstrings-python
	dev-python/markdown-callouts
	dev-python/markdown-exec
"

DISTUTILS_USE_PEP517=pdm-backend
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 docs pypi

DESCRIPTION="MkDocs plugin to integrate your coverage HTML report into your site"
HOMEPAGE="https://pawamoy.github.io/mkdocs-coverage"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"	# mkdocstrings... no x86

RDEPEND=">=dev-python/mkdocs-1.6[${PYTHON_USEDEP}]"
BDEPEND="test? (
		dev-python/markdown-callouts[${PYTHON_USEDEP}]
		dev-python/markdown-exec[${PYTHON_USEDEP}]
		dev-python/mkdocs-material[${PYTHON_USEDEP}]
		dev-python/mkdocs-git-revision-date-localized-plugin[${PYTHON_USEDEP}]
		dev-python/mkdocs-llmstxt[${PYTHON_USEDEP}]
		dev-python/mkdocs-minify-plugin[${PYTHON_USEDEP}]
		dev-python/mkdocs-section-index[${PYTHON_USEDEP}]
		dev-python/mkdocstrings-python[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

python_prepare_all() {
	use doc && { sed -i '$a use_directory_urls: false' mkdocs.yml || die ; }

	distutils-r1_python_prepare_all
}
