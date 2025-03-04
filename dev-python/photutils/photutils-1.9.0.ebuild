# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

DATA_COM="8c97b4f"
DATA_URI="https://github.com/astropy/photutils-datasets/raw/${DATA_COM}/data"

inherit distutils-r1 optfeature pypi

DESCRIPTION="Affiliated package for image photometry utilities"
HOMEPAGE="https://photutils.readthedocs.io"
SRC_URI+=" local-datasets? (
		${DATA_URI}/M6707HH.fits -> ${PN}-${DATA_COM}-d-M6707HH.fits
		${DATA_URI}/SA112-SF1-001R1.fit.gz -> ${PN}-${DATA_COM}-d-SA112-SF1-001R1.fit.gz
		${DATA_URI}/SA112-SF1-ra-dec-list.txt -> ${PN}-${DATA_COM}-d-SA112-SF1-ra-dec-list.txt
		${DATA_URI}/hst_wfc3ir_f160w_simulated_starfield.fits -> ${PN}-${DATA_COM}-d-hst_wfc3ir_f160w_simulated_starfield.fits
		${DATA_URI}/irac_ch1_flight.fits -> ${PN}-${DATA_COM}-d-irac_ch1_flight.fits
		${DATA_URI}/irac_ch2_flight.fits -> ${PN}-${DATA_COM}-d-irac_ch2_flight.fits
		${DATA_URI}/irac_ch3_flight.fits -> ${PN}-${DATA_COM}-d-irac_ch3_flight.fits
		${DATA_URI}/irac_ch4_flight.fits -> ${PN}-${DATA_COM}-d-irac_ch4_flight.fits
		${DATA_URI}/spitzer_example_catalog.xml -> ${PN}-${DATA_COM}-d-spitzer_example_catalog.xml
		${DATA_URI}/spitzer_example_image.fits -> ${PN}-${DATA_COM}-d-spitzer_example_image.fits
	)
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="all doc intersphinx local-datasets"
PROPERTIES="test_network"
RESTRICT="test
	intersphinx? ( network-sandbox )"
REQUIRED_USE="intersphinx? ( doc )
	doc? ( local-datasets )"

DEPEND=">=dev-python/numpy-1.22[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	>=dev-python/astropy-5.0[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	all? (
		dev-python/bottleneck[${PYTHON_USEDEP}]
		>=dev-python/gwcs-0.18[${PYTHON_USEDEP}]
		>=dev-python/matplotlib-3.5.0[${PYTHON_USEDEP}]
		dev-python/rasterio[${PYTHON_USEDEP}]
		>=dev-python/scipy-1.7.0[${PYTHON_USEDEP}]
		>=dev-python/scikit-image-0.19.0[${PYTHON_USEDEP}]
		>=dev-python/scikit-learn-1.0[${PYTHON_USEDEP}]
		dev-python/shapely[${PYTHON_USEDEP}]
		dev-python/tqdm[${PYTHON_USEDEP}]
	)
"
BDEPEND=">=dev-python/setuptools-scm-6.2[${PYTHON_USEDEP}]
	>=dev-python/cython-0.29.30[${PYTHON_USEDEP}]
	dev-python/extension-helpers[${PYTHON_USEDEP}]
	doc? (
		${RDEPEND}
		dev-python/sphinx-astropy[${PYTHON_USEDEP}]
		dev-python/rasterio[${PYTHON_USEDEP}]
		dev-python/scikit-image[${PYTHON_USEDEP}]
		media-gfx/graphviz
	)
	test? (
		dev-python/pytest-astropy-header[${PYTHON_USEDEP}]
		dev-python/pytest-doctestplus[${PYTHON_USEDEP}]
		dev-python/pytest-remotedata[${PYTHON_USEDEP}]
		dev-python/scikit-learn[${PYTHON_USEDEP}]
		dev-python/scikit-image[${PYTHON_USEDEP}]
		dev-python/gwcs[${PYTHON_USEDEP}]
		dev-python/rasterio[${PYTHON_USEDEP}]
		dev-python/shapely[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
# TODO: Fix this
# NameError: name 'disabled_intersphinx_mapping' is not defined
#distutils_enable_sphinx docs \
#	dev-python/sphinx-astropy \
#	dev-python/scipy \
#	dev-python/scikit-learn \
#	dev-python/scikit-image

# Disable intersphinx
#python_prepare_all() {
#	sed -i '/^SPHINXOPTS/s/$/& -D disable_intersphinx=1/' "${S}"/docs/Makefile || die
#	distutils-r1_python_prepare_all
#}

python_prepare_all() {
	use local-datasets && { eapply "${FILESDIR}/"${PN}-1.6.0-datasets-use-local.patch; mkdir -p ${PN}/datasets/data ; \
		for ldata in "${DISTDIR}"/*-d-*; do { cp ${ldata} "${S}"/${PN}/datasets/data/${ldata##*-d-} || die ; } ; done ; }
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
	epytest "${BUILD_DIR}" --remote-data=any
}

pkg_postinst() {
	optfeature "power a variety of features in several modules (strongly recommended)" ">=dev-python/scipy-1.7.0"
	optfeature "power a variety of plotting features (e.g., plotting apertures)" ">=dev-python/matplotlib-3.5.0"
	optfeature "deblending segmented sources" ">=dev-python/scikit-image-0.19.0"
	optfeature "used in the deprecated DBSCANGroup to create star groups" ">=dev-python/scikit-learn-1.0"
	optfeature "used in make_gwcs to create a simple celestial gwcs object" ">=dev-python/gwcs-0.18"
	optfeature "improves the performance of sigma clipping and other functionality that may require computing statistics on arrays with NaN values" dev-python/bottleneck
	optfeature "display optional progress bars" dev-python/tqdm
	optfeature "Used for converting source segments into polygon objects" dev-python/rasterio dev-python/shapely
}
