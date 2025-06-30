# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="deflate64 compression/decompression library"
HOMEPAGE="https://inflate64.readthedocs.io"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND=">=dev-python/setuptools-scm-6.0.1[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/sphinx-rtd-theme

python_prepare_all() {
	use doc && { mkdir -p docs/_static || die ; }

	distutils-r1_python_prepare_all
}
