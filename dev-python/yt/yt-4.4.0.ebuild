# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 pypi

DESCRIPTION="An analysis and visualization toolkit for volumetric data"
HOMEPAGE="http://yt-project.org"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
PROPERTIES="test_network"
RESTRICT="test"
IUSE="full"

DEPEND=">=dev-python/numpy-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/ewah-bool-utils-1.2.0[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}
	>=dev-python/cmyt-1.1.2[${PYTHON_USEDEP}]
	>dev-python/matplotlib-3.5[${PYTHON_USEDEP}]
	>=dev-python/more-itertools-8.4[${PYTHON_USEDEP}]
	>=dev-python/packaging-20.9[${PYTHON_USEDEP}]
	>=dev-python/pillow-8.3.2[${PYTHON_USEDEP}]
	$(python_gen_cond_dep '>=dev-python/tomli-1.2.3[${PYTHON_USEDEP}]' python3_10)
	>=dev-python/tomli-w-0.4.0[${PYTHON_USEDEP}]
	>=dev-python/tqdm-3.4.0[${PYTHON_USEDEP}]
	>=dev-python/unyt-2.9.2[${PYTHON_USEDEP}]
	full? (
		>=dev-python/astropy-4.0.1[${PYTHON_USEDEP}]
		>=dev-python/f90nml-1.1.2[${PYTHON_USEDEP}]
		>=dev-python/firefly-3.2.0[${PYTHON_USEDEP}]
		>=dev-python/glueviz-0.13.3[${PYTHON_USEDEP}]
		>dev-python/glue-core-1.2.4[${PYTHON_USEDEP}]
		>=dev-python/h5py-3.1.0[${PYTHON_USEDEP}]
		>=dev-python/ipython-2.0.0[${PYTHON_USEDEP}]
		>=dev-python/ipywidgets-8.0.0[${PYTHON_USEDEP}]
		>=dev-python/libconf-1.0.1[${PYTHON_USEDEP}]
		>=dev-python/miniballcpp-0.2.1[${PYTHON_USEDEP}]
		>=dev-python/mpi4py-3.0.3[${PYTHON_USEDEP}]
		>dev-python/netcdf4-1.6.1[${PYTHON_USEDEP}]
		>=dev-python/pandas-1.1.2[${PYTHON_USEDEP}]
		>=dev-python/pooch-0.7.0[${PYTHON_USEDEP}]
		>=dev-python/pyaml-17.10.0[${PYTHON_USEDEP}]
		>=dev-python/pykdtree-1.3.1[${PYTHON_USEDEP}]
		>=dev-python/pyx-0.15[${PYTHON_USEDEP}]
		>=dev-python/ratarmount-0.8.1[${PYTHON_USEDEP}]
		>=dev-python/regions-0.7[${PYTHON_USEDEP}]
		>=dev-python/requests-2.20.0[${PYTHON_USEDEP}]
		>=dev-python/scipy-1.5.0[${PYTHON_USEDEP}]
		>=dev-python/xarray-0.16.1[${PYTHON_USEDEP}]
		sci-libs/cartopy
	)
"
BDEPEND=">=dev-python/cython-3.0.3[${PYTHON_USEDEP}]
	doc? ( virtual/pandoc )
	test? (
		dev-python/pytest-mpl[${PYTHON_USEDEP}]
		dev-python/astropy[${PYTHON_USEDEP}]
		dev-python/f90nml[${PYTHON_USEDEP}]
		dev-python/firefly[${PYTHON_USEDEP}]
		dev-python/glue-core[${PYTHON_USEDEP}]
		dev-python/h5py[${PYTHON_USEDEP}]
		dev-python/miniballcpp[${PYTHON_USEDEP}]
		dev-python/netcdf4[${PYTHON_USEDEP}]
		dev-python/nose[${PYTHON_USEDEP}]
		dev-python/pandas[${PYTHON_USEDEP}]
		dev-python/pooch[${PYTHON_USEDEP}]
		dev-python/pyyaml[${PYTHON_USEDEP}]
		dev-python/ratarmount[${PYTHON_USEDEP}]
		dev-python/xarray[${PYTHON_USEDEP}]
		sci-libs/cartopy
	)
"

distutils_enable_tests pytest
distutils_enable_sphinx doc/source dev-python/sphinx-bootstrap-theme \
	dev-python/nbsphinx \
	'>dev-python/runnotebook-0.3.1' \
	dev-python/bottle \
	dev-python/h5py \
	dev-python/nose \
	dev-python/pandas \
	dev-python/pooch \
	dev-python/pytest \
	'>=dev-python/pyx-0.15' \
	dev-python/pyyaml

EPYTEST_IGNORE=(
#	Unknown pytest.mark.answer_test
#	Failed: In test_sedov_tunnel: function uses no argument 'axis'
	yt/frontends/gdf/tests/test_outputs_nose.py
)

python_prepare_all() {
	sed -i -e 's/import TarMount/import FuseMount as TarMount/g' yt/utilities/on_demand_imports.py || die

	distutils-r1_python_prepare_all
}

python_compile_all() {
	use doc && { [[ -d ${PN} ]] && { mv {,_}${PN} || die ; } ; cp -r "${S}"{/doc/helper_scripts,} || die ; }
	sphinx_compile_all
	[[ -d _${PN} ]] && { mv {_,}${PN} || die ; }
}

python_test() {
	pushd "${BUILD_DIR}/install/$(python_get_sitedir)" || die
	cp "${S}"/conftest.py . || die
	epytest
	rm conftest.py || die
	popd || die
}
