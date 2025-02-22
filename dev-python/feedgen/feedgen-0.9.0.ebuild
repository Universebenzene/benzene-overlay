# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1

DESCRIPTION="Python module to generate ATOM feeds, RSS feeds and Podcasts"
HOMEPAGE="https://feedgen.kiesow.be"
SRC_URI="https://github.com/lkiesow/python-feedgen/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD-2 LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-python/lxml-4.2.5[${PYTHON_USEDEP}]
	>=dev-python/python-dateutil-2.8.0[${PYTHON_USEDEP}]
"

DOCS=( readme.rst )

S="${WORKDIR}/python-${P}"

distutils_enable_tests pytest
distutils_enable_sphinx doc

python_prepare_all() {
	use doc && { cp {"${S}","${WORKDIR}"}/readme.rst || die ; }

	distutils-r1_python_prepare_all
}
