# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="Python based tools for spherical geometry"
HOMEPAGE="https://spherical-geometry.readthedocs.io"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+wcs"

DEPEND=">=dev-python/numpy-2.0.0:=[${PYTHON_USEDEP}]
	>=sci-libs/qd-2.3.24
"
RDEPEND="${DEPEND}
	wcs? ( >=dev-python/astropy-5.2.0[${PYTHON_USEDEP}] )
"
BDEPEND="test? ( dev-python/gwcs[${PYTHON_USEDEP}] )"

PATCHES=( "${FILESDIR}/${P}-fix-readme-typo.patch" )

EPYTEST_PLUGINS=( pytest-astropy-header )
distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/sphinx-automodapi dev-python/numpydoc

python_configure_all() {
	export USE_SYSTEM_QD=1
}

python_test() {
	# math_util C-ext is missing
	[[ -d ${PN//-/_} ]] && { mv {,_}${PN//-/_} || die ; }
	epytest
	[[ -d _${PN//-/_} ]] && { mv {_,}${PN//-/_} || die ; }
}
