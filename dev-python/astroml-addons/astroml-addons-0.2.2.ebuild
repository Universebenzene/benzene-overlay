# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=no
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

MY_PN=astroML_addons
MY_P=${MY_PN}-${PV}

DESCRIPTION="Performance add-ons for the astroML package"
HOMEPAGE="https://github.com/astroML/astroML_addons"
SRC_URI="mirror://pypi/${PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="<dev-python/astroml-0.4[${PYTHON_USEDEP}]"
DEPEND="dev-python/numpy[${PYTHON_USEDEP}]"

S="${WORKDIR}/${MY_P}"
