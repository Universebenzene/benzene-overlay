# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 pypi virtualx

DESCRIPTION="Callback Properties in Python"
HOMEPAGE="https://echo.readthedocs.io"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="qt"

RDEPEND="dev-python/numpy[${PYTHON_USEDEP}]
	qt? (
		>=dev-python/PyQt5-5.9[${PYTHON_USEDEP}]
		dev-python/QtPy[${PYTHON_USEDEP}]
	)
"
BDEPEND="dev-python/setuptools-scm[${PYTHON_USEDEP}]
	test? (
		dev-python/PyQt5[${PYTHON_USEDEP}]
		dev-python/QtPy[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
distutils_enable_sphinx doc dev-python/sphinx-automodapi dev-python/numpydoc

python_test() {
	virtx epytest
}
