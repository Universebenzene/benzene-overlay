# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..10} )

DATA_COM="8c97b4fa3a6c9e6ea072faeed2d49a20585658ba"

inherit distutils-r1 optfeature

DESCRIPTION="Affiliated package for image photometry utilities"
HOMEPAGE="https://photutils.readthedocs.io"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz
	local-datasets? (
		https://github.com/astropy/photutils-datasets/raw/${DATA_COM}/data/M6707HH.fits -> ${P}--M6707HH.fits
		https://github.com/astropy/photutils-datasets/raw/${DATA_COM}/data/SA112-SF1-001R1.fit.gz -> ${P}--SA112-SF1-001R1.fit.gz
		https://github.com/astropy/photutils-datasets/raw/${DATA_COM}/data/SA112-SF1-ra-dec-list.txt -> ${P}--SA112-SF1-ra-dec-list.txt
		https://github.com/astropy/photutils-datasets/raw/${DATA_COM}/data/hst_wfc3ir_f160w_simulated_starfield.fits -> ${P}--hst_wfc3ir_f160w_simulated_starfield.fits
		https://github.com/astropy/photutils-datasets/raw/${DATA_COM}/data/irac_ch1_flight.fits -> ${P}--irac_ch1_flight.fits
		https://github.com/astropy/photutils-datasets/raw/${DATA_COM}/data/irac_ch2_flight.fits -> ${P}--irac_ch2_flight.fits
		https://github.com/astropy/photutils-datasets/raw/${DATA_COM}/data/irac_ch3_flight.fits -> ${P}--irac_ch3_flight.fits
		https://github.com/astropy/photutils-datasets/raw/${DATA_COM}/data/irac_ch4_flight.fits -> ${P}--irac_ch4_flight.fits
		https://github.com/astropy/photutils-datasets/raw/${DATA_COM}/data/spitzer_example_catalog.xml -> ${P}--spitzer_example_catalog.xml
		https://github.com/astropy/photutils-datasets/raw/${DATA_COM}/data/spitzer_example_image.fits -> ${P}--spitzer_example_image.fits
	)
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc intersphinx local-datasets"
RESTRICT="intersphinx? ( network-sandbox )"
REQUIRED_USE="intersphinx? ( doc )
	doc? ( local-datasets )"

DEPEND=">=dev-python/numpy-1.18[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	>=dev-python/astropy-5.0[${PYTHON_USEDEP}]
"
BDEPEND="dev-python/setuptools_scm[${PYTHON_USEDEP}]
	>=dev-python/cython-0.29.22[${PYTHON_USEDEP}]
	dev-python/extension-helpers[${PYTHON_USEDEP}]
	doc? (
		${RDEPEND}
		dev-python/sphinx-astropy[${PYTHON_USEDEP}]
		sci-libs/scikit-learn[${PYTHON_USEDEP}]
		sci-libs/scikit-image[${PYTHON_USEDEP}]
		media-gfx/graphviz
	)
	test? (
		${RDEPEND}
		dev-python/pytest-doctestplus[${PYTHON_USEDEP}]
		dev-python/pytest-remotedata[${PYTHON_USEDEP}]
		dev-python/pytest-astropy-header[${PYTHON_USEDEP}]
		sci-libs/scikit-learn[${PYTHON_USEDEP}]
		sci-libs/scikit-image[${PYTHON_USEDEP}]
		dev-python/gwcs[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
# TODO: Fix this
# NameError: name 'disabled_intersphinx_mapping' is not defined
#distutils_enable_sphinx docs \
#	dev-python/sphinx-astropy \
#	dev-python/scipy \
#	sci-libs/scikit-learn \
#	sci-libs/scikit-image

# Disable intersphinx
#python_prepare_all() {
#	sed -i '/^SPHINXOPTS/s/$/& -D disable_intersphinx=1/' "${S}"/docs/Makefile || die
#	distutils-r1_python_prepare_all
#}

python_prepare_all() {
	use local-datasets && { eapply "${FILESDIR}/"${P}-datasets-use-local.patch; \
		for ldata in "${DISTDIR}"/*--*; do { cp ${ldata} "${S}"/${PN}/datasets/data/${ldata##*--} || die ; } ; done ; }
	distutils-r1_python_prepare_all
}

python_compile_all() {
	if use doc; then
		pushd docs || die
		VARTEXFONTS="${T}"/fonts MPLCONFIGDIR="${T}" PYTHONPATH="${BUILD_DIR}"/install/$(python_get_sitedir) \
			emake "SPHINXOPTS=$(usex intersphinx '' '-D disable_intersphinx=1')" html
		popd || die
		HTML_DOCS=( docs/_build/html/. )
	fi
}

python_test() {
	epytest "${BUILD_DIR}"
}

pkg_postinst() {
	optfeature "power a variety of features in several modules (strongly recommended)" ">=dev-python/scipy-1.6"
	optfeature "power a variety of plotting features (e.g., plotting apertures)" ">=dev-python/matplotlib-3.1"
	optfeature "used in deblend_sources for deblending segmented sources" ">=sci-libs/scikit-image-0.15.0"
	optfeature "used in DBSCANGroup to create star groups" ">=sci-libs/scikit-learn-0.19"
	optfeature "used in make_gwcs to create a simple celestial gwcs object" ">=dev-python/gwcs-0.16"
	optfeature "improves the performance of sigma clipping and other functionality that may require computing statistics on arrays with NaN values" dev-python/bottleneck
	optfeature "display optional progress bars" dev-python/tqdm
}
