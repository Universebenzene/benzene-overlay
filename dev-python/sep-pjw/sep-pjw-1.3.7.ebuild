# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="Astronomical source extraction and photometry library (forked from kbarbary)"
HOMEPAGE="https://sep-pjw.readthedocs.io"

LICENSE="BSD LGPL-3+ MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=">=dev-python/numpy-2.0.0_rc2[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
BDEPEND="dev-python/cython[${PYTHON_USEDEP}]
	doc? ( virtual/pandoc )
	test? ( || ( dev-python/fitsio[${PYTHON_USEDEP}] dev-python/astropy[${PYTHON_USEDEP}] ) )
"

distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/sphinx-copybutton \
	dev-python/fitsio \
	dev-python/furo \
	dev-python/ipython \
	dev-python/matplotlib \
	dev-python/myst-parser \
	dev-python/nbsphinx \
	dev-python/numpydoc

python_test() {
	epytest test.py
}
