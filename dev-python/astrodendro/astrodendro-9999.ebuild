# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..10} )

inherit distutils-r1

DESCRIPTION="Python package for computation of astronomical dendrograms"
HOMEPAGE="https://dendrograms.readthedocs.io"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/dendrograms/${PN}.git"
	inherit git-r3
else
	SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MIT"
SLOT="0"

RDEPEND=">=dev-python/numpy-1.24[${PYTHON_USEDEP}]
	>dev-python/astropy-4[${PYTHON_USEDEP}]
	>dev-python/h5py-3[${PYTHON_USEDEP}]
	>dev-python/matplotlib-3[${PYTHON_USEDEP}]
"
BDEPEND="dev-python/setuptools_scm[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/sphinx-automodapi dev-python/numpydoc dev-python/aplpy
