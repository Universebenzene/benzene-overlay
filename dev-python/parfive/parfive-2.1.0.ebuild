# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 optfeature pypi

DESCRIPTION="A HTTP and FTP parallel file downloader"
HOMEPAGE="https://parfive.readthedocs.io"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ftp"
PROPERTIES="test_network"
RESTRICT="test"

RDEPEND=">=dev-python/tqdm-4.27.0[${PYTHON_USEDEP}]
	dev-python/aiohttp[${PYTHON_USEDEP}]
	ftp? ( >=dev-python/aioftp-0.17.1[${PYTHON_USEDEP}] )
"

BDEPEND="dev-python/setuptools-scm[${PYTHON_USEDEP}]
	doc? ( media-gfx/graphviz )
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
	dev-python/sphinx-contributors

pkg_postinst() {
	optfeature "using aiofiles to write downloaded data to disk using a separate thread pool" dev-python/aiofiles
}
