# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#DISTUTILS_USE_PEP517=setuptools
DISTUTILS_USE_SETUPTOOLS=rdepend
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="Toggle page content and collapse admonitions in Sphinx"
HOMEPAGE="https://sphinx-togglebutton.readthedocs.io"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="sphinx"
RESTRICT="test"	# No usable test phases

RDEPEND="dev-python/sphinx[${PYTHON_USEDEP}]
	dev-python/wheel[${PYTHON_USEDEP}]
	sphinx? (
		dev-python/matplotlib[${PYTHON_USEDEP}]
		dev-python/myst-nb[${PYTHON_USEDEP}]
		dev-python/numpy[${PYTHON_USEDEP}]
		dev-python/sphinx-book-theme[${PYTHON_USEDEP}]
		dev-python/sphinx-design[${PYTHON_USEDEP}]
		dev-python/sphinx-examples[${PYTHON_USEDEP}]
	)
"

#distutils_enable_tests nose
