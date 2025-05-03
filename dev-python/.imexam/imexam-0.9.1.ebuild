# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
#PYTHON_COMPAT=( python3_{10..11} )
PYTHON_COMPAT=( python3_10 )

inherit distutils-r1 optfeature pypi

DESCRIPTION="Position-velocity diagram extractor"
HOMEPAGE="http://pvextractor.readthedocs.io"

LICENSE="BSD"
SLOT="0"
#KEYWORDS="~amd64 ~x86"
IUSE="examples photometry"
#IUSE="doc intersphinx examples"
#RESTRICT="test"	# 1 test failed
#RESTRICT="intersphinx? ( network-sandbox )"
#REQUIRED_USE="intersphinx? ( doc )"

DEPEND="x11-libs/xpa:="
RDEPEND="${DEPEND}
	>=dev-python/numpy-1.14[${PYTHON_USEDEP}]
	>=dev-python/astropy-3.0[${PYTHON_USEDEP}]
	dev-python/matplotlib[${PYTHON_USEDEP}]
	>=dev-python/scipy-0.18[${PYTHON_USEDEP}]
	photometry? ( dev-python/photutils[${PYTHON_USEDEP}] )
"
BDEPEND="dev-python/cython[${PYTHON_USEDEP}]
	dev-python/setuptools-scm[${PYTHON_USEDEP}]
	test? ( dev-python/photutils[${PYTHON_USEDEP}] )
"
#	doc? (
#		${RDEPEND}
#		dev-python/sphinx-astropy[${PYTHON_USEDEP}]
#	)

PATCHES=(
	"${FILESDIR}/${P}-use-system-xpa.patch"
	"${FILESDIR}/${P}-add-tests-subdir-to-copy.patch"
	"${FILESDIR}/${P}-fix-failing-test.patch"
)

distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/sphinx-automodapi dev-python/astropy-sphinx-theme dev-python/pytest-doctestplus

python_prepare_all() {
	sed -i "/doctest/s/sphinx_astropy.ext.doctest/pytest_doctestplus.sphinx.doctestplus/" docs/conf.py || die
#	sed -i "s/AstropyWCS/astropy/" ${PN}/ginga_viewer.py

	distutils-r1_python_prepare_all
}

#python_compile_all() {
#	if use doc; then
#		VARTEXFONTS="${T}"/fonts MPLCONFIGDIR="${T}" PYTHONPATH="${BUILD_DIR}"/install/$(python_get_sitedir) \
#			emake "SPHINXOPTS=$(usex intersphinx '' '-D disable_intersphinx=1')" -C docs html
#		HTML_DOCS=( docs/_build/html/. )
#	fi
#}

python_install_all() {
	if use examples; then
		docompress -x "/usr/share/doc/${PF}/example_notebooks"
		docinto example_notebooks
		dodoc -r example_notebooks/.
	fi

	distutils-r1_python_install_all
}

pkg_postinst() {
	optfeature_header "Provide display support:"
	optfeature "Use Ginga viewer"  dev-python/ginga
	optfeature "Use DS9 viewer" sci-astronomy/ds9-bin
}
