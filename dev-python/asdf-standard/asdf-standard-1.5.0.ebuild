# Copyright 2022-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="Standards document describing ASDF, Advanced Scientific Data Format"
HOMEPAGE="https://asdf-standard.readthedocs.io"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc intersphinx"
RESTRICT="intersphinx? ( network-sandbox )"
REQUIRED_USE="intersphinx? ( doc )"

BDEPEND="dev-python/setuptools-scm[${PYTHON_USEDEP}]
	doc? ( media-gfx/graphviz )
	test? ( >=dev-python/packaging-16.0[${PYTHON_USEDEP}] )
"
PDEPEND="test? ( >=dev-python/asdf-3.0.0[${PYTHON_USEDEP}] )"

EPYTEST_PLUGINS=( pytest-asdf-plugin )
distutils_enable_tests pytest
distutils_enable_sphinx docs/source '>=dev-python/sphinx-asdf-0.1.4' dev-python/furo

python_prepare_all() {
	use doc && { mkdir -p docs/_static || die ; }

	distutils-r1_python_prepare_all
}
