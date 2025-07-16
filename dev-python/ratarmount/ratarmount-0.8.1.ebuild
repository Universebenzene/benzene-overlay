# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="Random Access Read-Only Tar Mount"
HOMEPAGE="https://github.com/mxmlnkn/ratarmount"
GIT_RAW_URI="https://github.com/mxmlnkn/ratarmount/raw/v${PV}"
SRC_URI="https://github.com/mxmlnkn/ratarmount/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-python/fusepy[${PYTHON_USEDEP}]
	>=dev-python/indexed-bzip2-1.1.2[${PYTHON_USEDEP}]
	>=dev-python/indexed-gzip-1.5.3[${PYTHON_USEDEP}]
	>=dev-python/indexed-zstd-1.2.2[${PYTHON_USEDEP}]
"

python_test() {
	${EPYTHON} tests/tests.py || die "Tests failed with ${EPYTHON}"
}
