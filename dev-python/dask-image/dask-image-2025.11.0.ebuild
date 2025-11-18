# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="Distributed image processing"
HOMEPAGE="https://image.dask.org"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-python/dask-2024.4.1[${PYTHON_USEDEP}]
	dev-python/pyarrow[${PYTHON_USEDEP}]
	>=dev-python/numpy-1.18[${PYTHON_USEDEP}]
	>=dev-python/pandas-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/pims-0.4.1[${PYTHON_USEDEP}]
	>=dev-python/scipy-1.7.0[${PYTHON_USEDEP}]
	>=dev-python/tifffile-2018.10.18[${PYTHON_USEDEP}]
"

BDEPEND=">=dev-python/setuptools-scm-8[${PYTHON_USEDEP}]"

EPYTEST_PLUGINS=( pytest-timeout )
distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/dask-sphinx-theme

python_prepare_all() {
	sed -i -e '/exclude/a \    "docs*",' -e "/--flake8/d" pyproject.toml || die
	distutils-r1_python_prepare_all
}
