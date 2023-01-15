# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{9..11} )

MY_PN=${PN/-/.}
MY_P=${MY_PN}-${PV}

inherit distutils-r1

DESCRIPTION="Extension to include jQuery on newer Sphinx releases"
HOMEPAGE="https://github.com/sphinx-contrib/jquery"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="0BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/sphinx[${PYTHON_USEDEP}]
"

S="${WORKDIR}/${MY_P}"

distutils_enable_tests nose
