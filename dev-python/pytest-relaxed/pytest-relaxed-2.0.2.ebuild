# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1

DESCRIPTION="Relaxed test discovery/organization for pytest"
HOMEPAGE="https://github.com/bitprophet/pytest-relaxed"
SRC_URI="https://github.com/bitprophet/pytest-relaxed/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RDEPEND=">=dev-python/pytest-7[${PYTHON_USEDEP}]
	dev-python/decorator[${PYTHON_USEDEP}]
"

EPYTEST_PLUGIN_LOAD_VIA_ENV=1
EPYTEST_PLUGINS=( "${PN}" )
distutils_enable_tests pytest
# require releases, which depends on semantic-version<2.7
#distutils_enable_sphinx docs
