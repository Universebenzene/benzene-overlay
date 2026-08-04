# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{{11..15},{13..15}t} )
#PYTHON_COMPAT=( python3_{{11..12},{13..15}{,t}} )

inherit distutils-r1

DESCRIPTION="A pytest plugin to skip \`@pytest.mark.slow\` tests by default"
HOMEPAGE="https://github.com/okken/pytest-skip-slow"
SRC_URI="https://github.com/okken/pytest-skip-slow/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RDEPEND=">=dev-python/pytest-6.2.0[${PYTHON_USEDEP}]"

EPYTEST_PLUGIN_LOAD_VIA_ENV=1
EPYTEST_PLUGINS=( "${PN}" )
distutils_enable_tests pytest
