# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{{11..15},{13..15}t} )
#PYTHON_COMPAT=( python3_{{11..12},{13..15}{,t}} )

inherit distutils-r1 pypi

DESCRIPTION="The Official API Spec Language for Dropbox API V2"
HOMEPAGE="https://www.dropbox.com/developers https://github.com/dropbox/stone"
#SRC_URI="https://github.com/dropbox/stone/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-python/jinja2-3.1.6[${PYTHON_USEDEP}]
	>=dev-python/packaging-26.2[${PYTHON_USEDEP}]
"
BDEPEND=">=dev-python/setuptools-scm-10.2.1[${PYTHON_USEDEP}]"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
