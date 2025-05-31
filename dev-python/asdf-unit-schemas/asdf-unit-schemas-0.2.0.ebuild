# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="ASDF schemas for units"
HOMEPAGE="https://asdf-unit-schemas.readthedocs.io"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND=">=dev-python/setuptools-scm-3.4[${PYTHON_USEDEP}]"
PDEPEND="test? ( dev-python/asdf[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/sphinx-rtd-theme
