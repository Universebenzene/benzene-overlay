# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_SETUPTOOLS=bdepend
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1

DESCRIPTION="Elegant astronomy for Python"
HOMEPAGE="https://github.com/skyfielders/python-skyfield"
SRC_URI="https://github.com/skyfielders/python-skyfield/archive/${PV}.tar.gz -> ${P}.gh.tar.gz
	test? ( https://datacenter.iers.org/data/9/finals2000A.all -> ${P}-finals2000A.all )
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"
PROPERTIES="test_network"
RESTRICT="test"	# Test phase runs with fails

RDEPEND=">dev-python/certifi-2017.4.17[${PYTHON_USEDEP}]
	>=dev-python/jplephem-2.13[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	>=dev-python/sgp4-2.2[${PYTHON_USEDEP}]
"
BDEPEND="test? (
		dev-python/assay[${PYTHON_USEDEP}]
		dev-python/pandas[${PYTHON_USEDEP}]
	)
"

S="${WORKDIR}/python-${P}"

distutils_enable_tests pytest
distutils_enable_sphinx documentation dev-python/pandas

python_prepare_all() {
	use test && { cp {"${DISTDIR}"/${P}-,"${S}"/}finals2000A.all || die ; }

	distutils-r1_python_prepare_all
}

python_install_all() {
	if use examples; then
		docompress -x "/usr/share/doc/${PF}/examples"
		docinto examples
		dodoc -r examples/.
	fi

	distutils-r1_python_install_all
}
