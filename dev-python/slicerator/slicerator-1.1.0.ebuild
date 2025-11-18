# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="A lazy-loading, fancy-sliceable iterable"
HOMEPAGE="https://slicerator.readthedocs.io"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND="test? ( dev-python/numpy[${PYTHON_USEDEP}] )"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/sphinx-rtd-theme dev-python/numpydoc

python_prepare_all() {
	use doc && { mkdir docs/_static || die ;\
#		sed -i "/language\ = /s/None/'en'/" docs/conf.py || die ;
	}

	distutils-r1_python_prepare_all
}
