# Copyright 2020-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="Astropy affiliated package for reducing optical/IR CCD data"
HOMEPAGE="https://ccdproc.readthedocs.io"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"

LICENSE="BSD"
SLOT="0"

RDEPEND="
	>=dev-python/astropy-2.0[${PYTHON_USEDEP}]
	dev-python/scikit-image[${PYTHON_USEDEP}]
	>=dev-python/astroscrappy-1.0.5[${PYTHON_USEDEP}]
	>=dev-python/reproject-0.5[${PYTHON_USEDEP}]
	>=dev-python/numpy-1.16[${PYTHON_USEDEP}]
"
BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	doc? (
		${RDEPEND}
		dev-python/sphinx-astropy[${PYTHON_USEDEP}]
		media-gfx/graphviz
	)
	test? (
		dev-python/pytest-astropy[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
distutils_enable_sphinx docs --no-autodoc
