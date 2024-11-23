# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1 pypi

DESCRIPTION="An analysis and visualization toolkit for volumetric data"
HOMEPAGE="http://yt-project.org"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"	# Test phase runs with errors
IUSE="full"

DEPEND=">=dev-python/numpy-1.13.3[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	>=dev-python/cmyt-0.2.2[${PYTHON_USEDEP}]
	>dev-python/matplotlib-3.4.2[${PYTHON_USEDEP}]
	>=dev-python/more-itertools-8.4[${PYTHON_USEDEP}]
	>=dev-python/packaging-20.9[${PYTHON_USEDEP}]
	>=dev-python/setuptools-19.6[${PYTHON_USEDEP}]
	>=dev-python/tomli-1.2.3[${PYTHON_USEDEP}]
	>=dev-python/tomli-w-0.4.0[${PYTHON_USEDEP}]
	>=dev-python/tqdm-3.4.0[${PYTHON_USEDEP}]
	>=dev-python/unyt-2.8[${PYTHON_USEDEP}]
	full? (
		<dev-python/astropy-6.0.0[${PYTHON_USEDEP}]
		>=dev-python/f90nml-1.1.2[${PYTHON_USEDEP}]
		>=dev-python/fastcache-1.0.2[${PYTHON_USEDEP}]
		<dev-python/firefly-vis-3.0.0[${PYTHON_USEDEP}]
		>=dev-python/glueviz-0.13.3[${PYTHON_USEDEP}]
		>dev-python/glue-core-1.2.4[${PYTHON_USEDEP}]
		<dev-python/h5py-4.0.0[${PYTHON_USEDEP}]
		>=dev-python/ipython-2.0.0[${PYTHON_USEDEP}]
		>=dev-python/libconf-1.0.1[${PYTHON_USEDEP}]
		>=dev-python/miniballcpp-0.2.1[${PYTHON_USEDEP}]
		>=dev-python/mpi4py-3.0.3[${PYTHON_USEDEP}]
		>=dev-python/netcdf4-1.5.3[${PYTHON_USEDEP}]
		>=dev-python/pandas-1.1.2[${PYTHON_USEDEP}]
		>=dev-python/pooch-0.7.0[${PYTHON_USEDEP}]
		>=dev-python/pyaml-17.10.0[${PYTHON_USEDEP}]
		>=dev-python/pykdtree-1.3.1[${PYTHON_USEDEP}]
		>=dev-python/pyqt5-5.15.2[${PYTHON_USEDEP}]
		>=dev-python/pyx-0.15[${PYTHON_USEDEP}]
		>=dev-python/requests-2.20.0[${PYTHON_USEDEP}]
		>=dev-python/scipy-1.5.0[${PYTHON_USEDEP}]
		>=dev-python/xarray-0.16.1[${PYTHON_USEDEP}]
	)
"
BDEPEND="test? (
		dev-python/pyyaml[${PYTHON_USEDEP}]
		dev-python/nose[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
distutils_enable_sphinx doc/source dev-python/sphinx-bootstrap-theme \
	'>dev-python/runnotebook-0.3.1' \
	dev-python/bottle \
	dev-python/h5py \
	dev-python/nose \
	dev-python/pytest \
	'>=dev-python/pyx-0.15' \
	dev-python/pyyaml

EPYTEST_IGNORE=(
	# Need lots of online data
	yt/tests/test_load_sample.py
	# function uses no argument 'axis'
	yt/frontends/gdf/tests/test_outputs_nose.py
)

python_compile_all() {
	use doc && { [[ -d ${PN} ]] && { mv {,_}${PN} || die ; } ; cp -r "${S}"{/doc/helper_scripts,} || die ; }
	sphinx_compile_all
	[[ -d _${PN} ]] && { mv {_,}${PN} || die ; }
}

python_test() {
	pushd "${BUILD_DIR}/install/$(python_get_sitedir)" || die
	epytest
	popd || die
}
