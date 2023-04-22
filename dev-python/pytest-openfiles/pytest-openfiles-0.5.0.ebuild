# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1

DESCRIPTION="Pytest plugin to check for files left open at the end of a test run"
HOMEPAGE="https://github.com/astropy/pytest-openfiles"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RDEPEND="dev-python/psutil[${PYTHON_USEDEP}]
	>=dev-python/pytest-4.6[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
BDEPEND="dev-python/setuptools-scm[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
