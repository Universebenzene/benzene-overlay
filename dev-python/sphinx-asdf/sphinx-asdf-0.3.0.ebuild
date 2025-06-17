# Copyright 2020-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="Sphinx plugin for generating documentation from ASDF schemas"
HOMEPAGE="https://github.com/spacetelescope/sphinx-asdf"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/asdf[${PYTHON_USEDEP}]
	>=dev-python/astropy-5.0.4[${PYTHON_USEDEP}]
	>=dev-python/mistune-3[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/sphinx-astropy[${PYTHON_USEDEP}]
	dev-python/sphinx-rtd-theme[${PYTHON_USEDEP}]
	dev-python/toml[${PYTHON_USEDEP}]
"
BDEPEND=">=dev-python/setuptools-scm-3.4[$PYTHON_USEDEP]"

distutils_enable_tests pytest
