# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="Python library for solar physics"
HOMEPAGE="https://sunpy.org"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="asdf dask database examples image jpeg2k map net timeseries visualization"
PROPERTIES="test_network"
RESTRICT="test"

DEPEND=">=dev-python/numpy-1.21.0[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	>=dev-python/astropy-5.0.6[${PYTHON_USEDEP}]
	>=dev-python/packaging-19.0[${PYTHON_USEDEP}]
	>=dev-python/parfive-2.0.0[${PYTHON_USEDEP},ftp]
	asdf? (
		>=dev-python/asdf-2.8.0[${PYTHON_USEDEP}]
		>=dev-python/asdf-astropy-0.1.1[${PYTHON_USEDEP}]
	)
	dask? ( >=dev-python/dask-2021.4.0[${PYTHON_USEDEP}] )
	database? ( >=dev-python/sqlalchemy-1.3.4[${PYTHON_USEDEP}] )
	image? (
		>dev-python/scipy-1.10.0[${PYTHON_USEDEP}]
		>=dev-python/scikit-image-0.18.0[${PYTHON_USEDEP}]
	)
	jpeg2k? (
		>dev-python/glymur-0.9.5[${PYTHON_USEDEP}]
		>dev-python/lxml-5.0.0[${PYTHON_USEDEP}]
	)
	map? (
		>=dev-python/matplotlib-3.5.0[${PYTHON_USEDEP}]
		>=dev-python/mpl-animators-1.0.0[${PYTHON_USEDEP}]
		dev-python/reproject[${PYTHON_USEDEP}]
		>dev-python/scipy-1.10.0[${PYTHON_USEDEP}]
	)
	net? (
		>=dev-python/beautifulsoup4-4.8.0[${PYTHON_USEDEP}]
		<dev-python/drms-0.7.0[${PYTHON_USEDEP}]
		>=dev-python/python-dateutil-2.8.0[${PYTHON_USEDEP}]
		>=dev-python/tqdm-4.32.1[${PYTHON_USEDEP}]
		>=dev-python/zeep-3.4.0[${PYTHON_USEDEP}]
	)
	timeseries? (
		>dev-python/cdflib-0.4.0[${PYTHON_USEDEP}]
		>=dev-python/h5netcdf-0.11[${PYTHON_USEDEP}]
		>=dev-python/h5py-3.1.0[${PYTHON_USEDEP}]
		>=dev-python/matplotlib-3.5.0[${PYTHON_USEDEP}]
		>=dev-python/pandas-1.2.0[${PYTHON_USEDEP}]
	)
	visualization? (
		>=dev-python/matplotlib-3.5.0[${PYTHON_USEDEP}]
		>=dev-python/mpl-animators-1.0.0[${PYTHON_USEDEP}]
	)
"

BDEPEND=">=dev-python/setuptools-scm-6.2[${PYTHON_USEDEP}]
	dev-python/extension-helpers[${PYTHON_USEDEP}]
	test? (
		dev-python/pytest-arraydiff[${PYTHON_USEDEP}]
		>=dev-python/pytest-doctestplus-0.5[${PYTHON_USEDEP}]
		dev-python/pytest-mock[${PYTHON_USEDEP}]
		>=dev-python/pytest-mpl-0.12[${PYTHON_USEDEP}]
		dev-python/pytest-remotedata[${PYTHON_USEDEP}]
		>=dev-python/pytest-xdist-2.0[${PYTHON_USEDEP}]
		dev-python/asdf-astropy[${PYTHON_USEDEP}]
		dev-python/astroquery[${PYTHON_USEDEP}]
		dev-python/beautifulsoup4[${PYTHON_USEDEP}]
		dev-python/cdflib[${PYTHON_USEDEP}]
		dev-python/drms[${PYTHON_USEDEP}]
		dev-python/glymur[${PYTHON_USEDEP}]
		dev-python/h5netcdf[${PYTHON_USEDEP}]
		>=dev-python/hvpy-1.0.1[${PYTHON_USEDEP}]
		>=dev-python/hypothesis-6.0.0[${PYTHON_USEDEP}]
		dev-python/jplephem[${PYTHON_USEDEP}]
		dev-python/lxml[${PYTHON_USEDEP}]
		dev-python/mpl-animators[${PYTHON_USEDEP}]
		dev-python/pandas[${PYTHON_USEDEP}]
		dev-python/reproject[${PYTHON_USEDEP}]
		dev-python/scikit-image[${PYTHON_USEDEP}]
		dev-python/scipy[${PYTHON_USEDEP}]
		dev-python/sqlalchemy[${PYTHON_USEDEP}]
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
)

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
