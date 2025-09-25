# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="Pytest plugin for testing examples in docstrings and markdown files"
HOMEPAGE="https://github.com/pydantic/pytest-examples"
#SRC_URI="https://github.com/pydantic/pytest-examples/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-python/pytest-7[${PYTHON_USEDEP}]
	>=dev-python/black-23[${PYTHON_USEDEP}]
	>=dev-util/ruff-0.5.0
"

# Thanks parona-overlay
PATCHES=( "${FILESDIR}/${PN}-0.0.14-revert-use-of-ruff-module.patch" )
#	"${FILESDIR}/${PN}-0.0.15-pytest-8.3.4-test-fix.patch"

EPYTEST_PLUGIN_LOAD_VIA_ENV=1
EPYTEST_PLUGINS=( "${PN}" )
distutils_enable_tests pytest

#python_install_all() {
#	if use examples; then
#		docompress -x "/usr/share/doc/${PF}/examples"
#		docinto examples
#		dodoc -r example/.
#	fi
#
#	distutils-r1_python_install_all
#}
