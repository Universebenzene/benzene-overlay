# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{11..13} )

GIT_RAW_URI="https://github.com/zblz/naima/raw/refs/tags/${PV}/docs/_static"

inherit distutils-r1 optfeature pypi

DESCRIPTION="Derivation of non-thermal particle distributions through MCMC spectral fitting"
HOMEPAGE="http://naima.readthedocs.io"
SRC_URI+=" doc? (
		${GIT_RAW_URI}/CrabNebula_SynSSC.png -> ${P}-d-CrabNebula_SynSSC.png
		${GIT_RAW_URI}/RXJ1713_IC_chain_index.png -> ${P}-d-RXJ1713_IC_chain_index.png
		${GIT_RAW_URI}/RXJ1713_IC_chain_cutoff.png -> ${P}-d-RXJ1713_IC_chain_cutoff.png
		${GIT_RAW_URI}/RXJ1713_IC_corner.png -> ${P}-d-RXJ1713_IC_corner.png
		${GIT_RAW_URI}/RXJ1713_IC_model_samples.png -> ${P}-d-RXJ1713_IC_model_samples.png
		${GIT_RAW_URI}/RXJ1713_IC_model_samples_erange.png -> ${P}-d-RXJ1713_IC_model_samples_erange.png
		${GIT_RAW_URI}/RXJ1713_IC_model_confs.png -> ${P}-d-RXJ1713_IC_model_confs.png
		${GIT_RAW_URI}/RXJ1713_IC_model_confs_erange.png -> ${P}-d-RXJ1713_IC_model_confs_erange.png
		${GIT_RAW_URI}/RXJ1713_IC_pdist.png -> ${P}-d-RXJ1713_IC_pdist.png
		${GIT_RAW_URI}/RXJ1713_IC_We.png -> ${P}-d-RXJ1713_IC_We.png
	)
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64" # ds9 <- sherpa no x86 KEYWORD
IUSE="doc examples intersphinx"
RESTRICT="intersphinx? ( network-sandbox )"
REQUIRED_USE="intersphinx? ( doc )"

RDEPEND=">=dev-python/astropy-6.1[${PYTHON_USEDEP}]
	>=dev-python/corner-2.0[${PYTHON_USEDEP}]
	>=dev-python/emcee-3.0[${PYTHON_USEDEP}]
	>=dev-python/h5py-3.14.0[${PYTHON_USEDEP}]
	>=dev-python/matplotlib-3.10.0[${PYTHON_USEDEP}]
	>=dev-python/numpy-2.0[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-6.0.1[${PYTHON_USEDEP}]
	>=dev-python/scipy-1.15.3[${PYTHON_USEDEP}]
"
BDEPEND="dev-python/hatch-vcs[${PYTHON_USEDEP}]
	doc? (
		${RDEPEND}
		dev-python/sphinx-astropy[${PYTHON_USEDEP}]
	)
	test? ( dev-python/sherpa[${PYTHON_USEDEP}] )
"

distutils_enable_tests pytest
#distutils_enable_sphinx docs dev-python/sphinx-astropy

python_prepare_all() {
#	sed -e '/auto_use/s/True/False/' -i setup.cfg || die
	use doc && { for dpg in "${DISTDIR}"/*-d-*png; do { cp ${dpg} "${S}"/docs/_static/${dpg##*-d-} || die ; } ; done ; }

	distutils-r1_python_prepare_all
}

python_compile_all() {
	if use doc; then
		VARTEXFONTS="${T}"/fonts MPLCONFIGDIR="${T}" PYTHONPATH="${BUILD_DIR}"/install/$(python_get_sitedir) \
			emake "SPHINXOPTS=$(usex intersphinx '' '-D disable_intersphinx=1')" -C docs html
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

pkg_postinst() {
	optfeature "using sherpa models" dev-python/sherpa
}
