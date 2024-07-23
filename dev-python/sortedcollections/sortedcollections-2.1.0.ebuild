# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1

DESCRIPTION="Python Sorted Collections Library"
HOMEPAGE="https://grantjenks.com/docs/sortedcollections"
SRC_URI="https://github.com/grantjenks/python-sortedcollections/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/sortedcontainers[${PYTHON_USEDEP}]"

S="${WORKDIR}/python-${P}"

distutils_enable_tests pytest
distutils_enable_sphinx docs

python_prepare_all() {
#	use doc && { sed -i "/language\ = /s/None/'en'/" docs/conf.py || die ; }
	sed -i -e "/--cov/d" tox.ini || die

	distutils-r1_python_prepare_all
}
