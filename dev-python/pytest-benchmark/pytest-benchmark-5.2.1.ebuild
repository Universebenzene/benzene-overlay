# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="A pytest fixture for benchmarking code"
HOMEPAGE="https://pytest-benchmark.readthedocs.io"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="aspect elasticsearch histogram"

RDEPEND=">=dev-python/pytest-8.1[${PYTHON_USEDEP}]
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
		dev-vcs/git
		dev-vcs/mercurial[${PYTHON_USEDEP}]
	)
"

PATCHES=( "${FILESDIR}/${PN}-5.2.0-fix-pytest-9.patch" )

EPYTEST_PLUGIN_LOAD_VIA_ENV=1
EPYTEST_PLUGINS=( "${PN}" pytest-xdist )
distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/furo

EPYTEST_DESELECT=(
	# https://gitlab.archlinux.org/archlinux/packaging/packages/python-pytest-benchmark/-/blob/main/PKGBUILD
	tests/test_cli.py::test_help
)

python_prepare_all() {
#	use test && { sed -i '/^    error$/d' pytest.ini || die ; }
	use test && { sed -i '/--nbmake/d' pytest.ini || die ; }

	distutils-r1_python_prepare_all
}
