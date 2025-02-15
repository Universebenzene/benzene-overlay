# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 pypi

DESCRIPTION="Python interface to CmdStan"
HOMEPAGE="https://cmdstanpy.readthedocs.io"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="all"
RESTRICT="test"	# Missing test data

RDEPEND=">=dev-python/numpy-1.21[${PYTHON_USEDEP}]
	dev-python/pandas[${PYTHON_USEDEP}]
	dev-python/tqdm[${PYTHON_USEDEP}]
	all? ( dev-python/xarray[${PYTHON_USEDEP}] )
"
BDEPEND="test? ( dev-python/testfixtures[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

EPYTEST_IGNORE=(
	# from test import CustomTestCase - ModuleNotFoundError: No module named 'test'
	test/test_generate_quantities.py
	test/test_install_cmdstan.py
	test/test_model.py
	test/test_sample.py
	test/test_utils.py
)
