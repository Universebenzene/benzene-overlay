# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
#DISTUTILS_USE_SETUPTOOLS=no
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 pypi

DESCRIPTION="Python version of the SGP4 satellite position library"
HOMEPAGE="https://github.com/brandon-rhodes/python-sgp4"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

BDEPEND="test? ( dev-python/numpy[${PYTHON_USEDEP}] )"

distutils_enable_tests unittest
