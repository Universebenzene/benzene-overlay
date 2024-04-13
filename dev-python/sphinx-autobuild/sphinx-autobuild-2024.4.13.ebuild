# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{10..12} )

#MY_PV="$(ver_cut 1).$(($(ver_cut 2))).$(($(ver_cut 3)))"
#MY_P="${PN//-/_}-${MY_PV}"

inherit distutils-r1 pypi

DESCRIPTION="Rebuild Sphinx documentation on changes, with live-reload in the browser"
HOMEPAGE="https://github.com/executablebooks/sphinx-autobuild"
#SRC_URI="$(pypi_sdist_url ${PN} ${MY_PV})"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/sphinx[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	>=dev-python/starlette-0.35[${PYTHON_USEDEP}]
	>=dev-python/uvicorn-0.25[${PYTHON_USEDEP}]
	>=dev-python/websockets-11.0[${PYTHON_USEDEP}]
"

#S="${WORKDIR}/${MY_P}"

distutils_enable_tests pytest
