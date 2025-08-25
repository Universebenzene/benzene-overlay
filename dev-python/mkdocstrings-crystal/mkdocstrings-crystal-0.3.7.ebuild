# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="Crystal language doc generator for mkdocstrings"
HOMEPAGE="https://mkdocstrings.github.io/crystal"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"	# mkdocstrings{,-python} no x86

RDEPEND=">=dev-python/jinja2-2.11.2[${PYTHON_USEDEP}]
	>=dev-python/markdown-callouts-0.1.0[${PYTHON_USEDEP}]
	>=dev-python/markupsafe-1.1.1[${PYTHON_USEDEP}]
	>=dev-python/mkdocs-autorefs-0.3.1[${PYTHON_USEDEP}]
	>=dev-python/mkdocstrings-0.19.0[${PYTHON_USEDEP}]
"
BDEPEND="test? ( dev-python/pytest-golden[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest
