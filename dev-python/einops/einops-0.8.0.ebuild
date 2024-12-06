# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{10..13} )

DOCS_BUILDER="mkdocs"
DOCS_DEPEND="dev-python/mkdocs-jupyter"

inherit distutils-r1 docs

DESCRIPTION="A new flavour of deep learning operations"
HOMEPAGE="https://einops.rocks"
SRC_URI="https://github.com/arogozhnikov/einops/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"	# mkdocstrings{,-python} no x86

BDEPEND="doc? (
	|| (
		dev-python/mkdocstrings-python-legacy[${PYTHON_USEDEP}]
		dev-python/mkdocstrings-python[${PYTHON_USEDEP}]
	) )
	test? (
		dev-python/numpy[${PYTHON_USEDEP}]
		dev-python/nbconvert[${PYTHON_USEDEP}]
		dev-python/pillow[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

EPYTEST_IGNORE=(
	# RuntimeError: Testing frameworks were not specified, flag EINOPS_TEST_BACKENDS not set
	tests/test_examples.py
	tests/test_ops.py
	tests/test_other.py
	tests/test_layers.py
)

EPYTEST_DESELECT=(
	# RuntimeError: Testing frameworks were not specified, flag EINOPS_TEST_BACKENDS not set
	tests/test_einsum.py::test_layer
	tests/test_einsum.py::test_functional
	tests/test_einsum.py::test_functional_symbolic
	tests/test_notebooks.py::test_notebook_2_with_all_backends
	tests/test_notebooks.py::test_notebook_3
	tests/test_notebooks.py::test_notebook_4
	tests/test_packing.py::test_pack_unpack_against_numpy
)

python_prepare_all() {
	use doc && { cp "${S}"/{README,docs_src/index}.md || die ; sed -i '$a use_directory_urls: false' mkdocs.yml || die ; }

	distutils-r1_python_prepare_all
}
