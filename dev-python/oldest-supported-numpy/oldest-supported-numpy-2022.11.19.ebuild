# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..11} )

inherit distutils-r1

DESCRIPTION="Meta-package providing oldest supported Numpy for given Python version"
HOMEPAGE="https://github.com/scipy/oldest-supported-numpy"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/numpy[${PYTHON_USEDEP}]"

#distutils_enable_tests nose

python_prepare() {
	sed -i "/${EPYTHON#python}/s/==/>=/" setup.cfg || die
}
