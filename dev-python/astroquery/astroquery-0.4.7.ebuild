# Copyright 2020-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_SETUPTOOLS=bdepend
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 optfeature pypi

DESCRIPTION="Collection of packages to access online astronomical resources"
HOMEPAGE="https://astroquery.readthedocs.io"
SRC_URI+=" doc? ( https://irsa.ipac.caltech.edu/data/SPITZER/Enhanced/SEIP/images/6/0095/60095931/4/60095931-14/60095931.60095931-14.IRAC.4.mosaic.fits )"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc intersphinx"
RESTRICT="intersphinx? ( network-sandbox )"
REQUIRED_USE="intersphinx? ( doc )"

RDEPEND=">=dev-python/astropy-4.2.1[${PYTHON_USEDEP}]
	>=dev-python/beautifulsoup4-4.8[${PYTHON_USEDEP}]
	>=dev-python/html5lib-0.999[${PYTHON_USEDEP}]
	>=dev-python/keyring-15.0[${PYTHON_USEDEP}]
	>=dev-python/numpy-1.18[${PYTHON_USEDEP}]
	>=dev-python/pyvo-1.1[${PYTHON_USEDEP}]
	>=dev-python/requests-2.19[${PYTHON_USEDEP}]
"
BDEPEND=">=dev-python/astropy-helpers-4.0.1[${PYTHON_USEDEP}]
	doc? (
		${RDEPEND}
		>=dev-python/sphinx-astropy-1.2[${PYTHON_USEDEP}]
		dev-python/aiohttp[${PYTHON_USEDEP}]
		dev-python/fsspec[${PYTHON_USEDEP}]
		dev-python/scipy[${PYTHON_USEDEP}]
		media-gfx/graphviz
	)
	test? (
		${RDEPEND}
		dev-python/pytest-astropy[${PYTHON_USEDEP}]
		dev-python/regions[${PYTHON_USEDEP}]
		net-misc/curl
	)
"

distutils_enable_tests setup.py

python_prepare_all() {
	sed -i -e '/auto_use/s/True/False/' setup.cfg || die
	DISTUTILS_ARGS=( --offline )
	use doc && { use intersphinx || { eapply "${FILESDIR}"/${P}-doc-irsa-offline.patch ; \
		cp "${DISTDIR}"/*.fits docs/ipac/irsa || die ; } ; }
	distutils-r1_python_prepare_all
}

python_compile() {
	distutils-r1_python_compile --use-system-libraries
}

python_compile_all() {
	if use doc; then
		VARTEXFONTS="${T}"/fonts MPLCONFIGDIR="${T}" PYTHONPATH="${BUILD_DIR}"/lib \
			emake "SPHINXOPTS=$(usex intersphinx '' '-D disable_intersphinx=1')" -C docs html
		HTML_DOCS=( docs/_build/html/. )
	fi
}

pkg_postinst() {
	optfeature "running the tests" "dev-python/pytest-astropy net-misc/curl"
	optfeature "the full functionality of the mocserver, alma, and xmatch module" "dev-python/astropy-healpix dev-python/regions"
	optfeature "the full functionality of the mast module"	dev-python/boto3
}
