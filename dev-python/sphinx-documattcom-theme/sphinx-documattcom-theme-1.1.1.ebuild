# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="sphinx_reredirects"
MY_PV=1.0.0

DISTUTILS_USE_PEP517=standalone
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="Documattcom Theme for Sphinx documentation projects"
HOMEPAGE="https://github.com/documatt/sphinx-reredirects/tree/main/docs/vendors"
SRC_URI="$(pypi_sdist_url "${MY_PN}" ${MY_PV})"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test"	# No usable test phases

RDEPEND=">=dev-python/sphinx-8.0[${PYTHON_USEDEP}]
	>=dev-python/beautifulsoup4-4.13.3[${PYTHON_USEDEP}]
"

S="${WORKDIR}/${MY_PN}-${MY_PV}"

#distutils_enable_tests nose

python_compile() {
	distutils_wheel_install "${BUILD_DIR}/install" \
		docs/vendors/sphinx_null_theme-0.1.0-py3-none-any.whl
	distutils_wheel_install "${BUILD_DIR}/install" \
		docs/vendors/$(pypi_wheel_name)
}
