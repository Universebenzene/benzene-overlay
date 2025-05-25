# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

DESCRIPTION="Tools for accessing JPEG2000 files"
HOMEPAGE="https://api4jenkins.readthedocs.io"
SRC_URI="https://github.com/joelee2012/api4jenkins/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-python/httpx-0.24.1[${PYTHON_USEDEP}]"
BDEPEND="test? (
		dev-python/pytest-tornasync[${PYTHON_USEDEP}]
		dev-python/respx[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
distutils_enable_sphinx docs/source

EPYTEST_IGNORE=(
	# KeyError: 'JENKINS_URL' - need pyyaml
	tests/integration
)
