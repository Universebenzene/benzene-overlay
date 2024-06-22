# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

DATA_COM="dcba1c6"
DATA_URI="https://github.com/astropy/specreduce-data/raw/${DATA_COM}/specreduce_data/reference_data"

inherit distutils-r1 pypi

DESCRIPTION="Astropy coordinated package for Spectroscopic Reductions"
HOMEPAGE="https://specreduce.readthedocs.io"
SRC_URI+=" doc? (
		${DATA_URI}/extinction/atm_trans_am1.0.dat -> ${PN}-${DATA_COM}-d-atm_trans_am1.0.dat
		${DATA_URI}/extinction/kpnoextinct.dat -> ${PN}-${DATA_COM}-d-kpnoextinct.dat
		${DATA_URI}/extinction/ctioextinct.dat -> ${PN}-${DATA_COM}-d-ctioextinct.dat
		${DATA_URI}/extinction/apoextinct.dat -> ${PN}-${DATA_COM}-d-apoextinct.dat
		${DATA_URI}/extinction/lapalmaextinct.dat -> ${PN}-${DATA_COM}-d-lapalmaextinct.dat
		${DATA_URI}/extinction/mkoextinct.dat -> ${PN}-${DATA_COM}-d-mkoextinct.dat
		${DATA_URI}/extinction/mthamextinct.dat -> ${PN}-${DATA_COM}-d-mthamextinct.dat
		${DATA_URI}/extinction/paranalextinct.dat -> ${PN}-${DATA_COM}-d-paranalextinct.dat
		${DATA_URI}/onedstds/snfactory/LTT9491.dat -> ${PN}-${DATA_COM}-d-LTT9491.dat
		${DATA_URI}/onedstds/eso/ctiostan/ltt9491.dat -> ${PN}-${DATA_COM}-d-ltt9491.dat
		https://archive.stsci.edu/hlsps/reference-atlases/cdbs/calspec/agk_81d266_stisnic_007.fits
		https://archive.stsci.edu/hlsps/reference-atlases/cdbs/calspec/ltt9491_002.fits
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

RDEPEND="dev-python/astropy[${PYTHON_USEDEP}]
	dev-python/gwcs[${PYTHON_USEDEP}]
	dev-python/scipy[${PYTHON_USEDEP}]
	>=dev-python/specutils-1.9.1[${PYTHON_USEDEP}]
	all? (
		dev-python/matplotlib[${PYTHON_USEDEP}]
		dev-python/photutils[${PYTHON_USEDEP}]
		dev-python/synphot[${PYTHON_USEDEP}]
	)
"
BDEPEND="dev-python/setuptools-scm[${PYTHON_USEDEP}]
	doc? (
		${RDEPEND}
		dev-python/sphinx-astropy[${PYTHON_USEDEP}]
		dev-python/photutils[${PYTHON_USEDEP}]
		dev-python/synphot[${PYTHON_USEDEP}]
	)
	test? (
		dev-python/pytest-astropy-header[${PYTHON_USEDEP}]
		dev-python/pytest-doctestplus[${PYTHON_USEDEP}]
		dev-python/pytest-remotedata[${PYTHON_USEDEP}]
		dev-python/photutils[${PYTHON_USEDEP}]
		dev-python/synphot[${PYTHON_USEDEP}]
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
	use doc && { eapply "${FILESDIR}/"${P}-doc-use-local-data.patch; cp "${DISTDIR}"/*.fits "${S}"/docs || die ; \
		for dat in "${DISTDIR}"/*-d-*; do { cp ${dat} "${S}"/docs/${dat##*-d-} || die ; } ; done ; }
	distutils-r1_python_prepare_all
}

python_install() {
	distutils-r1_python_install
	rm -r "${ED%/}"/$(python_get_sitedir)/{docs,licenses} || die
}

python_compile_all() {
	if use doc; then
		VARTEXFONTS="${T}"/fonts MPLCONFIGDIR="${T}" PYTHONPATH="${BUILD_DIR}"/install/$(python_get_sitedir) \
			emake "SPHINXOPTS=$(usex intersphinx '' '-D disable_intersphinx=1')" -C docs html
		HTML_DOCS=( docs/_build/html/. )
	fi
}

python_test() {
	use doc && local EPYTEST_IGNORE=( docs/_build )
	epytest --remote-data
}
