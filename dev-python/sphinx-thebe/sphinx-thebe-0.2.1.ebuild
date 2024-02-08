# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

DESCRIPTION="Integrate interactive code blocks into your documentation with Thebe and Binder"
HOMEPAGE="https://sphinx-thebe.readthedocs.io"
SRC_URI="https://github.com/executablebooks/sphinx-thebe/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="sphinx"

RDEPEND=">=dev-python/sphinx-4[${PYTHON_USEDEP}]
	sphinx? (
		dev-python/matplotlib[${PYTHON_USEDEP}]
		dev-python/myst-nb[${PYTHON_USEDEP}]
		>=dev-python/sphinx-book-theme-0.4.0_rc1[${PYTHON_USEDEP}]
		dev-python/sphinx-copybutton[${PYTHON_USEDEP}]
		dev-python/sphinx-design[${PYTHON_USEDEP}]
	)
"
BDEPEND="test? (
		dev-python/pytest-regressions[${PYTHON_USEDEP}]
		dev-python/matplotlib[${PYTHON_USEDEP}]
		dev-python/myst-nb[${PYTHON_USEDEP}]
		dev-python/sphinx-copybutton[${PYTHON_USEDEP}]
		dev-python/sphinx-design[${PYTHON_USEDEP}]
		dev-python/sphinx-book-theme[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/sphinx-copybutton \
	dev-python/sphinx-design \
	dev-python/sphinx-book-theme \
	dev-python/matplotlib \
	dev-python/myst-nb

python_test() {
	PYTHONPATH="${BUILD_DIR}"/install/$(python_get_sitedir) epytest
}
