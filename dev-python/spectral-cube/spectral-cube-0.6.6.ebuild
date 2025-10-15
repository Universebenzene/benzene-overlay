# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi virtualx

DESCRIPTION="Library for reading and analyzing astrophysical spectral data cubes"
HOMEPAGE="https://spectral-cube.readthedocs.io"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"	# no x86 KEYWORD for yt, glueviz
IUSE="doc intersphinx noviz viz viz_extra"
RESTRICT="intersphinx? ( network-sandbox )"
REQUIRED_USE="intersphinx? ( doc )"

RDEPEND=">=dev-python/numpy-1.8.0[${PYTHON_USEDEP}]
	dev-python/astropy[${PYTHON_USEDEP}]
	dev-python/casa-formats-io[${PYTHON_USEDEP}]
	dev-python/dask[${PYTHON_USEDEP}]
	dev-python/joblib[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	>=dev-python/radio-beam-0.3.3[${PYTHON_USEDEP}]
	dev-python/tqdm[${PYTHON_USEDEP}]
	noviz? (
		dev-python/distributed[${PYTHON_USEDEP}]
		dev-python/fsspec[${PYTHON_USEDEP}]
		>=dev-python/reproject-0.9.1[${PYTHON_USEDEP}]
		dev-python/scipy[${PYTHON_USEDEP}]
		<dev-python/zarr-3[${PYTHON_USEDEP}]
	)
	viz? (
		dev-python/aplpy[${PYTHON_USEDEP}]
		dev-python/matplotlib[${PYTHON_USEDEP}]
		dev-python/reproject[${PYTHON_USEDEP}]
	)
"
BDEPEND="dev-python/setuptools-scm[${PYTHON_USEDEP}]
	doc? (
		${RDEPEND}
		dev-python/sphinx-astropy[${PYTHON_USEDEP}]
	)
	test? (
		dev-python/aplpy[${PYTHON_USEDEP}]
		dev-python/bottleneck[${PYTHON_USEDEP}]
		dev-python/matplotlib[${PYTHON_USEDEP}]
		dev-python/qtpy[${PYTHON_USEDEP},svg]
		dev-python/regions[${PYTHON_USEDEP}]
		dev-python/reproject[${PYTHON_USEDEP}]
		<dev-python/zarr-3[${PYTHON_USEDEP}]
	)
"
PDEPEND="noviz? ( dev-python/pvextractor[${PYTHON_USEDEP}] )
	viz? ( dev-python/pvextractor[${PYTHON_USEDEP}] )
	viz_extra? (
		dev-python/glue-qt[${PYTHON_USEDEP}]
		dev-python/yt[${PYTHON_USEDEP}]
	)
	test? (
		dev-python/glue-qt[${PYTHON_USEDEP}]
		dev-python/pvextractor[${PYTHON_USEDEP}]
		dev-python/yt[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=( pytest-astropy-header )
distutils_enable_tests pytest
#distutils_enable_sphinx docs dev-python/sphinx-astropy

python_prepare_all() {
	sed -e 's/glue.viewers.image.qt/glue_qt.viewers.image/' \
		-e "s/glue.app.qt/glue_qt.app/" -i spectral_cube/spectral_cube.py || die
	distutils-r1_python_prepare_all
}

python_compile_all() {
	if use doc; then
		VARTEXFONTS="${T}"/fonts MPLCONFIGDIR="${T}" PYTHONPATH="${BUILD_DIR}"/install/$(python_get_sitedir) \
			emake "SPHINXOPTS=$(usex intersphinx '' '-D disable_intersphinx=1')" -C docs html
		HTML_DOCS=( docs/_build/html/. )
	fi
}

python_test() {
	virtx epytest
}
