# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python{2_7,3_{10..12}} )

inherit distutils-r1 pypi

DESCRIPTION="Python wrapper for the Montage mosaicking toolkit"
HOMEPAGE="http://www.astropy.org/montage-wrapper/"

LICENSE="BSD"
SLOT="0"
#KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc"
RESTRICT="!test? ( test )"

RDEPEND="dev-python/astropy[${PYTHON_USEDEP}]
	sci-astronomy/montage
"
BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/astropy-helpers[${PYTHON_USEDEP}]
	doc? (
		${RDEPEND}
		<dev-python/astropy-helpers-3.2[${PYTHON_USEDEP}]
		<dev-python/sphinx-2.0[${PYTHON_USEDEP}]
		media-gfx/graphviz
	)
	test? (
		<dev-python/astropy-helpers-3.2[${PYTHON_USEDEP}]
		dev-python/pytest-astropy[${PYTHON_USEDEP}]
		<dev-python/astropy-3.2[${PYTHON_USEDEP}]
		sci-astronomy/montage
	)
"

distutils_enable_tests setup.py

python_prepare_all() {
	# use system astropy-helpers instead of bundled one
	sed -i -e '/auto_use/s/True/False/' setup.cfg || die
	sed -i -e '/[pytest]/s/pytest/tool:pytest/' setup.cfg || die
	export mydistutilsargs=( --offline )
	distutils-r1_python_prepare_all
}

python_compile() {
	distutils-r1_python_compile --use-system-libraries
}

python_compile_all() {
	if use doc; then
		esetup.py build_docs --no-intersphinx
		HTML_DOCS=( docs/_build/html/. )
	fi
}
