# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..11} )

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

RDEPEND=">=dev-python/tqdm-4.27.0[${PYTHON_USEDEP}]
	dev-python/aiohttp[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]
	ftp? ( dev-python/aioftp[${PYTHON_USEDEP}] )
"

BDEPEND="dev-python/setuptools_scm[${PYTHON_USEDEP}]
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
distutils_enable_sphinx docs dev-python/sphinx-automodapi \
	dev-python/sphinx-autodoc-typehints \
	dev-python/sphinx-book-theme \
	dev-python/sphinx_contributors
