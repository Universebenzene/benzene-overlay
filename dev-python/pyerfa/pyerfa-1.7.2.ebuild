# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="Python bindings for ERFA"
HOMEPAGE="https://pyerfa.readthedocs.io"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND=">=sci-astronomy/erfa-1.7.2:0=
	>=dev-python/numpy-1.16[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
BDEPEND="${RDEPEND}
	dev-python/setuptools-scm[${PYTHON_USEDEP}]
	doc? (	media-gfx/graphviz )
	test? ( >=dev-python/pytest-doctestplus-0.7[${PYTHON_USEDEP}] )
"

distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/sphinx-astropy

python_configure_all() {
	export PYERFA_USE_SYSTEM_LIBERFA=1
}

python_test() {
	epytest "${BUILD_DIR}/lib"
}
