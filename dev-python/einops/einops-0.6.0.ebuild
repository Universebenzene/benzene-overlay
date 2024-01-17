# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="A new flavour of deep learning operations"
HOMEPAGE="https://einops.rocks"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND="test? (
		dev-python/numpy[${PYTHON_USEDEP}]
		dev-python/nbconvert[${PYTHON_USEDEP}]
		dev-python/parameterized[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

EPYTEST_IGNORE=(
	# No module named 'torch'
	tests/test_layers.py
)

EPYTEST_DESELECT=(
	# No docs directory
	tests/test_notebooks.py::test_dl_notebook_with_all_backends
	# This test will fail if some of backends are not installed or can't be imported
	tests/test_other.py::test_backends_installed
)
