# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

DESCRIPTION="Task scheduling and blocked algorithms for parallel processing"
HOMEPAGE="
	https://www.dask.org/
	https://github.com/dask/dask/
	https://pypi.org/project/dask/
"
SRC_URI="
	https://github.com/dask/dask/archive/${PV}.tar.gz -> ${P}.gh.tar.gz
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~riscv ~x86"
PROPERTIES="test_network"
RESTRICT="test"

RDEPEND=">=dev-python/click-8.1[${PYTHON_USEDEP}]
	>=dev-python/cloudpickle-3.0.0[${PYTHON_USEDEP}]
	>=dev-python/fsspec-2021.9.0[${PYTHON_USEDEP}]
	>=dev-python/numpy-1.24[${PYTHON_USEDEP}]
	>=dev-python/pandas-1.3[${PYTHON_USEDEP}]
	>=dev-python/packaging-20.0[${PYTHON_USEDEP}]
	>=dev-python/partd-1.4.0[${PYTHON_USEDEP}]
	dev-python/psutil[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-5.3.1[${PYTHON_USEDEP}]
	>=dev-python/toolz-0.10.0[${PYTHON_USEDEP}]
	$(python_gen_cond_dep '
		>=dev-python/importlib-metadata-4.13.0[${PYTHON_USEDEP}]
	' 3.{10..11})
"
BDEPEND="dev-python/toolz[${PYTHON_USEDEP}]
	>=dev-python/versioneer-0.28[${PYTHON_USEDEP}]
	test? (
		dev-python/aiohttp[${PYTHON_USEDEP}]
		dev-python/bokeh[${PYTHON_USEDEP}]
		dev-python/boto3[${PYTHON_USEDEP}]
		dev-python/botocore[${PYTHON_USEDEP}]
		dev-python/dask-expr[${PYTHON_USEDEP}]
		dev-python/ipython[${PYTHON_USEDEP}]
		dev-python/graphviz[${PYTHON_USEDEP}]
		dev-python/h5py[${PYTHON_USEDEP}]
		dev-python/httpretty[${PYTHON_USEDEP}]
		dev-python/jinja2[${PYTHON_USEDEP}]
		dev-python/jsonschema[${PYTHON_USEDEP}]
		dev-python/lz4[${PYTHON_USEDEP}]
		dev-python/matplotlib[${PYTHON_USEDEP}]
		dev-python/moto[${PYTHON_USEDEP}]
		dev-python/numba[${PYTHON_USEDEP}]
		dev-python/numexpr[${PYTHON_USEDEP}]
		dev-python/pyarrow[parquet,snappy,${PYTHON_USEDEP}]
		dev-python/pytest-rerunfailures[${PYTHON_USEDEP}]
		dev-python/requests[${PYTHON_USEDEP}]
		dev-python/s3fs[${PYTHON_USEDEP}]
		dev-python/scikit-image[${PYTHON_USEDEP}]
		dev-python/scikit-learn[${PYTHON_USEDEP}]
		dev-python/scipy[${PYTHON_USEDEP}]
		dev-python/python-snappy[${PYTHON_USEDEP}]
		dev-python/sqlalchemy[${PYTHON_USEDEP}]
		dev-python/tables[${PYTHON_USEDEP}]
		dev-python/xarray[${PYTHON_USEDEP}]
		dev-python/xxhash[${PYTHON_USEDEP}]
		dev-python/zarr[${PYTHON_USEDEP}]
		sci-geosciences/xyzservices[${PYTHON_USEDEP}]
	)
"

#PATCHES=( "${FILESDIR}/${P}-test-pandas-2.0.patch" )

EPYTEST_XDIST=1
distutils_enable_tests pytest

EPYTEST_DESELECT=(
	dask/dataframe/io/tests/test_sql.py::test_division_or_partition
	dask/tests/test_base.py::test_visualize_order
	dask/tests/test_tokenize.py::test_tokenize_dataclass
)

src_prepare() {
	# fails with sqlalchemy-2.0, even though we don't use it x_x
	sed -i -e '/RemovedIn20Warning/d' pyproject.toml || die
	sed -i -e 's:--cov-config=pyproject.toml::' pyproject.toml || die
	distutils-r1_src_prepare
}

python_test() {
	local -x PYTEST_DISABLE_PLUGIN_AUTOLOAD=1
	local -x DASK_DATAFRAME__QUERY_PLANNING=False
	epytest -k 'not test_RandomState_only_funcs'
}
