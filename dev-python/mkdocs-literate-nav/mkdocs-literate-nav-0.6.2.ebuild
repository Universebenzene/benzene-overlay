# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYPI_VERIFY_REPO=https://github.com/oprypin/mkdocs-literate-nav
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="MkDocs plugin to specify the navigation in Markdown instead of YAML"
HOMEPAGE="https://oprypin.github.io/mkdocs-literate-nav"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-python/mkdocs-1.4.1[${PYTHON_USEDEP}]"

EPYTEST_PLUGINS=( pytest-golden )
distutils_enable_tests pytest
