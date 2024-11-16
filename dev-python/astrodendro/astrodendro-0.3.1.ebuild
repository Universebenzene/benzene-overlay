# Copyright 2020-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 virtualx

DESCRIPTION="Python package for computation of astronomical dendrograms"
HOMEPAGE="https://dendrograms.readthedocs.io"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/dendrograms/${PN}.git"
	inherit git-r3
else
	inherit pypi
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MIT"
SLOT="0"

RDEPEND=">=dev-python/numpy-1.24[${PYTHON_USEDEP}]
	>=dev-python/astropy-5[${PYTHON_USEDEP}]
	>=dev-python/h5py-3[${PYTHON_USEDEP}]
	>=dev-python/matplotlib-3.3[${PYTHON_USEDEP}]
"
BDEPEND="dev-python/setuptools-scm[${PYTHON_USEDEP}]
	test? ( || (
		dev-python/PyQt5[${PYTHON_USEDEP},svg]
		dev-python/PyQt6[${PYTHON_USEDEP},svg]
	) )
"

distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/sphinx-automodapi dev-python/numpydoc dev-python/aplpy

python_test() {
	virtx epytest
}
