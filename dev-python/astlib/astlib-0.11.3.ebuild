# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=no
PYTHON_COMPAT=( python{2_7,3_{5,6,7,8}} )

inherit distutils-r1

MY_PN=astLib
MY_P=${MY_PN}-${PV}

DESCRIPTION="Python astronomy modules for image and coordinate manipulation"
HOMEPAGE="http://astlib.sourceforge.net/"
SRC_URI="mirror://pypi/${PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
LICENSE="GPL-2 LGPL-2.1"

IUSE="doc examples"

PATCHES=( "${FILESDIR}/${P}-system-wcstools.patch" )

DEPEND="sci-astronomy/wcstools"
RDEPEND="${DEPEND}
	dev-python/astropy[${PYTHON_USEDEP}]
	dev-python/matplotlib[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	>=sci-libs/scipy-0.18.1[${PYTHON_USEDEP}]
"
BEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	dev-lang/swig
"

S="${WORKDIR}/${MY_P}"

python_install_all() {
	dodoc CHANGE_LOG
	use doc && HTML_DOCS=( docs/${MY_PN}/. )
	insinto /usr/share/doc/${PF}
	use examples && doins -r examples
	distutils-r1_python_install_all
}
