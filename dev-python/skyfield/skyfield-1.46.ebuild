# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_SETUPTOOLS=no
PYTHON_COMPAT=( python3_{10..13} )

COMMIT="c3299d1857be528d23a0514b4dfc52581cabcb3e"

inherit distutils-r1

DESCRIPTION="Elegant astronomy for Python"
HOMEPAGE="https://github.com/skyfielders/python-skyfield"
SRC_URI="https://github.com/skyfielders/python-skyfield/archive/${COMMIT}.tar.gz -> ${P}.gh.tar.gz"

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

S="${WORKDIR}/python-${PN}-${COMMIT}"

distutils_enable_tests pytest
distutils_enable_sphinx skyfield/documentation dev-python/pandas

python_install_all() {
	if use examples; then
		docompress -x "/usr/share/doc/${PF}/examples"
		docinto examples
		dodoc -r examples/.
	fi

	distutils-r1_python_install_all
}
