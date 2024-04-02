# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="A changelog renderer for sphinx"
HOMEPAGE="https://sphinx-changelog.readthedocs.io"
SRC_URI+=" doc? ( https://github.com/OpenAstronomy/sphinx-changelog/raw/v${PV}/changelog/template.rst -> ${P}-template.rst )"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test"	# No usable test phases

RDEPEND="dev-python/sphinx[${PYTHON_USEDEP}]
	dev-python/towncrier[${PYTHON_USEDEP}]
"
BDEPEND="dev-python/setuptools-scm[${PYTHON_USEDEP}]"

#distutils_enable_tests nose
distutils_enable_sphinx docs dev-python/sphinx-automodapi

python_prepare_all() {
	use doc && { mkdir -p changelog || die ; cp {"${DISTDIR}"/${P}-,"${S}"/changelog/}template.rst || die ; }

	distutils-r1_python_prepare_all
}
