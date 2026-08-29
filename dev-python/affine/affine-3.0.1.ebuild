# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{11..15} )

inherit distutils-r1 pypi

DESCRIPTION="Matrices describing affine transformation of the plane"
HOMEPAGE="https://github.com/rasterio/affine"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RDEPEND=">=dev-python/attrs-21.3.0[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/numpy[${PYTHON_USEDEP}] )"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
distutils_enable_sphinx docs/src
