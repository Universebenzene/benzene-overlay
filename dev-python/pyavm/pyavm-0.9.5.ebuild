# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1 pypi

MY_PN=PyAVM
MY_P=${MY_PN}-${PV}

DESCRIPTION="Simple pure-python AVM meta-data handling"
HOMEPAGE="http://astrofrog.github.io/pyavm"
SRC_URI="$(pypi_sdist_url --no-normalize ${MY_PN})"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/astropy[${PYTHON_USEDEP}]
	>=dev-python/numpy-1.10[${PYTHON_USEDEP}]
"
BDEPEND="test? ( dev-python/pillow[${PYTHON_USEDEP}] )"

S="${WORKDIR}/${MY_P}"

distutils_enable_tests pytest
