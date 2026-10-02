# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="The sphinx theme for the SunPy website and documentation"
HOMEPAGE="https://docs.sunpy.org/projects/sunpy-sphinx-theme"
SRC_URI="https://github.com/sunpy/sunpy-sphinx-theme/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
REQUIRED_USE="test? ( doc )"

RDEPEND=">=dev-python/sphinx-7.3.0[${PYTHON_USEDEP}]
	dev-python/pydata-sphinx-theme[${PYTHON_USEDEP}]
	>=dev-python/sphinxext-opengraph-0.13[${PYTHON_USEDEP}]
"
BDEPEND=">=dev-python/setuptools-scm-6.2[$PYTHON_USEDEP]
	doc? ( media-gfx/graphviz )
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/sphinx-automodapi \
	dev-python/sphinx-copybutton \
	dev-python/sphinx-design \
	dev-python/sphinx-gallery \
	dev-python/sphinx-togglebutton \
	dev-python/sphinxext-opengraph \
	dev-python/pydata-sphinx-theme \
	dev-python/matplotlib \
	dev-python/sunpy

export SETUPTOOLS_SCM_PRETEND_VERSION=${PV}

EPYTEST_IGNORE=(
	src/sunpy_sphinx_theme/tests/test_a11y.py
)

python_prepare_all() {
	install -Dm644 {"${FILESDIR}"/${P}-,"src/${PN//-/_}.egg-info"/}SOURCES.txt || die

	distutils-r1_python_prepare_all
}
