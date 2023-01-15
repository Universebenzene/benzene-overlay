# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{9..11} )

inherit distutils-r1

DESCRIPTION="The sphinx theme for Astropy and affiliated packages"
HOMEPAGE="https://github.com/astropy/astropy-sphinx-theme"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RDEPEND=">=dev-python/sphinx-1.6[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
