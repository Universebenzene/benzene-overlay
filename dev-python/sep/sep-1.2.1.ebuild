# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

DESCRIPTION="Python and C library for source extraction and photometry"
HOMEPAGE="https://sep.readthedocs.io"
SRC_URI="https://github.com/kbarbary/sep/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

DEPEND="dev-python/numpy[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
BDEPEND="dev-python/cython[${PYTHON_USEDEP}]
	doc? ( virtual/pandoc )
	test? (
		dev-python/astropy[${PYTHON_USEDEP}]
		dev-python/pytest[${PYTHON_USEDEP}]
	)
"

distutils_enable_sphinx docs dev-python/fitsio \
	dev-python/ipython \
	dev-python/matplotlib \
	dev-python/nbsphinx \
	dev-python/numpydoc \
	dev-python/sphinx-rtd-theme

python_test() {
	${EPYTHON} test.py || die "Tests failed with ${EPYTHON}"
}
