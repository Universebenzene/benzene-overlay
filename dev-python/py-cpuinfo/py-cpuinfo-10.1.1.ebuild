# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYPI_PN="${PN}2"
PYPI_VERIFY_REPO=https://github.com/akx/py-cpuinfo2
PYTHON_COMPAT=( python3_{{11..15},{13..15}t} )
#PYTHON_COMPAT=( python3_{{11..12},{13..15}{,t}} )

inherit distutils-r1 pypi

DESCRIPTION="Get CPU info with pure Python"
HOMEPAGE="https://github.com/akx/py-cpuinfo2"

LICENSE="MIT"
SLOT="2"
KEYWORDS="~amd64 ~x86"
RDEPEND="!dev-python/py-cpuinfo:0[${PYTHON_USEDEP}]"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
