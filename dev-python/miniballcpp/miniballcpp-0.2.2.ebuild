# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..11} )

MY_PN=MiniballCpp
MY_P=${MY_PN}-${PV}

inherit distutils-r1

DESCRIPTION="Smallest Enclosing Balls of Points"
HOMEPAGE="https://github.com/weddige/miniball"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

S="${WORKDIR}/${MY_P}"

distutils_enable_tests nose

python_test() {
	pushd "${BUILD_DIR}" || die
	distutils-r1_python_test
	popd || die
}
