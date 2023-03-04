# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..11} )

inherit distutils-r1

DESCRIPTION="Pytest plugin used for controlling access to data files hosted online"
HOMEPAGE="https://github.com/astropy/pytest-remotedata"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
PROPERTIES="test_network"
RESTRICT="test"

RDEPEND=">=dev-python/pytest-4.6[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
"
BDEPEND="dev-python/setuptools-scm[${PYTHON_USEDEP}]"

distutils_enable_tests pytest

python_test() {
	epytest --remote-data
}
