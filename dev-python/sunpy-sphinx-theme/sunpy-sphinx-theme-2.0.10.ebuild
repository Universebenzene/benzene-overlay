# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="The sphinx theme for the SunPy website and documentation"
HOMEPAGE="https://github.com/sunpy/sunpy-sphinx-theme"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test"	# No usable test phases

RDEPEND="dev-python/sphinx[${PYTHON_USEDEP}]
	dev-python/pydata-sphinx-theme[${PYTHON_USEDEP}]
"
BDEPEND=">=dev-python/setuptools-scm-6.2[$PYTHON_USEDEP]"

#distutils_enable_tests nose
