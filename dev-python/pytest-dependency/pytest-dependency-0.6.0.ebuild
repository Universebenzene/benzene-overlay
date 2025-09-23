# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
#DISTUTILS_USE_SETUPTOOLS=rdepend
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{{11..14},{13..14}t} )
#PYTHON_COMPAT=( python3_{{11..12},{13..14}{,t}} )

inherit distutils-r1 pypi

DESCRIPTION="Manage dependencies of tests"
HOMEPAGE="https://pytest-dependency.readthedocs.io"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

RDEPEND=">=dev-python/pytest-3.7.0[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
"

EPYTEST_PLUGIN_LOAD_VIA_ENV=1
EPYTEST_PLUGINS=( "${PN}" )
distutils_enable_tests pytest

python_install_all() {
	if use examples; then
		docompress -x "/usr/share/doc/${PF}/examples"
		docinto examples
		dodoc -r doc/examples/.
	fi

	distutils-r1_python_install_all
}
