# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="Python package for configuring a python package"
HOMEPAGE="https://donfig.readthedocs.io"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/pyyaml[${PYTHON_USEDEP}]"
BDEPEND=">=dev-python/versioneer-0.28[${PYTHON_USEDEP}]
	test? ( dev-python/cloudpickle[${PYTHON_USEDEP}] )
"

distutils_enable_tests pytest
