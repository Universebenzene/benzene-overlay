# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="A pytest fixture for benchmarking code"
HOMEPAGE="https://pytest-benchmark.readthedocs.io"
SRC_URI+=" https://github.com/ionelmc/pytest-benchmark/pull/232.patch -> ${PN}-4.0.0-backport-232.patch"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="aspect elasticsearch histogram"

RDEPEND=">=dev-python/pytest-3.8[${PYTHON_USEDEP}]
	dev-python/py-cpuinfo[${PYTHON_USEDEP}]
	aspect? ( dev-python/aspectlib[${PYTHON_USEDEP}] )
	elasticsearch? ( dev-python/elasticsearch[${PYTHON_USEDEP}] )
	histogram? (
		dev-python/pygal[${PYTHON_USEDEP}]
		dev-python/pygaljs[${PYTHON_USEDEP}]
	)
"
BDEPEND="test? (
		dev-python/aspectlib[${PYTHON_USEDEP}]
		dev-python/elasticsearch[${PYTHON_USEDEP}]
		dev-python/freezegun[${PYTHON_USEDEP}]
		dev-python/pygal[${PYTHON_USEDEP}]
		dev-python/pygaljs[${PYTHON_USEDEP}]
		dev-python/pytest-xdist[${PYTHON_USEDEP}]
		dev-vcs/git
		dev-vcs/mercurial[${PYTHON_USEDEP}]
	)
"

PATCHES=( "${DISTDIR}/${P}-backport-232.patch" )

distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/sphinx-py3doc-enhanced-theme

#python_prepare_all() {
#	use test && { sed -i '/^    error$/d' pytest.ini || die ; }
#
#	distutils-r1_python_prepare_all
#}
