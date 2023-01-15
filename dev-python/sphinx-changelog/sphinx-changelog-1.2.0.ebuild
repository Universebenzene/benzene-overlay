# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..11} )

MY_PN=${PN/-/_}
MY_P=${MY_PN}-${PV}

inherit distutils-r1

DESCRIPTION="A changelog renderer for sphinx"
HOMEPAGE="https://sphinx-changelog.readthedocs.io"
SRC_URI="mirror://pypi/${PN:0:1}/${MY_PN}/${MY_P}.tar.gz
	doc? ( https://github.com/OpenAstronomy/sphinx-changelog/raw/v${PV}/changelog/template.rst -> ${P}-template.rst )"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/sphinx[${PYTHON_USEDEP}]
	>=dev-python/towncrier-22.8.0[${PYTHON_USEDEP}]
"
BDEPEND="dev-python/setuptools_scm[${PYTHON_USEDEP}]"

S="${WORKDIR}/${MY_P}"

distutils_enable_tests nose
distutils_enable_sphinx docs dev-python/sphinx-automodapi

python_prepare_all() {
	use doc && { mkdir -p changelog || die ; cp {"${DISTDIR}"/${P}-,"${S}"/changelog/}template.rst || die ; }

	distutils-r1_python_prepare_all
}
