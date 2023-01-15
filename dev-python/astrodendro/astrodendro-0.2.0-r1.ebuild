# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..10} )

inherit distutils-r1

DESCRIPTION="Python package for computation of astronomical dendrograms"
HOMEPAGE="https://dendrograms.readthedocs.io"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
RESTRICT="test"	# Test phase runs with fails

RDEPEND=">=dev-python/astropy-0.2.0[${PYTHON_USEDEP}]
	>=dev-python/h5py-0.2.0[${PYTHON_USEDEP}]
"
BDEPEND="test? (
		dev-python/matplotlib[${PYTHON_USEDEP}]
		dev-python/mock[${PYTHON_USEDEP}]
	)
"

PATCHES=(
	"${FILESDIR}/${P}-fix-collection-py3.10.patch"
	"${FILESDIR}/${P}-new-doc-building.patch"
)

distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/sphinx-automodapi dev-python/aplpy
