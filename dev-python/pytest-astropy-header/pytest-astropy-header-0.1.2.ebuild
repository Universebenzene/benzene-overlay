# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..10} )

inherit distutils-r1

DESCRIPTION="Pytest plugin to add diagnostic information to the header of the test output"
HOMEPAGE="https://github.com/astropy/pytest-astropy-header"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RDEPEND=">=dev-python/pytest-2.8[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="test? ( dev-python/astropy[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest
