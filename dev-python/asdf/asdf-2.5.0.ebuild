# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8,9} )

inherit distutils-r1 eutils optfeature

DESCRIPTION="Python library for the Advanced Scientific Data Format"
HOMEPAGE="https://asdf.readthedocs.io"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc"
RESTRICT="!test? ( test )"

RDEPEND="
	>=dev-python/numpy-1.8[${PYTHON_USEDEP}]
	<dev-python/jsonschema-4[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-3.10[${PYTHON_USEDEP}]
	>=dev-python/six-1.9.0[${PYTHON_USEDEP}]
	>=dev-python/semantic_version-2.8[${PYTHON_USEDEP}]
"
BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	doc? (
		${RDEPEND}
		>=dev-python/astropy-3.0[${PYTHON_USEDEP}]
		dev-python/sphinx-astropy[${PYTHON_USEDEP}]
	)
	test? (
		${RDEPEND}
		>=dev-python/astropy-3.0[${PYTHON_USEDEP}]
		dev-python/pytest-astropy[${PYTHON_USEDEP}]
		dev-python/importlib_resources[${PYTHON_USEDEP}]
	)
"

PATCHES=(
	"${FILESDIR}"/${P}-Disable-test-that-require-http-server.patch
)

distutils_enable_tests pytest
distutils_enable_sphinx docs --no-autodoc

pkg_postinst() {
	optfeature "Support for units, time, transform, wcs, or running the tests"	dev-python/astropy
	optfeature "Support for lz4 compression"									dev-python/lz4
}
