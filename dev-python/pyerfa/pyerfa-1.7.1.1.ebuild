# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..9} )

inherit distutils-r1

DESCRIPTION="Python bindings for ERFA"
HOMEPAGE="https://pyerfa.readthedocs.io"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RESTRICT="!test? ( test )"
#network-sandbox

RDEPEND="
	>=sci-astronomy/erfa-1.7.1:0=
	>=dev-python/numpy-1.16[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
BDEPEND="${RDEPEND}
	dev-python/setuptools_scm[${PYTHON_USEDEP}]
	test? (
		dev-python/pytest-doctestplus[${PYTHON_USEDEP}]
	)
	doc? (
		media-gfx/graphviz
	)
"

distutils_enable_sphinx docs dev-python/sphinx-astropy

python_configure_all() {
	export PYERFA_USE_SYSTEM_LIBERFA=1
}

python_test() {
	pytest -vv "${BUILD_DIR}/lib" || die "Tests fail with ${EPYTHON}"
}
