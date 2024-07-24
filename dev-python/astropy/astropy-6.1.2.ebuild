# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

DATA_URI="http://www.astropy.org/astropy-data"

inherit distutils-r1 optfeature pypi

DESCRIPTION="Core functionality for performing astrophysics with Python"
HOMEPAGE="https://astropy.org"
SRC_URI+=" doc? (
		${DATA_URI}/tutorials/FITS-Header/input_file.fits -> ${PN}-eo-input_file.fits
		${DATA_URI}/tutorials/FITS-images/HorseHead.fits -> ${PN}-eo-HorseHead.fits
		${DATA_URI}/tutorials/FITS-tables/chandra_events.fits -> ${PN}-eo-chandra_events.fits
		${DATA_URI}/visualization/reprojected_sdss_g.fits.bz2 -> ${PN}-dv-reprojected_sdss_g.fits.bz2
		${DATA_URI}/visualization/reprojected_sdss_r.fits.bz2 -> ${PN}-dv-reprojected_sdss_r.fits.bz2
		${DATA_URI}/visualization/reprojected_sdss_i.fits.bz2 -> ${PN}-dv-reprojected_sdss_i.fits.bz2
		${DATA_URI}/allsky/allsky_rosat.fits -> ${PN}-dvw-allsky_rosat.fits
		${DATA_URI}/galactic_center/gc_bolocam_gps.fits -> ${PN}-dvw-gc_bolocam_gps.fits
		${DATA_URI}/galactic_center/gc_msx_e.fits -> ${PN}-dvw-gc_msx_e.fits
		${DATA_URI}/l1448/l1448_13co.fits -> ${PN}-dvw-l1448_13co.fits
		${DATA_URI}/galactic_center/gc_2mass_k.fits -> ${PN}-dw-gc_2mass_k.fits
		${DATA_URI}/timeseries/kplr010666592-2009131110544_slc.fits -> ${PN}-dt-kplr010666592-2009131110544_slc.fits
	)
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples intersphinx recommended"
PROPERTIES="test_network"
RESTRICT="test
	intersphinx? ( network-sandbox )"
REQUIRED_USE="intersphinx? ( doc )"

DEPEND=">=dev-libs/expat-2.5.0:0=
	>=dev-python/numpy-2.0.0:=[${PYTHON_USEDEP}]
	>=dev-python/pyerfa-2.0.1.1[${PYTHON_USEDEP}]
	>=sci-astronomy/erfa-2.0:0=
	>=sci-astronomy/wcslib-8.3:0=
	>=sci-libs/cfitsio-4.2.0:0=
	sys-libs/zlib:0=
"
RDEPEND="${DEPEND}
	>=dev-python/astropy-iers-data-0.2024.7.1.0.34.3[${PYTHON_USEDEP}]
	dev-python/configobj[${PYTHON_USEDEP}]
	dev-python/ply[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-3.13[${PYTHON_USEDEP}]
	>=dev-python/packaging-19.0[${PYTHON_USEDEP}]
	recommended? (
		>dev-python/matplotlib-3.5.2[${PYTHON_USEDEP}]
		>=dev-python/scipy-1.8[${PYTHON_USEDEP}]
	)
"
BDEPEND=">=dev-python/extension-helpers-1[${PYTHON_USEDEP}]
	>=dev-python/cython-3.0.0[${PYTHON_USEDEP}]
	<dev-python/cython-3.1.0[${PYTHON_USEDEP}]
	>=dev-python/setuptools-scm-6.2[${PYTHON_USEDEP}]
	doc? (
		${RDEPEND}
		>=dev-python/sphinx-astropy-1.9.1[${PYTHON_USEDEP},confv2]
		>=dev-python/sphinx-changelog-1.2.0[${PYTHON_USEDEP}]
		dev-python/sphinx-design[${PYTHON_USEDEP}]
		>=dev-python/sphinxcontrib-globalsubs-0.1.1[${PYTHON_USEDEP}]
		>=dev-python/jinja-3.1.3[${PYTHON_USEDEP}]
		>=dev-python/matplotlib-3.9.1[${PYTHON_USEDEP}]
		>=dev-python/scipy-1.5[${PYTHON_USEDEP}]
		>=dev-python/pytest-7.0[${PYTHON_USEDEP}]
		$(python_gen_cond_dep 'dev-python/tomli[${PYTHON_USEDEP}]' python3_10)
		media-gfx/graphviz
	)
	test? (
		dev-libs/libxml2
		dev-python/beautifulsoup4[${PYTHON_USEDEP}]
		dev-python/bleach[${PYTHON_USEDEP}]
		dev-python/dask[${PYTHON_USEDEP}]
		dev-python/fitsio[${PYTHON_USEDEP}]
		dev-python/h5py[${PYTHON_USEDEP}]
		dev-python/html5lib[${PYTHON_USEDEP}]
		dev-python/ipython[${PYTHON_USEDEP}]
		>=dev-python/jplephem-2.15[${PYTHON_USEDEP}]
		dev-python/matplotlib[${PYTHON_USEDEP}]
		dev-python/mpmath[${PYTHON_USEDEP}]
		dev-python/objgraph[${PYTHON_USEDEP}]
		dev-python/pandas[${PYTHON_USEDEP}]
		>=dev-python/pytest-astropy-0.10[${PYTHON_USEDEP}]
		dev-python/pytest-mpl[${PYTHON_USEDEP}]
		dev-python/pyarrow[${PYTHON_USEDEP},parquet,snappy]
		dev-python/scipy[${PYTHON_USEDEP}]
		dev-python/skyfield[${PYTHON_USEDEP}]
		dev-python/s3fs[${PYTHON_USEDEP}]
		dev-python/threadpoolctl[${PYTHON_USEDEP}]
	)
"

PATCHES=(
	"${FILESDIR}/${PN}-6.0.0-system-configobj.patch"
	"${FILESDIR}/${PN}-6.0.0-system-ply.patch"
)

# TODO: Fix this
# NameError: name 'disabled_intersphinx_mapping' is not defined
#distutils_enable_sphinx docs \
#	dev-python/sphinx-astropy \
#	dev-python/pyyaml \
#	dev-python/scipy \
#	dev-python/pytest

EPYTEST_XDIST=1
distutils_enable_tests pytest

python_prepare_all() {
	rm -r ${PN}/extern/{configobj,ply} || die
	if use doc && ! use intersphinx; then
		for ddv in "${DISTDIR}"/*-dv-*; do { cp ${ddv} "${S}"/docs/visualization/${ddv##*-dv-} || die ; } ; done
		for dvw in "${DISTDIR}"/*-dvw-*; do { cp ${dvw} "${S}"/docs/visualization/wcsaxes/${dvw##*-dvw-} || die ; } ; done
		for ddw in "${DISTDIR}"/*-dw-*; do { cp ${ddw} "${S}"/docs/wcs/${ddw##*-dw-} || die ; } ; done
		for ddt in "${DISTDIR}"/*-dt-*; do { cp ${ddt} "${S}"/docs/timeseries/${ddt##*-dt-} || die ; } ; done
		cp {"${DISTDIR}"/${PN}-eo-,"${S}"/docs/wcs/}HorseHead.fits || die
		cp {"${DISTDIR}"/${PN}-dvw-,"${S}"/docs/convolution/}gc_msx_e.fits || die
		cp {"${DISTDIR}"/${PN}-dvw-,"${S}"/docs/wcs/}l1448_13co.fits || die
		eapply "${FILESDIR}"/${PN}-6.1.0-doc-use-local-data.patch
	fi

	distutils-r1_python_prepare_all
}

python_configure_all() {
	export ASTROPY_USE_SYSTEM_ALL=1
}

python_compile_all() {
	if use doc; then
		VARTEXFONTS="${T}"/fonts MPLCONFIGDIR="${T}" PYTHONPATH="${BUILD_DIR}"/install/$(python_get_sitedir) \
			emake "SPHINXOPTS=$(usex intersphinx '' '-D disable_intersphinx=1')" -C docs html
		cp -r docs/{_static/*,_build/html/_static} || die
		cp -r docs/{_static/*,_build/html/_images} || die
		HTML_DOCS=( docs/_build/html/. )
	fi
}

python_install_all() {
	if use examples; then
		docompress -x "/usr/share/doc/${PF}/examples"
		docinto examples
		dodoc -r examples/.
	fi

	distutils-r1_python_install_all
}

python_test() {
	pushd "${BUILD_DIR}/install/$(python_get_sitedir)" || die
	epytest --remote-data --run-slow
	popd || die
}

pkg_postinst() {
	optfeature "power a variety of features in several modules" ">=dev-python/scipy-1.8"
	optfeature "read/write Table objects from/to HDF5 files" dev-python/h5py
	optfeature "read Table objects from HTML files" dev-python/beautifulsoup4
	optfeature "read Table objects from HTML files using the pandas reader" dev-python/html5lib
	optfeature "Used to sanitize text when disabling HTML escaping in the Table HTML writer" dev-python/bleach
	optfeature "validate VOTABLE XML files. This is a command line tool installed outside of Python" dev-libs/libxml2
	optfeature "convert Table objects from/to pandas DataFrame objects" dev-python/pandas
	optfeature "Faster SCEngine indexing engine with Table, although this may still be slower in some cases than the \
default indexing engine" dev-python/sortedcontainers
	optfeature "specify and convert between timezones" dev-python/pytz
	optfeature "retrieve JPL ephemeris of Solar System objects" dev-python/jplephem
	optfeature "provide plotting functionality that astropy.visualization enhances" ">dev-python/matplotlib-3.5.2"
	optfeature "discovery of entry points which are used to insert fitters into astropy.modeling.fitting" dev-python/setuptools
	optfeature "the ‘kraft-burrows-nousek’ interval in poisson_conf_interval" dev-python/mpmath
	optfeature "Enables the serialization of various Astropy classes into a portable, hierarchical, human-readable \
representation" ">=dev-python/asdf-astropy-0.3"
	optfeature "Improves the performance of sigma-clipping and other functionality that may require computing statistics \
on arrays with NaN values." dev-python/bottleneck
	optfeature "downloading files from HTTPS or FTP+TLS sites in case Python is not able to locate up-to-date root CA \
certificates on your system; this package is usually already included in many Python installations (e.g., as a dependency of \
the requests package)." dev-python/certifi
	optfeature "Enables access to subsets of remote FITS files without having to download the entire file" \
">=dev-python/fsspec-2023.4.0"
	optfeature "Enables access to files hosted in AWS S3 cloud storage" ">=dev-python/s3fs-2023.4.0"
	optfeature "testing with Matplotlib figures" dev-python/pytest-mpl
	optfeature "code coverage measurements" dev-python/coverage
	optfeature "automate testing and documentation builds" dev-python/tox
	optfeature "testing Solar System coordinates" dev-python/skyfield
	optfeature "testing satellite positions" dev-python/sgp4
	optfeature "reading/writing Table objects from/to Parquet files." ">=dev-python/pyarrow-5.0.0[parquet,snappy]"
}
