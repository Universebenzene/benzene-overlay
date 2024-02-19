# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=standalone
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1 pypi

DESCRIPTION="A clean book theme for scientific explanations and documentation with Sphinx"
HOMEPAGE="https://sphinx-book-theme.readthedocs.io"
SRC_URI="https://github.com/executablebooks/sphinx-book-theme/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz
	$(pypi_wheel_url)
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="code_style"
RESTRICT="doc? ( network-sandbox )"

RDEPEND=">=dev-python/sphinx-4[${PYTHON_USEDEP}]
	>=dev-python/pydata-sphinx-theme-0.13.3[${PYTHON_USEDEP}]
	code_style? ( dev-vcs/pre-commit )
"
BDEPEND="doc? ( media-fonts/roboto )
	test? (
		dev-python/pytest-regressions[${PYTHON_USEDEP}]
		dev-python/myst-nb[${PYTHON_USEDEP}]
		dev-python/sphinx-thebe[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/sphinx-copybutton \
	dev-python/sphinx-examples \
	dev-python/sphinx-tabs \
	dev-python/sphinx-thebe \
	dev-python/sphinx-togglebutton \
	dev-python/sphinx-design \
	dev-python/sphinxcontrib-bibtex \
	dev-python/sphinxcontrib-youtube \
	dev-python/sphinxext-opengraph \
	dev-python/ablog \
	dev-python/myst-nb \
	dev-python/numpydoc

python_compile() {
	distutils_wheel_install "${BUILD_DIR}/install" \
		"${DISTDIR}/$(pypi_wheel_name)"
}

python_test() {
	PYTHONPATH="${BUILD_DIR}"/install/$(python_get_sitedir) epytest
}
