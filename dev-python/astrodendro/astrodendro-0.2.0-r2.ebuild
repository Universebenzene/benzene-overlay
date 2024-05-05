# Copyright 2020-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="Python package for computation of astronomical dendrograms"
HOMEPAGE="https://dendrograms.readthedocs.io"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
RESTRICT="test"	# Test phase runs with fails

RDEPEND=">=dev-python/numpy-1.24[${PYTHON_USEDEP}]
	>=dev-python/astropy-0.2.0[${PYTHON_USEDEP}]
	>=dev-python/h5py-0.2.0[${PYTHON_USEDEP}]
"
BDEPEND="test? (
		dev-python/matplotlib[${PYTHON_USEDEP}]
		dev-python/mock[${PYTHON_USEDEP}]
	)
"

PATCHES=(
	"${FILESDIR}/001-${P}-fix-collection-py3.10.patch"
	"${FILESDIR}/002-${P}-fix-compability-to-numpy-1.24.patch"
	"${FILESDIR}/${P}-new-doc-building.patch"
)

distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/sphinx-automodapi dev-python/aplpy
