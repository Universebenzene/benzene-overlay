# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="Sphinx extensions and configuration specific to the Astropy project"
HOMEPAGE="https://github.com/astropy/sphinx-astropy"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="confv2"
PROPERTIES="test_network"
RESTRICT="test"
RDEPEND=">=dev-python/sphinx-3.0.0[${PYTHON_USEDEP}]
	dev-python/astropy-sphinx-theme[${PYTHON_USEDEP}]
	dev-python/numpydoc[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/sphinx-automodapi[${PYTHON_USEDEP}]
	dev-python/sphinx-gallery[${PYTHON_USEDEP}]
	dev-python/sphinxcontrib-jquery[${PYTHON_USEDEP}]
	>=dev-python/pytest-doctestplus-0.11[${PYTHON_USEDEP}]
	confv2? (
		dev-python/pydata-sphinx-theme[${PYTHON_USEDEP}]
		dev-python/sphinx-copybutton[${PYTHON_USEDEP}]
	)
"
BDEPEND="dev-python/setuptools-scm[${PYTHON_USEDEP}]
	test? (
		dev-python/matplotlib[${PYTHON_USEDEP}]
		dev-python/pydata-sphinx-theme[${PYTHON_USEDEP}]
		dev-python/sphinx-copybutton[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
