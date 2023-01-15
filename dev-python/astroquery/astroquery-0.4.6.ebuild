# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{9..10} )

inherit distutils-r1 optfeature

DESCRIPTION="Collection of packages to access online astronomical resources"
HOMEPAGE="https://astroquery.readthedocs.io"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc intersphinx"
RESTRICT="intersphinx? ( network-sandbox )"
REQUIRED_USE="intersphinx? ( doc )"

RDEPEND=">=dev-python/astropy-4.0[${PYTHON_USEDEP}]
	>=dev-python/beautifulsoup4-4.3.2[${PYTHON_USEDEP}]
	>=dev-python/html5lib-0.999[${PYTHON_USEDEP}]
	>=dev-python/keyring-4.0[${PYTHON_USEDEP}]
	>=dev-python/requests-2.4.3[${PYTHON_USEDEP}]
	>=dev-python/pyvo-1.1[${PYTHON_USEDEP}]
"
BDEPEND=">=dev-python/astropy-helpers-4.0.1[${PYTHON_USEDEP}]
	doc? (
		${RDEPEND}
		>=dev-python/sphinx-astropy-1.2[${PYTHON_USEDEP}]
		dev-python/scipy[${PYTHON_USEDEP}]
		media-gfx/graphviz
	)
	test? (
		${RDEPEND}
		dev-python/pytest-astropy[${PYTHON_USEDEP}]
		dev-python/pytest-mock[${PYTHON_USEDEP}]
		dev-python/toml[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests setup.py

python_prepare_all() {
	sed -i -e '/auto_use/s/True/False/' setup.cfg || die
	DISTUTILS_ARGS=( --offline )
	distutils-r1_python_prepare_all
}

python_compile() {
	distutils-r1_python_compile --use-system-libraries
}

python_compile_all() {
	if use doc; then
		python_setup
		VARTEXFONTS="${T}"/fonts \
			MPLCONFIGDIR="${BUILD_DIR}" \
			PYTHONPATH="${BUILD_DIR}"/lib \
			esetup.py build_docs $(usex intersphinx '' '--no-intersphinx')
	fi
}

python_install_all() {
	use doc && local HTML_DOCS=( docs/_build/html/. )
	distutils-r1_python_install_all
}

pkg_postinst() {
	optfeature "running the tests"							dev-python/pytest-astropy
	optfeature "the full functionality of the alma module"	dev-python/aplpy dev/pyregion
	optfeature "the full functionality of the cds module"	dev-python/astropy-healpix dev/regions
	optfeature "the full functionality of the mast module"	dev-python/boto3
}
