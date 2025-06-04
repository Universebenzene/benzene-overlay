# Copyright 2020-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python{2_7,3_{10..12}} )

DISTUTILS_USE_SETUPTOOLS=rdepend
inherit distutils-r1 virtualx optfeature pypi

DESCRIPTION="Observation planning package for astronomers"
HOMEPAGE="https://astroplan.readthedocs.org"

LICENSE="BSD"
SLOT="0"
#KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc test"
#RESTRICT="network-sandbox"
RESTRICT="!test? ( test )"

RDEPEND=">=dev-python/astropy-1.3[${PYTHON_USEDEP}]
	dev-python/pytz[${PYTHON_USEDEP}]
"
BDEPEND=">=dev-python/astropy-helpers-2.0.11[${PYTHON_USEDEP}]
	doc? (
		${RDEPEND}
		dev-python/sphinx-astropy[${PYTHON_USEDEP}]
		dev-python/sphinx-rtd-theme[${PYTHON_USEDEP}]
		media-gfx/graphviz
	)
	test? (
		${RDEPEND}
		dev-python/pytest-astropy[${PYTHON_USEDEP}]
		dev-python/pytest-mpl[${PYTHON_USEDEP}]
	)"

PATCHES=( "${FILESDIR}"/${P}-fix-doc-index-astropy-link.patch )

REQUIRED_USE="test? ( || ( $(python_gen_useflags 'python3*') ) )"

#distutils_enable_tests setup.py

python_prepare_all() {
	# use system astropy-helpers instead of bundled one
	sed -i -e '/auto_use/s/True/False/' setup.cfg || die
	export mydistutilsargs=( --offline )
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
			esetup.py build_docs --no-intersphinx
	fi
}

python_test() {
	echo 'backend: Agg' > "${WORKDIR}"/matplotlibrc || die
	MATPLOTLIBRC="${WORKDIR}" virtx esetup.py test
}

python_install_all() {
	use doc && local HTML_DOCS=( docs/_build/html/. )
	distutils-r1_python_install_all
}

pkg_postinst() {
	optfeature "testing"			dev-python/pytest-astropy
	optfeature "full functionality"	dev-python/matplotlib dev/astroquery
}
