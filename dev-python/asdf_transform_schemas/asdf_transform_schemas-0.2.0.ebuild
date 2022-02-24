# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="ASDF schemas for transforms"
HOMEPAGE="https://github.com/asdf-format/asdf-transform-schemas"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RDEPEND="$(python_gen_cond_dep '
		>=dev-python/importlib_resources-3[${PYTHON_USEDEP}]
	' python3_8)"
PDEPEND="dev-python/asdf[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
