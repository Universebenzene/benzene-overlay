# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

GIT_RAW_CI_URI="https://github.com/brandon-rhodes/python-jplephem/raw/${PV}/ci"

inherit distutils-r1 pypi

DESCRIPTION="Python version of NASA DE4xx ephemerides"
HOMEPAGE="https://github.com/brandon-rhodes/python-jplephem"
SRC_URI+=" test? (
		${GIT_RAW_CI_URI}/de405.bsp -> ${P}-t-de405.bsp
		${GIT_RAW_CI_URI}/de421.bsp -> ${P}-t-de421.bsp
		${GIT_RAW_CI_URI}/moon_pa_de421_1900-2050.bpc -> ${P}-t-moon_pa_de421_1900-2050.bpc
	)
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/numpy[${PYTHON_USEDEP}]"

distutils_enable_tests unittest

python_prepare_all() {
	use test && { for ebsp in "${DISTDIR}"/*-t-*; do { cp ${ebsp} "${S}"/${ebsp##*-t-} || die ; } done ; }

	distutils-r1_python_prepare_all
}
