# Copyright 2019-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} pypy3_11 )

inherit distutils-r1 pypi

DESCRIPTION="Library for testing asyncio code with pytest"
HOMEPAGE="
	https://github.com/pytest-dev/pytest-asyncio/
	https://pypi.org/project/pytest-asyncio/
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm arm64 ~loong ~mips ppc ppc64 ~riscv ~s390 ~sparc x86"

RDEPEND=">=dev-python/pytest-7.0.0[${PYTHON_USEDEP}]"
BDEPEND=">=dev-python/setuptools-scm-6.2[${PYTHON_USEDEP}]"

EPYTEST_PLUGINS=( "${PN}" flaky hypothesis pytest-trio )
EPYTEST_PLUGIN_AUTOLOAD=1
distutils_enable_tests pytest
distutils_enable_sphinx docs/source dev-python/sphinx-rtd-theme

python_prepare_all() {
	use doc && { mkdir docs/source/_static || die ; }
	distutils-r1_python_prepare_all
}
