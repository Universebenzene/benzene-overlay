# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..10} )

inherit distutils-r1

DESCRIPTION="The sphinx theme for the SunPy website and documentation"
HOMEPAGE="https://github.com/sunpy/sunpy-sphinx-theme"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/sphinx[${PYTHON_USEDEP}]
	dev-python/sphinx-bootstrap-theme[${PYTHON_USEDEP}]
"
BDEPEND="dev-python/setuptools_scm[$PYTHON_USEDEP]"

distutils_enable_tests nose
