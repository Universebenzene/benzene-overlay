# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1

DESCRIPTION="Toggle page content and collapse admonitions in Sphinx"
HOMEPAGE="https://sphinx-togglebutton.readthedocs.io"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="sphinx"

RDEPEND="dev-python/sphinx[${PYTHON_USEDEP}]
	dev-python/wheel[${PYTHON_USEDEP}]
	sphinx? (
		dev-python/myst-parser[${PYTHON_USEDEP}]
		dev-python/sphinx-book-theme[${PYTHON_USEDEP}]
		dev-python/sphinx-design[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests nose
