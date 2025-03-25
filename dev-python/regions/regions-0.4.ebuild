# Copyright 2020-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi virtualx xdg-utils

DESCRIPTION="Astropy affiliated package for region handling"
HOMEPAGE="http://astropy-regions.readthedocs.io"

SLOT="0"
#KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
LICENSE="BSD"

IUSE="doc test"
#RESTRICT="network-sandbox"
RESTRICT="!test? ( test )"
DEPEND=">=dev-python/numpy-1.9[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	>=dev-python/astropy-1.3[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
"
BDEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/astropy-helpers[${PYTHON_USEDEP}]
	doc? (
		${RDEPEND}
		dev-python/sphinx-astropy[${PYTHON_USEDEP}]
		dev-python/sphinx-rtd-theme[${PYTHON_USEDEP}]
		dev-python/shapely[${PYTHON_USEDEP}]
	)
	test? (
		dev-python/pytest-astropy[${PYTHON_USEDEP}]
		<dev-python/astropy-3.2[${PYTHON_USEDEP}]
		dev-python/matplotlib[${PYTHON_USEDEP}]
	)
"

#distutils_enable_tests setup.py

python_prepare_all() {
	# use astropy-helpers from system
	sed -i -e '/auto_use/s/True/False/' setup.cfg || die
	rm -r astropy_helpers || die
	xdg_environment_reset
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
			esetup.py build_docs
	fi
}

python_test() {
	echo 'backend: Agg' > ${WORKDIR}/matplotlibrc || die
	export MATPLOTLIBRC=${WORKDIR}
	virtx esetup.py test
}

python_install_all() {
	use doc && local HTML_DOCS=( docs/_build/html/. )
	distutils-r1_python_install_all
}
