# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

DESCRIPTION="High Level Expressions for Dask"
HOMEPAGE="
	https://github.com/dask/dask-expr/
	https://pypi.org/project/dask-expr/
"
# pypi tarball removes tests, as of 1.0.1
SRC_URI="
	https://github.com/dask/dask-expr/archive/v${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~riscv ~x86"

RDEPEND="
	>=dev-python/dask-2024.11.2[${PYTHON_USEDEP}]
	>=dev-python/pyarrow-14.0.1[${PYTHON_USEDEP}]
	>=dev-python/pandas-2[${PYTHON_USEDEP}]
"
# TODO: make pandas depend on pyarrow unconditionally?  we're having
# transitive deps here.
BDEPEND="
	dev-python/versioneer[${PYTHON_USEDEP}]
	test? (
		dev-libs/apache-arrow[parquet,snappy]
		dev-python/pyarrow[parquet,${PYTHON_USEDEP}]
		dev-python/sqlalchemy[${PYTHON_USEDEP}]
		dev-python/xarray[${PYTHON_USEDEP}]
	)
"

EPYTEST_XDIST=1
distutils_enable_tests pytest

src_prepare() {
	# unpin
	sed -i -e '/dask/s:==:>=:' pyproject.toml || die
	distutils-r1_src_prepare
}

python_test() {
	local EPYTEST_DESELECT=(
	#	# requires distributed
	#	'dask_expr/tests/test_shuffle.py::test_respect_context_shuffle[shuffle]'
	#	# TODO
	#	dask_expr/tests/test_groupby.py::test_groupby_index_array
		dask_expr/tests/test_format.py::test_df_to_html
		dask_expr/tests/test_describe.py::test_describe_df
		dask_expr/tests/test_describe.py::test_describe_series
		dask_expr/tests/test_indexing.py
	)
	local EPYTEST_IGNORE=(
		# requires distributed
		dask_expr/io/tests/test_parquet.py
	)

	local -x PYTEST_DISABLE_PLUGIN_AUTOLOAD=1
	epytest
}
