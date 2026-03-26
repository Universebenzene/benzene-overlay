# Copyright 2022-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYPI_VERIFY_REPO=https://github.com/zarr-developers/zarr-python
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="An implementation of chunked, compressed, N-dimensional arrays for Python"
HOMEPAGE="http://zarr.readthedocs.io"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="cli examples optional remote"

RDEPEND=">=dev-python/donfig-0.8[${PYTHON_USEDEP}]
	>=dev-python/google-crc32c-0.14[${PYTHON_USEDEP}]
	>=dev-python/numpy-2.0[${PYTHON_USEDEP}]
	>=dev-python/numcodecs-0.14[${PYTHON_USEDEP}]
	>=dev-python/packaging-22.0[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.12[${PYTHON_USEDEP}]
	cli? ( dev-python/typer[${PYTHON_USEDEP}] )
	optional? ( dev-python/universal-pathlib[${PYTHON_USEDEP}] )
	remote? ( >=dev-python/fsspec-2023.10.0[${PYTHON_USEDEP}] )
"
BDEPEND="dev-python/hatch-vcs[${PYTHON_USEDEP}]
	test? (
		dev-python/flask-cors[${PYTHON_USEDEP}]
		dev-python/moto[${PYTHON_USEDEP}]
		dev-python/numpydoc[${PYTHON_USEDEP}]
		dev-python/s3fs[${PYTHON_USEDEP}]
		dev-python/tomlkit[${PYTHON_USEDEP}]
		dev-python/typer[${PYTHON_USEDEP}]
		dev-python/universal-pathlib[${PYTHON_USEDEP}]
		dev-libs/zfp[python]
	)
"

EPYTEST_PLUGINS=( hypothesis pytest-{asyncio,benchmark,examples} )
distutils_enable_tests pytest
#distutils_enable_sphinx docs dev-python/numpydoc \
#	dev-python/sphinx-autoapi \
#	dev-python/sphinx-copybutton \
#	dev-python/sphinx-design \
#	dev-python/sphinx-issues \
#	dev-python/sphinx-reredirects \
#	dev-python/pydata-sphinx-theme

python_install_all() {
	if use examples; then
		docompress -x "/usr/share/doc/${PF}/examples"
		docinto examples
		dodoc -r examples/.
	fi

	distutils-r1_python_install_all
}

EPYTEST_IGNORE=(
	tests/test_docs.py
	# Ignore uv related tests
#	tests/test_examples.py
#	tests/test_regression/test_v2_dtype_regression.py
)

EPYTEST_DESELECT=(
	# Ignore uv related tests
	'tests/test_examples.py::test_scripts_can_run[script_path0]'
)

python_test() {
	epytest --run-slow-hypothesis #-Werror::zarr.core.dtype.common.UnstableSpecificationWarning
}
