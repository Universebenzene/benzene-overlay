# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#DISTUTILS_USE_PEP517=setuptools
DISTUTILS_USE_SETUPTOOLS=rdepend
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 pypi

DESCRIPTION="The sphinx theme for Astropy and affiliated packages"
HOMEPAGE="https://github.com/astropy/astropy-sphinx-theme"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RDEPEND=">=dev-python/sphinx-1.6[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
