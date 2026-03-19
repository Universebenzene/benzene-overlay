# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="'readthedocs' theme for ProperDocs, originally made for MkDocs"
HOMEPAGE="https://pypi.org/project/properdocs-theme-mkdocs"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/properdocs[${PYTHON_USEDEP}]
	dev-python/babel[${PYTHON_USEDEP}]
"
BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

distutils_enable_tests import-check
