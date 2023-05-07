# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1 pypi

DESCRIPTION="Python binding for the freetype library"
HOMEPAGE="http://freetype-py.readthedocs.org"
SRC_URI="$(pypi_sdist_url --no-normalize "${PN}" "${PV}" .zip)"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="media-libs/freetype:2"
RDEPEND="${DEPEND}"
BDEPEND="dev-python/setuptools-scm[${PYTHON_USEDEP}]
	app-arch/unzip
"

distutils_enable_tests pytest
distutils_enable_sphinx doc dev-python/sphinx-rtd-theme

python_test() {
	epytest tests
}
