# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_VERIFY_REPO=https://github.com/Quansight-Labs/pytest-run-parallel
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="A simple pytest plugin to run tests concurrently"
HOMEPAGE="https://github.com/Quansight-Labs/pytest-run-parallel"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="psutil"

RDEPEND=">=dev-python/pytest-6.2.0[${PYTHON_USEDEP}]
	psutil? ( >=dev-python/psutil-6.1.1[${PYTHON_USEDEP}] )
"
BDEPEND="test? ( dev-python/psutil[${PYTHON_USEDEP}] )"

EPYTEST_PLUGIN_LOAD_VIA_ENV=1
EPYTEST_PLUGINS=( "${PN}" hypothesis pytest-{order,xdist}  )
distutils_enable_tests pytest
