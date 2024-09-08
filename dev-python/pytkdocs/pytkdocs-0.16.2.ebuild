# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=pdm-backend
PYTHON_COMPAT=( python3_{10..13} )

DOCS_BUILDER="mkdocs"
DOCS_DEPEND="dev-python/mkdocs-material
	dev-python/mkdocs-gen-files
	dev-python/mkdocs-literate-nav
	dev-python/mkdocs-coverage
	dev-python/mkdocstrings-python
	dev-python/markdown-callouts
	dev-python/markdown-exec
"

inherit distutils-r1 docs pypi

DESCRIPTION="Load Python objects documentation"
HOMEPAGE="https://github.com/mkdocstrings/autorefs"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="numpy-style"

RDEPEND="numpy-style? ( >=dev-python/docstring-parser-0.7[${PYTHON_USEDEP}] )
	$(python_gen_cond_dep '>=dev-python/astonparse-1.6[${PYTHON_USEDEP}]' python3_{7..9})
	$(python_gen_cond_dep '>=dev-python/cached-property-1.5[${PYTHON_USEDEP}]' python3_{7..8})
	$(python_gen_cond_dep '>=dev-python/typing-extensions-3.7[${PYTHON_USEDEP}]' python3_{7..8})
"
BDEPEND="test? (
		>=dev-python/django-3.2[${PYTHON_USEDEP}]
		>=dev-python/docstring-parser-0.7[${PYTHON_USEDEP}]
		>=dev-python/marshmallow-3.13[${PYTHON_USEDEP}]
		>=dev-python/pydantic-1.8[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

python_prepare_all() {
	use doc && { sed -i '$a use_directory_urls: false' mkdocs.yml || die ; }

	distutils-r1_python_prepare_all
}
