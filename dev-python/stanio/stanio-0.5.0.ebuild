# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

DESCRIPTION="Preparing inputs to and reading outputs from Stan"
HOMEPAGE="https://github.com/WardBrian/stanio"
SRC_URI="https://github.com/WardBrian/stanio/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz "

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ujson"

RDEPEND="dev-python/numpy[${PYTHON_USEDEP}]
	ujson? ( >=dev-python/ujson-5.5.0[${PYTHON_USEDEP}] )
"
BDEPEND="test? ( dev-python/pandas[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest
