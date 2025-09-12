# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1

DESCRIPTION="An mdformat plugin for rendering tables"
HOMEPAGE="https://github.com/hukkin/mdformat-tables"
SRC_URI="https://github.com/hukkin/mdformat-tables/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-python/mdformat-0.7.5[${PYTHON_USEDEP}]
	>=dev-python/wcwidth-0.2.13[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
