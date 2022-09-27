# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..11} )

inherit distutils-r1

DESCRIPTION="Pytest plugin for filtering based on sub-packages"
HOMEPAGE="https://github.com/astropy/pytest-filter-subpackage"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="!test? ( test )"	# Test phase runs with fails
RDEPEND=">=dev-python/pytest-3.0[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="test? ( dev-python/pytest-doctestplus[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest
