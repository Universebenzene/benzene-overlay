# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 pypi

DESCRIPTION="Python library for solar physics"
HOMEPAGE="https://sunpy.org"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="asdf dask database examples image jpeg2k map net s3 skimage timeseries visualization"
PROPERTIES="test_network"
RESTRICT="test"

DEPEND=">=dev-python/numpy-2.0.0_rc1[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	>=dev-python/astropy-6.0.0[${PYTHON_USEDEP}]
	>=dev-python/packaging-23.0[${PYTHON_USEDEP}]
	>=dev-python/parfive-2.0.0[${PYTHON_USEDEP},ftp]
	>=dev-python/fsspec-2023.3.0[${PYTHON_USEDEP}]
	asdf? (
		>=dev-python/asdf-2.13.0[${PYTHON_USEDEP}]
		>=dev-python/asdf-astropy-0.5.0[${PYTHON_USEDEP}]
	)
	dask? ( >=dev-python/dask-2022.5.2[${PYTHON_USEDEP}] )
	image? ( >=dev-python/scipy-1.10.1[${PYTHON_USEDEP}] )
	jpeg2k? (
		>=dev-python/glymur-0.11.0[${PYTHON_USEDEP}]
		>dev-python/lxml-5.0.0[${PYTHON_USEDEP}]
	)
	map? (
		>=dev-python/contourpy-1.0.1[${PYTHON_USEDEP}]
		>=dev-python/matplotlib-3.6.0[${PYTHON_USEDEP}]
		>=dev-python/mpl-animators-1.0.0[${PYTHON_USEDEP}]
		>=dev-python/reproject-0.10.0[${PYTHON_USEDEP}]
		>dev-python/scipy-1.10.1[${PYTHON_USEDEP}]
	)
	net? (
		>=dev-python/beautifulsoup4-4.11.0[${PYTHON_USEDEP}]
		>=dev-python/drms-0.7.1[${PYTHON_USEDEP}]
		>=dev-python/python-dateutil-2.8.1[${PYTHON_USEDEP}]
		>=dev-python/tqdm-4.64.0[${PYTHON_USEDEP}]
		>=dev-python/zeep-4.1.0[${PYTHON_USEDEP}]
	)
	s3? (
		>=dev-python/s3fs-2023.3.0[${PYTHON_USEDEP}]
		>=dev-python/aiobotocore-1.26.41[${PYTHON_USEDEP},boto3]
	)
	skimage? ( >=dev-python/scikit-image-0.20.0[${PYTHON_USEDEP}] )
	timeseries? (
		>=dev-python/cdflib-1.3.2[${PYTHON_USEDEP}]
		>=dev-python/h5netcdf-1.0.0[${PYTHON_USEDEP}]
		>=dev-python/h5py-3.8.0[${PYTHON_USEDEP}]
		>=dev-python/matplotlib-3.6.0[${PYTHON_USEDEP}]
		>=dev-python/pandas-1.5.0[${PYTHON_USEDEP}]
	)
	visualization? (
		>=dev-python/matplotlib-3.6.0[${PYTHON_USEDEP}]
		>=dev-python/mpl-animators-1.0.0[${PYTHON_USEDEP}]
	)
"

BDEPEND=">=dev-python/setuptools-scm-6.2[${PYTHON_USEDEP}]
	dev-python/extension-helpers[${PYTHON_USEDEP}]
	test? (
		>=dev-python/pytest-astropy-0.11.0[${PYTHON_USEDEP}]
		dev-python/pytest-mock[${PYTHON_USEDEP}]
		>=dev-python/pytest-mpl-0.16[${PYTHON_USEDEP}]
		>=dev-python/pytest-xdist-3.0.2[${PYTHON_USEDEP}]
		dev-python/asdf-astropy[${PYTHON_USEDEP}]
		dev-python/beautifulsoup4[${PYTHON_USEDEP}]
		dev-python/cdflib[${PYTHON_USEDEP}]
		dev-python/dask[${PYTHON_USEDEP}]
		>=dev-python/bokeh-2.4.2[${PYTHON_USEDEP}]
		>=dev-python/jinja2-2.10.3[${PYTHON_USEDEP}]
		dev-python/drms[${PYTHON_USEDEP}]
		dev-python/glymur[${PYTHON_USEDEP}]
		dev-python/h5netcdf[${PYTHON_USEDEP}]
		>=dev-python/hvpy-1.1.0[${PYTHON_USEDEP}]
		>=dev-python/hypothesis-6.0.0[${PYTHON_USEDEP}]
		>=dev-python/jplephem-2.14[${PYTHON_USEDEP}]
		dev-python/lxml[${PYTHON_USEDEP}]
		dev-python/mpl-animators[${PYTHON_USEDEP}]
		dev-python/reproject[${PYTHON_USEDEP}]
		dev-python/s3fs[${PYTHON_USEDEP}]
		dev-python/scikit-image[${PYTHON_USEDEP}]
		dev-python/scipy[${PYTHON_USEDEP}]
		dev-python/zeep[${PYTHON_USEDEP}]
		media-libs/opencv[${PYTHON_USEDEP},python]
	)
"

distutils_enable_tests pytest
# Doc building is really hard to run. Might fix in far future
#distutils_enable_sphinx docs dev-python/sphinx-astropy dev-python/sunpy-sphinx-theme

EPYTEST_IGNORE=(
	# Tests are very slow (From NixOS)
	sunpy/net/tests/test_fido.py
	# spiceypy unavailable
	sunpy/coordinates/tests/test_spice.py
	docs/whatsnew/6.0.rst
)

EPYTEST_DESELECT=(
	sunpy/coordinates/ephemeris.py::sunpy.coordinates.ephemeris.get_horizons_coord
	sunpy/net/dataretriever/sources/goes.py::sunpy.net.dataretriever.sources.goes.SUVIClient
)

#python_install() {
#	rm -r "${BUILD_DIR}"/install/$(python_get_sitedir)/{docs,examples,licenses} || die
#	distutils-r1_python_install
#}

python_install_all() {
	if use examples; then
		docompress -x "/usr/share/doc/${PF}/examples"
		docinto examples
		dodoc -r examples/.
	fi

	distutils-r1_python_install_all
}

python_test() {
	cp "${BUILD_DIR}"/install/$(python_get_sitedir)/${PN}/io/*.so ${PN}/io || die
	epytest --remote-data=any
	rm ${PN}/io/*.so || die
}
