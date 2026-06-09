# Copyright 2019-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 optfeature pypi

DESCRIPTION="Python library for the Advanced Scientific Data Format"
HOMEPAGE="https://asdf.readthedocs.io"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="all http intersphinx lz4"
RESTRICT="intersphinx? ( network-sandbox )"
REQUIRED_USE="intersphinx? ( doc )
	all? ( http lz4 )"

RDEPEND=">=dev-python/numpy-1.22[${PYTHON_USEDEP}]
	>=dev-python/attrs-22.2.0[${PYTHON_USEDEP}]
	>=dev-python/asdf-standard-1.1.0[${PYTHON_USEDEP}]
	>=dev-python/jmespath-0.6.2[${PYTHON_USEDEP}]
	>=dev-python/packaging-19.0[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-6.0[${PYTHON_USEDEP}]
	>=dev-python/semantic-version-2.8[${PYTHON_USEDEP}]
	$(python_gen_cond_dep '
		>=dev-python/importlib-metadata-4.11.4[${PYTHON_USEDEP}]
	' python3_10)
	http? (
		>=dev-python/fsspec-2022.8.2[${PYTHON_USEDEP}]
		dev-python/aiohttp[${PYTHON_USEDEP}]
	)
	lz4? ( >=dev-python/lz4-0.10[${PYTHON_USEDEP}] )
"
BDEPEND=">=dev-python/setuptools-scm-8[${PYTHON_USEDEP}]
	doc? ( media-gfx/graphviz )
	test? (
		dev-python/aiohttp[${PYTHON_USEDEP}]
		dev-python/fsspec[${PYTHON_USEDEP}]
		dev-python/lz4[${PYTHON_USEDEP}]
		dev-python/psutil[${PYTHON_USEDEP}]
		dev-python/requests[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=( syrupy )
distutils_enable_tests pytest
distutils_enable_sphinx docs ">=dev-python/sphinx-asdf-0.2.2" dev-python/sphinx-inline-tabs dev-python/furo \
	">=dev-python/mistune-3"

python_test() {
	epytest -Werror::UserWarning #--remote-data
}

pkg_postinst() {
	optfeature "units, time, transform, wcs, or running the tests" ">=dev-python/astropy-3.0"
	optfeature "lz4 compression" ">=dev-python/lz4-0.10"
}
