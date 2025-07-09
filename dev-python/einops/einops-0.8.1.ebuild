# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="A new flavour of deep learning operations"
HOMEPAGE="https://einops.rocks"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND="test? ( dev-python/numpy[${PYTHON_USEDEP}] )
"
#		dev-python/nbconvert[${PYTHON_USEDEP}]
#		dev-python/parameterized[${PYTHON_USEDEP}]

distutils_enable_tests pytest

EPYTEST_IGNORE=(
	# No module named 'torch'
	${PN}/tests/test_examples.py
	${PN}/tests/test_ops.py
	${PN}/tests/test_other.py
)

EPYTEST_DESELECT=(
	# RuntimeError: Testing frameworks were not specified, flag EINOPS_TEST_BACKENDS not set
	${PN}/tests/test_einsum.py::test_layer
	${PN}/tests/test_einsum.py::test_functional
	${PN}/tests/test_einsum.py::test_functional_symbolic
	${PN}/tests/test_packing.py::test_pack_unpack_against_numpy
	${PN}/tests/test_layers.py::test_rearrange_imperative
	${PN}/tests/test_layers.py::test_rearrange_symbolic
	${PN}/tests/test_layers.py::test_reduce_imperative
	${PN}/tests/test_layers.py::test_reduce_symbolic
	${PN}/tests/test_layers.py::test_torch_layer
	${PN}/tests/test_layers.py::test_torch_layers_scripting
	${PN}/tests/test_layers.py::test_keras_layer
	${PN}/tests/test_layers.py::test_flax_layers
#	tests/test_notebooks.py::test_dl_notebook_with_all_backends
#	# This test will fail if some of backends are not installed or can't be imported
#	tests/test_other.py::test_backends_installed
)
