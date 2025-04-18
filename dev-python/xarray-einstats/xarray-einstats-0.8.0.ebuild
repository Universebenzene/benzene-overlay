# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1

DESCRIPTION="Stats, linear algebra and einops for xarray"
HOMEPAGE="https://einstats.python.arviz.org"
SRC_URI="https://github.com/arviz-devs/xarray-einstats/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="einops numba"

RDEPEND=">=dev-python/numpy-1.22[${PYTHON_USEDEP}]
	>=dev-python/scipy-1.8[${PYTHON_USEDEP}]
	>=dev-python/xarray-2022.09.0[${PYTHON_USEDEP}]
	einops? ( dev-python/einops[${PYTHON_USEDEP}] )
	numba? ( >=dev-python/numba-0.55[${PYTHON_USEDEP}] )
"
BDEPEND="test? (
		dev-python/einops[${PYTHON_USEDEP}]
		dev-python/numba[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
distutils_enable_sphinx docs/source dev-python/sphinx-copybutton \
	dev-python/sphinx-design \
	dev-python/sphinx-togglebutton \
	dev-python/furo \
	dev-python/jupyter-sphinx \
	dev-python/myst-nb \
	dev-python/numpydoc \
	dev-python/einops \
	dev-python/matplotlib \
	dev-python/numba
