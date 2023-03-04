# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..10} )

inherit distutils-r1

DESCRIPTION="Make scatter matrix corner plots"
HOMEPAGE="https://corner.readthedocs.io"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="arviz"

RDEPEND=">=dev-python/matplotlib-2.1[${PYTHON_USEDEP}]
	arviz? ( >=dev-python/arviz-0.9[${PYTHON_USEDEP}] )"
BDEPEND="dev-python/setuptools-scm[${PYTHON_USEDEP}]"

distutils_enable_tests nose

pkg_postinst() {
	optfeature "optional dependency" dev-python/scipy
}
