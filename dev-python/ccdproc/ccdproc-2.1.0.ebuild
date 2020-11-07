# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8,9} )

inherit distutils-r1

DESCRIPTION="Astropy affiliated package for reducing optical/IR CCD data"
HOMEPAGE="https://ccdproc.readthedocs.io"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"

LICENSE="BSD"
SLOT="0"
IUSE=""
RESTRICT="!test? ( test )"

RDEPEND="
	>=dev-python/astropy-2.0[${PYTHON_USEDEP}]
	sci-libs/scikits_image[${PYTHON_USEDEP}]
	>=dev-python/astroscrappy-1.0.5[${PYTHON_USEDEP}]
	>=dev-python/reproject-0.5[${PYTHON_USEDEP}]
	>=dev-python/numpy-1.16[${PYTHON_USEDEP}]
"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	doc? (
		${RDEPEND}
		dev-python/sphinx-astropy[${PYTHON_USEDEP}]
		media-gfx/graphviz
	)
	test? (
		${RDEPEND}
		dev-python/pytest-astropy[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
distutils_enable_sphinx docs --no-autodoc
