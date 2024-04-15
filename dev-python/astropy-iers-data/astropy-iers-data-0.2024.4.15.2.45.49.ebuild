# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="IERS Earth Rotation and Leap Second tables for the astropy core package"
HOMEPAGE="https://github.com/astropy/astropy-iers-data"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test"	# No usable test phases

BDEPEND="dev-python/setuptools-scm[${PYTHON_USEDEP}]"

#distutils_enable_tests nose
