# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_VERIFY_REPO=https://github.com/xarray-contrib/sphinx-autosummary-accessors
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1 pypi

DESCRIPTION="Sphinx autosummary extension to properly format pandas or xarray accessors"
HOMEPAGE="https://sphinx-autosummary-accessors.readthedocs.io"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-python/sphinx-6[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
"
BDEPEND=">=dev-python/setuptools-scm-8.0[${PYTHON_USEDEP}]"

distutils_enable_tests import-check
distutils_enable_sphinx docs dev-python/pydata-sphinx-theme

python_prepare_all() {
	use doc && { sed -i -e "/pixi/d" docs/conf.py || die ; }

	distutils-r1_python_prepare_all
}
