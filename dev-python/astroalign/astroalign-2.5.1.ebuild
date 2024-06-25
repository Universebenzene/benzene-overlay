# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="A tool to align astronomical images based on asterism matching"
HOMEPAGE="https://astroalign.quatrope.org"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-python/numpy-1.17[${PYTHON_USEDEP}]
	dev-python/sep[${PYTHON_USEDEP}]
	dev-python/scikit-image[${PYTHON_USEDEP}]
	>=dev-python/scipy-0.15[${PYTHON_USEDEP}]
"
BDEPEND="test? ( dev-python/ccdproc[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest
