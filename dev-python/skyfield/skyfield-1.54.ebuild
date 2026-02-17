# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
#DISTUTILS_USE_SETUPTOOLS=bdepend
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

DESCRIPTION="Elegant astronomy for Python"
HOMEPAGE="https://github.com/skyfielders/python-skyfield"
SRC_URI="https://github.com/skyfielders/python-skyfield/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"
#PROPERTIES="test_network"
RESTRICT="test"	# Test phase runs with fails

RDEPEND=">dev-python/certifi-2017.4.17[${PYTHON_USEDEP}]
	>=dev-python/jplephem-2.13[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	>=dev-python/sgp4-2.13[${PYTHON_USEDEP}]
"
BDEPEND="test? (
		dev-python/assay[${PYTHON_USEDEP}]
		dev-python/pandas[${PYTHON_USEDEP}]
	)
"

S="${WORKDIR}/python-${P}"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
distutils_enable_sphinx documentation dev-python/pandas

EPYTEST_IGNORE=(
	# OSError when connection timed out
	contrib/almanac2/test_almanac2.py
)

python_prepare_all() {
	use test && { for cif in ci/*; do cp ${cif} ${cif#ci/}; done || die ; }

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
