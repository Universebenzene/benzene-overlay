# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{8..10} )

MY_PN="${PN//-/_}"
MY_PV="$(ver_cut 1-3)b$(ver_cut 5)"
MY_P="${MY_PN}-${MY_PV}"

inherit distutils-r1

DESCRIPTION="Add inline tabbed content to your Sphinx documentation"
HOMEPAGE="https://sphinx-inline-tabs.readthedocs.io"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-python/sphinx-3[${PYTHON_USEDEP}]"

distutils_enable_tests nose
distutils_enable_sphinx docs dev-python/furo dev-python/myst_parser

S="${WORKDIR}/${MY_P}"

#python_prepare_all() {
#	use doc && { sed -i -e "/\"pypi\"/s/\"\"/\"\%s\"/" doc/conf.py || die ; }
#	distutils-r1_python_prepare_all
#}
