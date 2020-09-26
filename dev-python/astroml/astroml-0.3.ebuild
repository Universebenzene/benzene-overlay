# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=no
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 virtualx

MY_PN=astroML
MY_P=${MY_PN}-${PV}

DESCRIPTION="Python Machine Learning library for astronomy"
HOMEPAGE="http://www.astroml.org/"
SRC_URI="mirror://pypi/${PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="python-2"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="examples test"
RESTRICT="!test? ( test )"

RDEPEND=">dev-python/astropy-0.2.5[${PYTHON_USEDEP}]
	>=dev-python/matplotlib-0.99[${PYTHON_USEDEP}]
	>=dev-python/numpy-1.4[${PYTHON_USEDEP}]
	>=dev-python/scipy-0.7[${PYTHON_USEDEP}]
	>=sci-libs/scikits_learn-0.10[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		${RDEPEND}
		dev-python/nose[${PYTHON_USEDEP}]
	)
"

S="${WORKDIR}/${MY_P}"

DOCS=( CHANGES.rst README.rst )

python_test() {
	virtx nosetests --verbose
}

python_install_all() {
	distutils-r1_python_install_all
	insinto /usr/share/doc/${PF}
	use examples && doins -r examples
}
