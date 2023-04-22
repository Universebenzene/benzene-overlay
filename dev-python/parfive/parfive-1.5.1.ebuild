# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1

DESCRIPTION="A HTTP and FTP parallel file downloader"
HOMEPAGE="https://parfive.readthedocs.io"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ftp"
PROPERTIES="test_network"
RESTRICT="test"

RDEPEND="dev-python/tqdm[${PYTHON_USEDEP}]
	dev-python/aiohttp[${PYTHON_USEDEP}]
	ftp? ( dev-python/aioftp[${PYTHON_USEDEP}] )
"

BDEPEND="dev-python/setuptools-scm[${PYTHON_USEDEP}]
	doc? (
		${RDEPEND}
		media-gfx/graphviz
	)
	test? (
		dev-python/aiofiles[${PYTHON_USEDEP}]
		dev-python/aioftp[${PYTHON_USEDEP}]
		dev-python/pytest-asyncio[${PYTHON_USEDEP}]
		dev-python/pytest-localserver[${PYTHON_USEDEP}]
		dev-python/pytest-socket[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/sphinx-astropy dev-python/sunpy-sphinx-theme
