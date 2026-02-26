# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_VERIFY_REPO=https://github.com/Starlink/starlink-pyast
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="Python interface to the Starlink AST library"
HOMEPAGE="http://www.starlink.ac.uk/ast"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

DEPEND="dev-libs/libyaml
	dev-python/numpy[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
BDEPEND=">=dev-python/setuptools-scm-8.0[${PYTHON_USEDEP}]
	test? ( dev-python/scipy[${PYTHON_USEDEP}] )
"

python_test() {
	${EPYTHON} src/starlink/ast/test/test.py || die "Tests failed with ${EPYTHON}"
}
