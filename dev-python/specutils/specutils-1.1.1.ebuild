# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="Python package for astronomy spectral operations"
HOMEPAGE="https://specutils.readthedocs.org/"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"
RESTRICT="!test? ( test )"	# Test phase runs with fails
#RESTRICT="network-sandbox"	# To use intersphinx linking

RDEPEND=">=dev-python/astropy-4.0[${PYTHON_USEDEP}]
	>=dev-python/gwcs-0.12[${PYTHON_USEDEP}]
	dev-python/scipy[${PYTHON_USEDEP}]
"
BDEPEND="dev-python/astropy-helpers[${PYTHON_USEDEP}]
	doc? (
		${RDEPEND}
		dev-python/sphinx-astropy[${PYTHON_USEDEP}]
		media-gfx/graphviz
	)
	test? (
		dev-python/pytest-astropy[${PYTHON_USEDEP}]
		dev-python/matplotlib[${PYTHON_USEDEP}]
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
	use doc && esetup.py build_docs #--no-intersphinx
}

python_install_all() {
	use doc && local HTML_DOCS=( docs/_build/html/. )
	distutils-r1_python_install_all
}
