# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="PPMd compression/decompression library"
HOMEPAGE="https://pyppmd.readthedocs.io"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND=">=dev-python/setuptools-scm-6.4.2[${PYTHON_USEDEP}]"

EPYTEST_PLUGINS=( hypothesis pytest-{benchmark,timeout} )
distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/sphinx-rtd-theme

python_prepare_all() {
	use doc && { mkdir -p docs/_static || die ; }

	distutils-r1_python_prepare_all
}
