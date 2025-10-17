# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

TMASS_IM_URI="https://irsa.ipac.caltech.edu:443/cgi-bin/2MASS/IM"

inherit distutils-r1 optfeature pypi

DESCRIPTION="Reproject astronomical images with Python"
HOMEPAGE="https://reproject.readthedocs.io"
SRC_URI+=" doc? ( http://data.astropy.org/galactic_center/gc_2mass_k.fits
		http://data.astropy.org/galactic_center/gc_msx_e.fits
		http://data.astropy.org/allsky/ligo_simulated.fits.gz
		${TMASS_IM_URI}/nph-im?ds=asky&atdir=/ti05&dh=990502s&scan=135&name=ki1350080.fits -> ki1350080.fits
		${TMASS_IM_URI}/nph-im?ds=asky&atdir=/ti05&dh=990502s&scan=135&name=ki1350092.fits -> ki1350092.fits
		${TMASS_IM_URI}/nph-im?ds=asky&atdir=/ti05&dh=990502s&scan=142&name=ki1420186.fits -> ki1420186.fits
		${TMASS_IM_URI}/nph-im?ds=asky&atdir=/ti05&dh=990502s&scan=142&name=ki1420198.fits -> ki1420198.fits
		${TMASS_IM_URI}/nph-im?ds=asky&atdir=/ti05&dh=990502s&scan=143&name=ki1430080.fits -> ki1430080.fits
		${TMASS_IM_URI}/nph-im?ds=asky&atdir=/ti05&dh=990502s&scan=143&name=ki1430092.fits -> ki1430092.fits
		${TMASS_IM_URI}/nph-im?ds=asky&atdir=/ti05&dh=990502s&scan=144&name=ki1440186.fits -> ki1440186.fits
		${TMASS_IM_URI}/nph-im?ds=asky&atdir=/ti05&dh=990502s&scan=144&name=ki1440198.fits -> ki1440198.fits
	)
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="all doc intersphinx"
PROPERTIES="test_network"
RESTRICT="test
	intersphinx? ( network-sandbox )"
REQUIRED_USE="intersphinx? ( doc )"

DEPEND=">=dev-python/numpy-2:=[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	>=dev-python/astropy-5.0[${PYTHON_USEDEP}]
	>=dev-python/astropy-healpix-1.0[${PYTHON_USEDEP}]
	>=dev-python/dask-2021.8[${PYTHON_USEDEP}]
	>=dev-python/fsspec-2021.8[${PYTHON_USEDEP}]
	>=dev-python/pillow-10.0[${PYTHON_USEDEP}]
	>=dev-python/pyavm-0.9.6[${PYTHON_USEDEP}]
	>=dev-python/scipy-1.9[${PYTHON_USEDEP}]
	>=dev-python/zarr-2.11.0[${PYTHON_USEDEP}]
	all? ( dev-python/shapely[${PYTHON_USEDEP}] )
"
BDEPEND="dev-python/setuptools-scm[${PYTHON_USEDEP}]
	>=dev-python/cython-3.1[${PYTHON_USEDEP}]
	>=dev-python/extension-helpers-1[${PYTHON_USEDEP}]
	doc? (
		${RDEPEND}
		dev-python/sphinx-astropy[${PYTHON_USEDEP}]
		dev-python/pyvo[${PYTHON_USEDEP}]
	)
	test? (
		dev-python/gwcs[${PYTHON_USEDEP}]
		dev-python/matplotlib[${PYTHON_USEDEP}]
		dev-python/mpl-animators[${PYTHON_USEDEP}]
		>=dev-python/sunpy-6.0.1[${PYTHON_USEDEP}]
		dev-python/shapely[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=( pytest-{arraydiff,astropy-header,doctestplus,remotedata} )
distutils_enable_tests pytest
#distutils_enable_sphinx docs dev-python/sphinx-astropy dev-python/pyvo

python_prepare_all() {
	use doc && { eapply "${FILESDIR}"/0002-${PN}-0.7.1-doc-use-local-fits.patch ; cp "${DISTDIR}"/*.fits* "${S}"/docs || die ; }
#	sed -i "/NaNs/a \	ignore:Subclassing validator classes is not intended:DeprecationWarning" setup.cfg || die
	use test && { sed -e "/# dimensions/a \    caplog.set_level(logging.INFO)" \
					-e "/import pytest/a import logging" -i "${PN}"/interpolation/tests/test_core.py || die ; }

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
	epytest "${BUILD_DIR}" --remote-data
}

pkg_postinst() {
	optfeature "some of the mosaicking functionality" ">=dev-python/shapely-1.6"
}
