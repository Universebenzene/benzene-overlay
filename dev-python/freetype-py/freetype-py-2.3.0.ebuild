# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..11} )

inherit distutils-r1

DESCRIPTION="Python binding for the freetype library"
HOMEPAGE="http://freetype-py.readthedocs.org"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="media-libs/freetype:2"
RDEPEND="${DEPEND}"
BDEPEND="dev-python/setuptools_scm[${PYTHON_USEDEP}]
	app-arch/unzip
"

distutils_enable_tests pytest
distutils_enable_sphinx doc dev-python/sphinx_rtd_theme
