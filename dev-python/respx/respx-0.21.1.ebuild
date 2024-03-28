# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

DOCS_BUILDER="mkdocs"
DOCS_DEPEND="dev-python/mkdocs-material"
DOCS_AUTODOC=1

inherit distutils-r1 docs

DESCRIPTION="A utility for mocking out the Python HTTPX and HTTP Core libraries"
HOMEPAGE="https://lundberg.github.io/respx"
SRC_URI="https://github.com/lundberg/respx/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-python/httpx-0.21.0[${PYTHON_USEDEP}]"
BDEPEND="test? (
		dev-python/pytest-asyncio[${PYTHON_USEDEP}]
		dev-python/flask[${PYTHON_USEDEP}]
		dev-python/starlette[${PYTHON_USEDEP}]
		dev-python/trio[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

python_prepare_all() {
	use doc && { ln -s "${S}"/mkdocs.y{a,}ml || die ; sed -i '$a use_directory_urls: false' mkdocs.yml || die ; }
	sed -i -e '/--cov/d' setup.cfg || die

	distutils-r1_python_prepare_all
}
