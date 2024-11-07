# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 pypi

DESCRIPTION="WebDAV client library with an fsspec-based filesystem and a CLI"
HOMEPAGE="https://skshetry.github.io/webdav4"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="fsspec http2"

RDEPEND="<dev-python/httpx-1[${PYTHON_USEDEP}]
	>=dev-python/python-dateutil-2.8.1[${PYTHON_USEDEP}]
	fsspec? ( >=dev-python/fsspec-2021.7[${PYTHON_USEDEP}] )
	http2? ( <dev-python/h2-5[${PYTHON_USEDEP}] )
"
BDEPEND="dev-python/hatch-vcs[${PYTHON_USEDEP}]
	test? (
		dev-python/cheroot[${PYTHON_USEDEP}]
		dev-python/colorama[${PYTHON_USEDEP}]
		dev-python/fsspec[${PYTHON_USEDEP}]
		dev-python/wsgidav[${PYTHON_USEDEP}]
	)
"

EPYTEST_XDIST=1
distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/sphinx-copybutton dev-python/furo dev-python/myst-parser dev-python/fsspec
