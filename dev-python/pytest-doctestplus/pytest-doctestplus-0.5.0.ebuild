# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_{5,6,7,8} )

inherit distutils-r1

DESCRIPTION="Pytest plugin that provides advanced features for testing example code in documentation"
HOMEPAGE="https://github.com/astropy/pytest-doctestplus"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""
RDEPEND=">=dev-python/pytest-3.0[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
BDEPEND="dev-python/setuptools[$PYTHON_USEDEP]"

#distutils_enable_tests setup.py
distutils_enable_tests pytest
