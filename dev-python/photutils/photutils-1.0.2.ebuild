# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )

inherit distutils-r1

DESCRIPTION="Affiliated package for image photometry utilities"
HOMEPAGE="https://photutils.readthedocs.io"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"
RESTRICT="!test? ( test )"	# Test phase runs with fails
#RESTRICT="network-sandbox"	# To use intersphinx linking

RDEPEND=">=dev-python/astropy-4.0[${PYTHON_USEDEP}]
	>=dev-python/numpy-1.17[${PYTHON_USEDEP}]
"
BDEPEND="dev-python/setuptools_scm[${PYTHON_USEDEP}]
	>=dev-python/cython-0.28[${PYTHON_USEDEP}]
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
		dev-python/pytest-astropy-header[${PYTHON_USEDEP}]
		sci-libs/scikit-learn[${PYTHON_USEDEP}]
		sci-libs/scikit-image[${PYTHON_USEDEP}]
		dev-python/gwcs[${PYTHON_USEDEP}]
	)
"

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

python_compile_all() {
	if use doc; then
		pushd docs || die
		VARTEXFONTS="${T}"/fonts MPLCONFIGDIR="${T}" PYTHONPATH="${BUILD_DIR}"/lib \
			emake html
		popd || die
		HTML_DOCS=( docs/_build/html/. )
	fi
}

python_test() {
	pytest -vv "${BUILD_DIR}/lib" || die "Tests fail with ${EPYTHON}"
}

pkg_postinst() {
	optfeature "power a variety of features in several modules (strongly recommended)" ">=dev-python/scipy-0.19"
	optfeature "power a variety of plotting features (e.g., plotting apertures)" ">=dev-python/matplotlib-2.2"
	optfeature "used in deblend_sources for deblending segmented sources" ">=sys-libs/scikit-image-0.14.2"
	optfeature "used in DBSCANGroup to create star groups" ">=sys-libs/scikit-learn-0.19"
	optfeature "used in make_gwcs to create a simple celestial gwcs object" ">=dev-python/gwcs-0.12"
}
