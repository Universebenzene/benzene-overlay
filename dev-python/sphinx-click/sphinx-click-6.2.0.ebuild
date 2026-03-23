# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DOCS_BUILDER="sphinx"
DOCS_AUTODOC=0
DOCS_DIR="docs"
DOCS_INITIALIZE_GIT=1

DISTUTILS_USE_PEP517=setuptools
PYPI_VERIFY_REPO=https://github.com/click-contrib/sphinx-click
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 docs pypi

DESCRIPTION="Sphinx plugin to automatically document click-based applications"
HOMEPAGE="https://sphinx-click.readthedocs.io"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-python/sphinx-4.0[${PYTHON_USEDEP}]
	>=dev-python/click-8.0[${PYTHON_USEDEP}]
"
BDEPEND=">=dev-python/setuptools-scm-8[${PYTHON_USEDEP}]
	doc? ( dev-python/reno[${PYTHON_USEDEP}] )
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
#distutils_enable_sphinx docs --no-autodoc
