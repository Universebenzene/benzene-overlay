# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_SETUPTOOLS=no
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="Elegant astronomy for Python"
HOMEPAGE="https://github.com/skyfielders/python-skyfield"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz
	test? (
		https://ssd.jpl.nasa.gov/ftp/eph/planets/bsp/de405.bsp
		https://ssd.jpl.nasa.gov/ftp/eph/planets/bsp/de421.bsp
		https://naif.jpl.nasa.gov/pub/naif/generic_kernels/fk/satellites/moon_080317.tf
		https://raw.githubusercontent.com/skyfielders/python-skyfield/master/ci/finals2000A.all
		https://naif.jpl.nasa.gov/pub/naif/generic_kernels/pck/moon_pa_de421_1900-2050.bpc
		https://naif.jpl.nasa.gov/pub/naif/generic_kernels/pck/a_old_versions/pck00008.tpc
		https://github.com/skyfielders/python-skyfield/raw/master/ci/hip_main.dat.gz
	)
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test"	# Test phase runs with fails

RDEPEND=">dev-python/certifi-2017.4.17[${PYTHON_USEDEP}]
	>=dev-python/jplephem-2.13[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	>=dev-python/sgp4-2.2[${PYTHON_USEDEP}]
"
BDEPEND="test? (
		dev-python/pytest-mpl[${PYTHON_USEDEP}]
		dev-python/assay[${PYTHON_USEDEP}]
		dev-python/pandas[${PYTHON_USEDEP}]
		dev-python/pytz[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

python_prepare_all() {
	use test && { cp "${DISTDIR}"/{*.bsp,*.tf,*.all,*pc,hip*} "${S}" || die ; }
	distutils-r1_python_prepare_all
}
