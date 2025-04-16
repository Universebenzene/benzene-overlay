# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 pypi

DESCRIPTION="Documatt Theme for Sphinx documentation projects"
HOMEPAGE="https://documatt.com/sphinx-themes/themes/documatt.html"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test"	# No usable test phases

RDEPEND="dev-python/sphinx[${PYTHON_USEDEP}]"

#distutils_enable_tests nose
