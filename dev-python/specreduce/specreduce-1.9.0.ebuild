# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_VERIFY_REPO=https://github.com/astropy/specreduce
PYTHON_COMPAT=( python3_{11..13} )

DATA_COM="dcba1c6"
DATA_URI="https://github.com/astropy/specreduce-data/raw/${DATA_COM}/specreduce_data/reference_data"

inherit distutils-r1 pypi

DESCRIPTION="Astropy coordinated package for Spectroscopic Reductions"
HOMEPAGE="https://specreduce.readthedocs.io"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="all intersphinx"
PROPERTIES="test_network"
RESTRICT="test"

RDEPEND=">=dev-python/astropy-6.0[${PYTHON_USEDEP}]
	dev-python/gwcs[${PYTHON_USEDEP}]
	>=dev-python/matplotlib-3.10[${PYTHON_USEDEP}]
	>=dev-python/scipy-1.14[${PYTHON_USEDEP}]
	>=dev-python/specutils-2.0[${PYTHON_USEDEP}]
	all? (
		>=dev-python/photutils-1.11[${PYTHON_USEDEP}]
		dev-python/synphot[${PYTHON_USEDEP}]
	)
"
BDEPEND="dev-python/setuptools-scm[${PYTHON_USEDEP}]
	test? (
		dev-python/photutils[${PYTHON_USEDEP}]
		dev-python/synphot[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=( pytest-{astropy-header,doctestplus,mock,remotedata} )
distutils_enable_tests pytest

python_install() {
	distutils-r1_python_install
	rm -r "${ED%/}"/$(python_get_sitedir)/{docs,licenses} || die
}

python_test() {
	epytest --remote-data
}
