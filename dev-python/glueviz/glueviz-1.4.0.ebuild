# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="Meta-package for glue and plugin packages"
HOMEPAGE="http://glueviz.org"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc +qt"
RESTRICT="test"	# No usable test phases

RDEPEND=">=dev-python/glue-core-1.13.0[${PYTHON_USEDEP},all]
	>=dev-python/glue-qt-0.1.0[${PYTHON_USEDEP},doc?,qt?]
	>=dev-python/glue-vispy-viewers-1.0.3[${PYTHON_USEDEP}]
"
BDEPEND="dev-python/setuptools-scm[${PYTHON_USEDEP}]"

#distutils_enable_tests nose

python_install_all() {
	use doc && dosym -r /usr/share/doc/glue-qt*/html /usr/share/doc/${PF}/html

	distutils-r1_python_install_all
}
