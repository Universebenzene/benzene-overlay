# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..10} )

inherit distutils-r1

DESCRIPTION="Meta-package for glue and plugin packages"
HOMEPAGE="http://glueviz.org"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc"

RDEPEND=">=dev-python/glue-core-1.2.0[${PYTHON_USEDEP},doc?]
	>=dev-python/glue-vispy-viewers-1.0.3[${PYTHON_USEDEP}]
"

distutils_enable_tests nose

python_install_all() {
	use doc && dosym -r /usr/share/doc/glue-core-*/html /usr/share/doc/${PF}/html

	distutils-r1_python_install_all
}
