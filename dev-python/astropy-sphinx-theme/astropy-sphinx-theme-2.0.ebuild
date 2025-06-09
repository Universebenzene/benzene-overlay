# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="The sphinx theme for Astropy and affiliated packages"
HOMEPAGE="https://github.com/astropy/astropy-sphinx-theme"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RDEPEND=">=dev-python/setuptools-30.3.0[${PYTHON_USEDEP}]"
BDEPEND="dev-python/setuptools-scm[${PYTHON_USEDEP}]
	test? ( dev-python/sphinx[${PYTHON_USEDEP}] )
"

distutils_enable_tests pytest
