# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=pdm-backend
PYTHON_COMPAT=( python3_{10..13} )

DOCS_BUILDER="mkdocs"
DOCS_DEPEND="dev-python/mkdocs-material
	dev-python/mkdocs-git-revision-date-localized-plugin
	dev-python/mkdocs-minify-plugin
	dev-python/mkdocs-coverage
	dev-python/markdown-callouts
	dev-python/markdown-exec
"

inherit distutils-r1 docs pypi

DESCRIPTION="A legacy Python handler for mkdocstrings"
HOMEPAGE="https://mkdocstrings.github.io/python-legacy"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"	# mkdocstrings no x86

RDEPEND=">=dev-python/mkdocstrings-0.19[${PYTHON_USEDEP}]
	>=dev-python/mkdocs-autorefs-1.1[${PYTHON_USEDEP}]
	>=dev-python/pytkdocs-0.14[${PYTHON_USEDEP}]
	!dev-python/mkdocstrings-python
"
BDEPEND="test? ( dev-python/mkdocs-material[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

python_prepare_all() {
	use doc && { sed -i '$a use_directory_urls: false' mkdocs.yml || die ; }

	distutils-r1_python_prepare_all
}
