# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_PN="${PN}-2"
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="An MkDocs plugin to create a list of contributors on the page"
HOMEPAGE="https://github.com/ojacques/mkdocs-git-committers-plugin-2"

LICENSE="BSD"
SLOT="2"
KEYWORDS="~amd64 ~x86"
RESTRICT="test"	# No usable test phases

RDEPEND="dev-python/gitpython[${PYTHON_USEDEP}]
	>=dev-python/mkdocs-1.0.3[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
"

#distutils_enable_tests nose
